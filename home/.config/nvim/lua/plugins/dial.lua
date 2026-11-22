return {
    "monaqa/dial.nvim",
    opts = function()
        local augend = require("dial.augend")

        local logical_alias = augend.constant.new({
            elements = { "&&", "||" },
            word = false,
            cyclic = true,
        })

        local ordinal_numbers = augend.constant.new({
            -- elements through which we cycle. When we increment, we go down
            -- On decrement we go up
            elements = {
                "first",
                "second",
                "third",
                "fourth",
                "fifth",
                "sixth",
                "seventh",
                "eighth",
                "ninth",
                "tenth",
            },
            -- if true, it only matches strings with word boundary. firstDate wouldn't work for example
            word = false,
            -- do we cycle back and forth (tenth to first on increment, first to tenth on decrement).
            -- Otherwise nothing will happen when there are no further values
            cyclic = true,
        })

        local months = augend.constant.new({
            elements = {
                "January",
                "February",
                "March",
                "April",
                "May",
                "June",
                "July",
                "August",
                "September",
                "October",
                "November",
                "December",
            },
            word = true,
            cyclic = true,
        })

        -- === Programming word pairs ===
        -- Each pair below is its own augend so you can drop individual ones
        -- into different filetype groups if you want. word = true means only
        -- whole-word matches toggle (so "input" won't turn into "output" mid-word
        -- unless the whole token matches).

        local vim_emacs = augend.constant.new({
            elements = { "vim", "emacs" },
            word = true,
            cyclic = true,
        })

        local yes_no = augend.constant.new({
            elements = { "yes", "no" },
            word = true,
            cyclic = true,
        })

        local on_off = augend.constant.new({
            elements = { "on", "off" },
            word = true,
            cyclic = true,
        })

        local enable_disable = augend.constant.new({
            elements = { "enable", "disable" },
            word = true,
            cyclic = true,
        })

        local enabled_disabled = augend.constant.new({
            elements = { "enabled", "disabled" },
            word = true,
            cyclic = true,
        })

        local show_hide = augend.constant.new({
            elements = { "show", "hide" },
            word = true,
            cyclic = true,
        })

        local visible_hidden = augend.constant.new({
            elements = { "visible", "hidden" },
            word = true,
            cyclic = true,
        })

        local active_inactive = augend.constant.new({
            elements = { "active", "inactive" },
            word = true,
            cyclic = true,
        })

        local valid_invalid = augend.constant.new({
            elements = { "valid", "invalid" },
            word = true,
            cyclic = true,
        })

        local success_failure = augend.constant.new({
            elements = { "success", "failure" },
            word = true,
            cyclic = true,
        })

        local pass_fail = augend.constant.new({
            elements = { "pass", "fail" },
            word = true,
            cyclic = true,
        })

        local get_set = augend.constant.new({
            elements = { "get", "set" },
            word = true,
            cyclic = true,
        })

        local read_write = augend.constant.new({
            elements = { "read", "write" },
            word = true,
            cyclic = true,
        })

        local push_pop = augend.constant.new({
            elements = { "push", "pop" },
            word = true,
            cyclic = true,
        })

        local create_delete = augend.constant.new({
            elements = { "create", "delete" },
            word = true,
            cyclic = true,
        })

        local add_remove = augend.constant.new({
            elements = { "add", "remove" },
            word = true,
            cyclic = true,
        })

        local insert_delete = augend.constant.new({
            elements = { "insert", "delete" },
            word = true,
            cyclic = true,
        })

        local lock_unlock = augend.constant.new({
            elements = { "lock", "unlock" },
            word = true,
            cyclic = true,
        })

        local open_close = augend.constant.new({
            elements = { "open", "close" },
            word = true,
            cyclic = true,
        })

        local connect_disconnect = augend.constant.new({
            elements = { "connect", "disconnect" },
            word = true,
            cyclic = true,
        })

        local start_stop = augend.constant.new({
            elements = { "start", "stop" },
            word = true,
            cyclic = true,
        })

        local begin_end = augend.constant.new({
            elements = { "begin", "end" },
            word = true,
            cyclic = true,
        })

        local startup_shutdown = augend.constant.new({
            elements = { "startup", "shutdown" },
            word = true,
            cyclic = true,
        })

        local load_unload = augend.constant.new({
            elements = { "load", "unload" },
            word = true,
            cyclic = true,
        })

        local mount_unmount = augend.constant.new({
            elements = { "mount", "unmount" },
            word = true,
            cyclic = true,
        })

        local subscribe_unsubscribe = augend.constant.new({
            elements = { "subscribe", "unsubscribe" },
            word = true,
            cyclic = true,
        })

        local import_export = augend.constant.new({
            elements = { "import", "export" },
            word = true,
            cyclic = true,
        })

        local encode_decode = augend.constant.new({
            elements = { "encode", "decode" },
            word = true,
            cyclic = true,
        })

        local encrypt_decrypt = augend.constant.new({
            elements = { "encrypt", "decrypt" },
            word = true,
            cyclic = true,
        })

        local compress_decompress = augend.constant.new({
            elements = { "compress", "decompress" },
            word = true,
            cyclic = true,
        })

        local pack_unpack = augend.constant.new({
            elements = { "pack", "unpack" },
            word = true,
            cyclic = true,
        })

        local serialize_deserialize = augend.constant.new({
            elements = { "serialize", "deserialize" },
            word = true,
            cyclic = true,
        })

        local freeze_unfreeze = augend.constant.new({
            elements = { "freeze", "unfreeze" },
            word = true,
            cyclic = true,
        })

        local pause_resume = augend.constant.new({
            elements = { "pause", "resume" },
            word = true,
            cyclic = true,
        })

        local min_max = augend.constant.new({
            elements = { "min", "max" },
            word = true,
            cyclic = true,
        })

        local first_last = augend.constant.new({
            elements = { "first", "last" },
            word = true,
            cyclic = true,
        })

        local head_tail = augend.constant.new({
            elements = { "head", "tail" },
            word = true,
            cyclic = true,
        })

        local parent_child = augend.constant.new({
            elements = { "parent", "child" },
            word = true,
            cyclic = true,
        })

        local ascending_descending = augend.constant.new({
            elements = { "ascending", "descending" },
            word = true,
            cyclic = true,
        })

        local asc_desc = augend.constant.new({
            elements = { "asc", "desc" },
            word = true,
            cyclic = true,
        })

        local up_down = augend.constant.new({
            elements = { "up", "down" },
            word = true,
            cyclic = true,
        })

        local left_right = augend.constant.new({
            elements = { "left", "right" },
            word = true,
            cyclic = true,
        })

        local top_bottom = augend.constant.new({
            elements = { "top", "bottom" },
            word = true,
            cyclic = true,
        })

        local prev_next = augend.constant.new({
            elements = { "prev", "next" },
            word = true,
            cyclic = true,
        })

        local previous_next = augend.constant.new({
            elements = { "previous", "next" },
            word = true,
            cyclic = true,
        })

        local forward_backward = augend.constant.new({
            elements = { "forward", "backward" },
            word = true,
            cyclic = true,
        })

        local input_output = augend.constant.new({
            elements = { "input", "output" },
            word = true,
            cyclic = true,
        })

        local in_out = augend.constant.new({
            elements = { "in", "out" },
            word = true,
            cyclic = true,
        })

        local ingress_egress = augend.constant.new({
            elements = { "ingress", "egress" },
            word = true,
            cyclic = true,
        })

        local dev_prod = augend.constant.new({
            elements = { "dev", "prod" },
            word = true,
            cyclic = true,
        })

        local debug_release = augend.constant.new({
            elements = { "debug", "release" },
            word = true,
            cyclic = true,
        })

        local sync_async = augend.constant.new({
            elements = { "sync", "async" },
            word = true,
            cyclic = true,
        })

        local public_private = augend.constant.new({
            elements = { "public", "private" },
            word = true,
            cyclic = true,
        })

        local static_dynamic = augend.constant.new({
            elements = { "static", "dynamic" },
            word = true,
            cyclic = true,
        })

        local client_server = augend.constant.new({
            elements = { "client", "server" },
            word = true,
            cyclic = true,
        })

        local request_response = augend.constant.new({
            elements = { "request", "response" },
            word = true,
            cyclic = true,
        })

        local source_destination = augend.constant.new({
            elements = { "source", "destination" },
            word = true,
            cyclic = true,
        })

        local src_dst = augend.constant.new({
            elements = { "src", "dst" },
            word = true,
            cyclic = true,
        })

        local local_remote = augend.constant.new({
            elements = { "local", "remote" },
            word = true,
            cyclic = true,
        })

        local old_new = augend.constant.new({
            elements = { "old", "new" },
            word = true,
            cyclic = true,
        })

        local before_after = augend.constant.new({
            elements = { "before", "after" },
            word = true,
            cyclic = true,
        })

        -- collect them all so it's easy to add to any group
        local programming_inverses = {
            vim_emacs,
            yes_no,
            on_off,
            enable_disable,
            enabled_disabled,
            show_hide,
            visible_hidden,
            active_inactive,
            valid_invalid,
            success_failure,
            pass_fail,
            get_set,
            read_write,
            push_pop,
            create_delete,
            add_remove,
            insert_delete,
            lock_unlock,
            open_close,
            connect_disconnect,
            start_stop,
            begin_end,
            startup_shutdown,
            load_unload,
            mount_unmount,
            subscribe_unsubscribe,
            import_export,
            encode_decode,
            encrypt_decrypt,
            compress_decompress,
            pack_unpack,
            serialize_deserialize,
            freeze_unfreeze,
            pause_resume,
            min_max,
            first_last,
            head_tail,
            parent_child,
            ascending_descending,
            asc_desc,
            up_down,
            left_right,
            top_bottom,
            prev_next,
            previous_next,
            forward_backward,
            input_output,
            in_out,
            ingress_egress,
            dev_prod,
            debug_release,
            sync_async,
            public_private,
            static_dynamic,
            client_server,
            request_response,
            source_destination,
            src_dst,
            local_remote,
            old_new,
            before_after,
        }

        return {
            dials_by_ft = {
                css = "css",
                vue = "vue",
                javascript = "typescript",
                typescript = "typescript",
                typescriptreact = "typescript",
                javascriptreact = "typescript",
                json = "json",
                lua = "lua",
                markdown = "markdown",
                sass = "css",
                scss = "css",
                python = "python",
            },
            groups = {
                default = vim.list_extend({
                    augend.integer.alias.decimal,          -- nonnegative decimal number (0, 1, 2, 3, ...)
                    augend.integer.alias.decimal_int,      -- nonnegative and negative decimal number
                    augend.integer.alias.hex,              -- nonnegative hex number  (0x01, 0x1a1f, etc.)
                    augend.date.alias["%Y/%m/%d"],         -- date (2022/02/19, etc.)
                    augend.constant.alias.en_weekday,      -- Mon, Tue, ..., Sat, Sun
                    augend.constant.alias.en_weekday_full, -- Monday, Tuesday, ..., Saturday, Sunday
                    ordinal_numbers,
                    months,
                    augend.constant.alias.bool, -- boolean value (true <-> false)
                    augend.constant.alias.Bool, -- boolean value (True <-> False)
                    logical_alias,
                }, programming_inverses),
                vue = {
                    augend.constant.new({ elements = { "let", "const" } }),
                    augend.hexcolor.new({ case = "lower" }),
                    augend.hexcolor.new({ case = "upper" }),
                },
                typescript = {
                    augend.constant.new({ elements = { "let", "const" } }),
                },
                css = {
                    augend.hexcolor.new({
                        case = "lower",
                    }),
                    augend.hexcolor.new({
                        case = "upper",
                    }),
                },
                markdown = {
                    augend.constant.new({
                        elements = { "[ ]", "[x]" },
                        word = false,
                        cyclic = true,
                    }),
                    augend.misc.alias.markdown_header,
                },
                json = {
                    augend.semver.alias.semver, -- versioning (v1.1.2)
                },
                lua = {
                    augend.constant.new({
                        elements = { "and", "or" },
                        word = true,   -- if false, "sand" is incremented into "sor", "doctor" into "doctand", etc.
                        cyclic = true, -- "or" is incremented into "and".
                    }),
                },
                python = {
                    augend.constant.new({
                        elements = { "and", "or" },
                    }),
                },
            },
        }
    end,
    config = function(_, opts)
        -- copy defaults to each group
        for name, group in pairs(opts.groups) do
            if name ~= "default" then
                vim.list_extend(group, opts.groups.default)
            end
        end
        require("dial.config").augends:register_group(opts.groups)
        vim.g.dials_by_ft = opts.dials_by_ft

        vim.keymap.set("n", "<C-a>", function()
            require("dial.map").manipulate("increment", "normal")
        end)
        vim.keymap.set("n", "<C-x>", function()
            require("dial.map").manipulate("decrement", "normal")
        end)
        vim.keymap.set("n", "g<C-a>", function()
            require("dial.map").manipulate("increment", "gnormal")
        end)
        vim.keymap.set("n", "g<C-x>", function()
            require("dial.map").manipulate("decrement", "gnormal")
        end)
        vim.keymap.set("x", "<C-a>", function()
            require("dial.map").manipulate("increment", "visual")
        end)
        vim.keymap.set("x", "<C-x>", function()
            require("dial.map").manipulate("decrement", "visual")
        end)
        vim.keymap.set("x", "g<C-a>", function()
            require("dial.map").manipulate("increment", "gvisual")
        end)
        vim.keymap.set("x", "g<C-x>", function()
            require("dial.map").manipulate("decrement", "gvisual")
        end)
    end,
}
