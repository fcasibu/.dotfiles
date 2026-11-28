// https://github.com/Crackerfracks/Synesthaxia.glsl/blob/main/cursor_synesthaxia(tweened).glsl
/* ───── Tunables ──────────────────────────────────────────────────────── */
const float DURATION       = 0.15;   // Smear tween time (seconds)
const float TRAIL_OPACITY  = 0.55;   // Max opacity of the smear trail
const float CURVE_STRENGTH = 0.00;   // -: concave  +: convex
const float EDGE_SOFT      = 0.0015; // Trail AA width in NDC units
const float GLOW_RADIUS    = 0.0;    // Halo thickness around mode shape (px)
const float GLOW_INTENSITY = 0.0;   // Halo opacity multiplier
/* ─────────────────────────────────────────────────────────────────────── */

vec3 sRGBToLinear(vec3 c) {
  return mix(c / 12.92, pow((c + 0.055) / 1.055, vec3(2.4)), step(vec3(0.04045), c));
}

vec2 ndc(vec2 px, float isPos) {
  return (px * 2.0 - iResolution.xy * isPos) / iResolution.y;
}

float cover(float sd) {
  return clamp(0.5 - sd / EDGE_SOFT, 0.0, 1.0);
}

float easeOutCubic(float t) {
  return 1.0 - pow(1.0 - t, 3.0);
}

float sdRoundedBox(vec2 p, vec2 b, float r) {
  vec2 q = abs(p) - b + r;
  return length(max(q, 0.0)) + min(max(q.x, q.y), 0.0) - r;
}

/* Signed distance to parallelogram (v0->v1->v2->v3, NDC) */
float sdPara(vec2 p, vec2 v0, vec2 v1, vec2 v2, vec2 v3) {
  float w = 1.0;
  float d2 = dot(p - v0, p - v0);
  #define EDGE(A, B)                                                             \
  {                                                                              \
      vec2 e = B - A, wv = p - A;                                                \
      float ee = max(dot(e, e), 1e-8);                                           \
      vec2 proj = A + e * clamp(dot(wv, e) / ee, 0.0, 1.0);                      \
      d2 = min(d2, dot(p - proj, p - proj));                                     \
      float c0 = step(0.0, p.y - A.y);                                           \
      float c1 = 1.0 - step(0.0, p.y - B.y);                                     \
      float c2 = 1.0 - step(0.0, e.x * wv.y - e.y * wv.x);                       \
      float flip = mix(1.0, -1.0, step(0.5, c0 * c1 * c2 +                       \
                                       (1.0 - c0) * (1.0 - c1) * (1.0 - c2)));   \
      w *= flip;                                                                 \
  }
  EDGE(v0, v1)
  EDGE(v1, v2)
  EDGE(v2, v3)
  EDGE(v3, v0)
  #undef EDGE
  return w * sqrt(d2);
}

/* Pick edge whose outward normal matches (leading) or opposes (trailing) motion.
 * Ghostty uses Y-up pixel coords where r.xy is top-left and r.zw is (width, height). */
void pickEdge(vec4 r, vec2 dir, bool leading, out vec2 aPx, out vec2 bPx) {
  vec2 N[4] = vec2[4](vec2(-1, 0), vec2(1, 0), vec2(0, 1), vec2(0, -1));
  float best = leading ? -1e9 : 1e9;
  int idx = 0;
  for (int i = 0; i < 4; ++i) {
      float d = dot(dir, N[i]);
      if (leading ? d > best : d < best) {
          best = d;
          idx = i;
      }
  }
  vec2 TL = r.xy;
  vec2 TR = TL + vec2(r.z, 0.0);
  vec2 BL = TL - vec2(0.0, r.w);
  vec2 BR = TL + vec2(r.z, -r.w);

  if (idx == 0) {
      aPx = TL; bPx = BL; // Left
  } else if (idx == 1) {
      aPx = TR; bPx = BR; // Right
  } else if (idx == 2) {
      aPx = TL; bPx = TR; // Top
  } else {
      aPx = BL; bPx = BR; // Bottom
  }
}

/* Custom SDF + color per Neovim cursor style */
void evalModeShape(vec2 p, vec2 halfSize, int style, out float sd, out vec3 color) {
  if (style == CURSORSTYLE_BLOCK) {
      vec2 ap = abs(p);
      float t = 2.0;
      float cornerLen = min(6.0, min(halfSize.x, halfSize.y) * 0.75);

      float dOuter  = max(ap.x - halfSize.x, ap.y - halfSize.y);
      float dInner  = max(ap.x - (halfSize.x - t), ap.y - (halfSize.y - t));
      float dFrame  = max(dOuter, -dInner);
      float dCorner = -min(ap.x - (halfSize.x - cornerLen), ap.y - (halfSize.y - cornerLen));

      sd = max(dFrame, dCorner);
  } else if (style == CURSORSTYLE_BAR) {
      vec2 b = vec2(max(halfSize.x, 1.75), halfSize.y);
      sd = sdRoundedBox(p, b, min(b.x, b.y));

  } else if (style == CURSORSTYLE_UNDERLINE) {
      float lift = max(0.0, 3.0 - abs(p.x) * 0.45);
      vec2 cp = vec2(p.x, p.y - lift * 0.5);
      vec2 b = vec2(halfSize.x, max(halfSize.y, 1.5) + lift * 0.5);
      sd = sdRoundedBox(cp, b, 1.0);
  }

  color = sRGBToLinear(vec3(0.851, 0.627, 0.357));
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
  vec4 base = texture(iChannel0, fragCoord / iResolution.xy);
  fragColor = base;

  if (iCursorVisible == 0 || iCurrentCursorStyle == CURSORSTYLE_LOCK) {
      return;
  }

  vec4 cur = iCurrentCursor;
  vec4 prv = iPreviousCursor;
  vec2 dirPx = cur.xy - prv.xy;

  float rawProg = clamp((iTime - iTimeCursorChange) / DURATION, 0.0, 1.0);
  float headProg = easeOutCubic(rawProg);
  float tailProg = rawProg * rawProg; // Lags behind head, then catches up smoothly

  vec4 headRect = mix(prv, cur, headProg);
  vec4 tailRect = mix(prv, cur, tailProg);

  // 1. Evaluate custom mode cursor at tweened head position
  vec2 headHalf   = headRect.zw * 0.5;
  vec2 headCenter = headRect.xy + vec2(headHalf.x, -headHalf.y);
  float sdCursor;
  vec3 modeColor;
  evalModeShape(fragCoord - headCenter, headHalf, iCurrentCursorStyle, sdCursor, modeColor);

  float covCursor = 1.0 - smoothstep(-0.6, 0.6, sdCursor);
  float covGlow   = exp(-max(sdCursor, 0.0) / max(GLOW_RADIUS, 0.1))
                  * (1.0 - covCursor) * GLOW_INTENSITY;

  if (iCurrentCursorStyle == CURSORSTYLE_BLOCK_HOLLOW) {
      covCursor *= 0.6;
      covGlow = 0.0;
  }

  // 2. Evaluate swept smear trail between trailing edge of tailRect & leading edge of headRect
  float covTrail = 0.0;
  if (dot(dirPx, dirPx) > 0.25 && rawProg < 1.0 && iCurrentCursorStyle != CURSORSTYLE_BLOCK_HOLLOW) {
      vec2 p0, p1, q0, q1;
      pickEdge(tailRect, dirPx, false, p0, p1);
      pickEdge(headRect, dirPx, true,  q0, q1);

      vec2 v0 = ndc(p0, 1.0), v1 = ndc(p1, 1.0);
      vec2 v2 = ndc(q1, 1.0), v3 = ndc(q0, 1.0);
      vec2 P  = ndc(fragCoord, 1.0);

      float sdTrail = sdPara(P, v0, v1, v2, v3);
      vec2 span = v3 - v0;
      float spanLen = length(span);
      float tAlong = (spanLen > 1e-5)
          ? clamp(dot(P - v0, span / spanLen) / spanLen, 0.0, 1.0)
          : 1.0;

      sdTrail /= (1.0 + CURVE_STRENGTH * (tAlong - 0.5) * 2.0);

      // Taper trail opacity from tail (0) to head (1) and fade as animation finishes
      float trailFade = smoothstep(0.0, 0.85, tAlong) * (1.0 - smoothstep(0.65, 1.0, rawProg));
      covTrail = cover(sdTrail) * TRAIL_OPACITY * trailFade;
  }

  // 3. Premultiplied Porter-Duff composite (preserves background-opacity = 0.9)
  vec3 outRGB = base.rgb;
  float outA  = base.a;

  outRGB = mix(outRGB, modeColor, covTrail);
  outA   = mix(outA, 1.0, covTrail);

  outRGB = mix(outRGB, modeColor, covGlow);
  outA   = mix(outA, 1.0, covGlow);

  outRGB = mix(outRGB, modeColor, covCursor);
  outA   = mix(outA, 1.0, covCursor);

  fragColor = vec4(outRGB, outA);
}
