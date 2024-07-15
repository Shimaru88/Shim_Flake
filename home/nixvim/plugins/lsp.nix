{ config, pkgs, inputs, ... }:

{
  programs.nixvim = {
    plugins.cmp-nvim-lsp = {
      enable = true;
    };

    plugins.fidget = {
      enable = true;
    };

    extraPlugins = with pkgs.vimPlugins; [
      neodev-nvim
    ];

    extraConfigLuaPre = ''
      require('neodev').setup {}
    '';

    autoGroups = {
      "kickstart-lsp-attach" = {
        clear = true;
      };
    };

    plugins.lsp = {
      enable = true;

     servers = {
        gopls = {
          enable = true;
        };

        rust_analyzer = {
          enable = true;
        };

        lua-ls = {
          enable = true;

         settings = {
            completion = {
              callSnippet = "Replace";
            };
         };
        };
      };

      keymaps = {
        diagnostic = {
          "[d" = {
            #mode = "n";
            action = "goto_prev";
            desc = "Go to previous [D]iagnostic message";
          };
          "]d" = {
            #mode = "n";
            action = "goto_next";
            desc = "Go to next [D]iagnostic message";
          };
          "<leader>e" = {
            #mode = "n";
            action = "open_float";
            desc = "Show diagnostic [E]rror messages";
          };
          "<leader>q" = {
            #mode = "n";
            action = "setloclist";
            desc = "Open diagnostic [Q]uickfix list";
          };
        };

        extra = [
          {
            mode = "n";
            key = "gd";
            action.__raw = "require('telescope.builtin').lsp_definitions";
            options = {
              desc = "LSP: [G]oto [D]efinition";
            };
          }
          {
            mode = "n";
            key = "gr";
            action.__raw = "require('telescope.builtin').lsp_references";
            options = {
              desc = "LSP: [G]oto [R]eferences";
            };
          }
          {
            mode = "n";
            key = "gI";
            action.__raw = "require('telescope.builtin').lsp_implementations";
            options = {
              desc = "LSP: [G]oto [I]mplementation";
            };
          }
          {
            mode = "n";
            key = "<leader>D";
            action.__raw = "require('telescope.builtin').lsp_type_definitions";
            options = {
              desc = "LSP: Type [D]efinition";
            };
          }
          {
            mode = "n";
            key = "<leader>ds";
            action.__raw = "require('telescope.builtin').lsp_document_symbols";
            options = {
              desc = "LSP: [D]ocument [S]ymbols";
            };
          }
          {
            mode = "n";
            key = "<leader>ws";
            action.__raw = "require('telescope.builtin').lsp_dynamic_workspace_symbols";
            options = {
              desc = "LSP: [W]orkspace [S]ymbols";
            };
          }
        ];

        lspBuf = {
          "<leader>rn" = {
            mode = "n"; TODO: FIGURE OUT HOW TO SET THIS
            action = "rename";
            desc = "LSP: [R]e[n]ame";
          };
          "<leader>ca" = {
            mode = "n";
            action = "code_action";
            desc = "LSP: [C]ode [A]ction";
          };
          "K" = {
            action = "hover";
            desc = "LSP: Hover Documentation";
          };
          "gD" = {
            action = "declaration";
            desc = "LSP: [G]oto [D]eclaration";
          };
        };
      };

     onAttach = ''
       local map = function(keys, func, desc)
          vim.keymap.set('n', keys, func, { buffer = bufnr, desc = 'LSP: ' .. desc })
        end

       if client and client.server_capabilities.documentHighlightProvider then
          local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
          vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            buffer = bufnr,
            group = highlight_augroup,
            callback = vim.lsp.buf.document_highlight,
          })

          vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
            buffer = bufnr,
            group = highlight_augroup,
            callback = vim.lsp.buf.clear_references,
          })

          vim.api.nvim_create_autocmd('LspDetach', {
            group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
            callback = function(event2)
              vim.lsp.buf.clear_references()
              vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
            end,
          })
        end

       if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
          map('<leader>th', function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
          end, '[T]oggle Inlay [H]ints')
        end
      '';
    };
  };
}
