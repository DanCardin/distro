vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)

    vim.diagnostic.config({
      virtual_text = false,
      virtual_lines = false,
      float = false,
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = "", --
          [vim.diagnostic.severity.WARN] = "", --
          [vim.diagnostic.severity.INFO] = "",
          [vim.diagnostic.severity.HINT] = "", --
        },
      },
      severity_sort = true,
    })

    if client then
      local supportsInlay = client.server_capabilities.inlayHintProvider
      if supportsInlay and vim.lsp.inlay_hint ~= nil then
        vim.lsp.inlay_hint.enable()
      end

      require("lsp-format").on_attach(client)
    end

    local actions_preview = require("tiny-code-action").code_action
    local telescope = require("telescope.builtin")

    local opts = { noremap = true, buffer = true }
    vim.keymap.set("n", "gD", telescope.lsp_definitions, opts)
    vim.keymap.set("n", "gd", telescope.lsp_definitions, opts)
    vim.keymap.set("n", "gt", telescope.lsp_type_definitions, opts)
    vim.keymap.set("n", "gr", telescope.lsp_references, opts)
    vim.keymap.set("n", "gi", telescope.lsp_implementations, opts)
    vim.keymap.set("n", "gs", telescope.lsp_document_symbols, opts)
    vim.keymap.set("n", "gws", telescope.lsp_workspace_symbols, opts)
    vim.keymap.set("n", "<leader>k", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<leader>K", vim.lsp.buf.signature_help, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "<tab>", actions_preview, opts)

    vim.keymap.set("n", "<leader>p", function() vim.diagnostic.jump({ count = -1, float = false }) end, opts)
    vim.keymap.set("n", "<leader>n", function() vim.diagnostic.jump({ count = 1, float = false }) end, opts)
  end
})

return {
  setup = function()
    vim.g.markdown_fenced_languages = {
      "ts=typescript",
    }

    vim.lsp.config("taplo", { cmd = { "taplo", "lsp", "-c", vim.fn.expand("$HOME/.config/taplo.toml"), "stdio" } })
    vim.lsp.config("yamlls", {
      settings = {
        yaml = {
          format = {
            enable = false,
            printWidth = 100,
          },
        },
      },
    })
    vim.lsp.config("lua_ls", {
      on_init = function(client)
        local path = client.workspace_folders[1].name
        if vim.loop.fs_stat(path .. "/.luarc.json") or vim.loop.fs_stat(path .. "/.luarc.jsonc") then
          return
        end

        client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
          runtime = {
            version = "LuaJIT",
          },
          workspace = {
            checkThirdParty = false,
            library = {
              vim.env.VIMRUNTIME,
            },
          },
        })
      end,
      settings = {
        Lua = {},
      },
    })
    vim.lsp.config("rust_analyzer", {
      cmd = { "rustup", "run", "nightly", "rust-analyzer" },
      settings = {
        ["rust-analyzer"] = {
          checkOnSave = {
            command = "clippy",
            extraArgs = "--target-dir /tmp/rust-analyzer-check",
          },
          imports = {
            granularity = {
              group = "module",
            },
            prefix = "self",
          },
          cargo = {
            loadOutDirsFromCheck = true,
            buildScripts = {
              enable = true,
            },
          },
          procMacro = {
            enable = true,
          },
          diagnostics = { disabled = { "unresolved-proc-macro" } },
        },
      },
    })
    vim.lsp.config("basedpyright", {
      flags = {
        debounce_text_changes = 500,
      },
      settings = {
        basedpyright = {
          disableOrganizeImports = true,
          analysis = {
            autoSearchPaths = true,
            diagnosticMode = "openFilesOnly",
            typeCheckingMode = "standard",
            useLibraryCodeForTypes = true,
            inlayHints = {
              variableTypes = false,     -- conflicts with ty
              callArgumentNames = false, -- conflicts with ty
              functionReturnTypes = false,
              genericTypes = false,      -- conflicts with ty
            },
          },
        },
      },
    })
    vim.lsp.config("vue_ls", {
      filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue", "json" },
      cmd = { "vue-language-server", "--stdio" },
    })
    vim.lsp.config("ts_ls", {
      init_options = {
        plugins = {
          {
            name = "@vue/typescript-plugin",
            location = "/opt/homebrew/lib/node_modules/@vue/typescript-plugin",
            languages = { "javascript", "typescript", "vue" },
          },
        },
      },
      filetypes = {
        "javascript",
        "typescript",
        "vue",
      },
    })
    vim.lsp.config("jsonls", {
      cmd = { "vscode-json-language-server", "--stdio" },
    })
    vim.lsp.config("ruff", {
      init_options = {
        settings = {
          lint = {
            ignore = { "E501" },
          },
        },
      },
      cmd = { "ruff", "server", "--preview" },
    })

    vim.lsp.enable("eslint")
    vim.lsp.enable("html")
    vim.lsp.enable("tinymist")
    vim.lsp.enable("bashls")
    vim.lsp.enable("typos_lsp")
    vim.lsp.enable("taplo")
    vim.lsp.enable("yamlls")
    vim.lsp.enable("markdown_oxide")
    vim.lsp.enable("lua_ls")
    vim.lsp.enable("rust_analyzer")
    vim.lsp.enable("vue_ls")
    vim.lsp.enable("ts_ls")
    vim.lsp.enable("jsonls")

    vim.lsp.enable("ruff")
    vim.lsp.enable("ty")
    -- vim.lsp.enable("basedpyright")
    -- vim.lsp.enable('zuban')
    --
    vim.lsp.log.set_level("warn")
  end
}
