{
  config,
  pkgs,
  inputs,
  ...
}: {
  programs.neovim = let
    toLua = str: ''
      lua << EOF
      ${str}
      EOF
    '';
    toLuaFile = file: ''
      lua << EOF
      ${builtins.readFile file}
      EOF
    '';
  in {
    enable = true;
    # package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    extraPackages = with pkgs; [
      nixd
      stylua
      lazygit
      prettierd
      eslint_d
      biome
      nodePackages_latest.typescript-language-server
      typescript
      lua-language-server
      # ccls
      nodePackages.bash-language-server
      #nodePackages.pyright
      vscode-extensions.vadimcn.vscode-lldb
      nixfmt
      astyle
      # clang-tools
    ];

    plugins = with pkgs.vimPlugins; [
      # {
      #   plugin = autosave-nvim;
      #   config = toLua "require('autosave').setup{}";
      # }

      lazygit-nvim
      {
        plugin = gitsigns-nvim;
        config = toLuaFile ./lua/plugins/gitsigns.lua;
      }

      {
        plugin = trouble-nvim;
        config = toLua "require('trouble').setup{}";
      }
      {
        plugin = surround-nvim;
        config = toLua "require('surround').setup{mappings_style = 'surround'}";
      }
      {
        plugin = nvim-autopairs;
        config = toLuaFile ./lua/plugins/autopairs.lua;
      }
      {
        plugin = substitute-nvim;
        config = toLua "require('substitute').setup()";
      }
      cmp-nvim-lsp
      nvim-autopairs
      lspkind-nvim
      {
        plugin = indent-blankline-nvim;
        config = toLua "require('ibl').setup({indent = { char = '┊' }})";
      }

      {
        plugin = alpha-nvim;
        config = toLuaFile ./lua/plugins/alpha.lua;
      }

      {
        plugin = nvim-lspconfig;
        config = toLuaFile ./lua/plugins/lsp.lua;
      }

      {
        plugin = nvim-dap-ui;
        config = toLuaFile ./lua/plugins/dap-ui.lua;
      }

      {
        plugin = nvim-dap;
        config = toLua ''
          local dap = require('dap')
          dap.adapters.codelldb = {
              type = 'server',
              port = "''${port}",
              executable = {
                  command = '${pkgs.vscode-extensions.vadimcn.vscode-lldb}/share/vscode/extensions/vadimcn.vscode-lldb/adapter/codelldb',
                  args = {'--port', "''${port}"},
              }
          }
          dap.configurations.c = {
            {
              name = "Launch file",
              type = "codelldb",
              request = "launch",
              program = function()
                return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
              end,
              cwd = "''${workspaceFolder}",
              stopOnEntry = false,
            },
            {
              name = "Args",
              type = "codelldb",
              request = "launch",
              program = function()
                return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
              end,
              args = function()
                local args_string = vim.fn.input('Arguments: ')
                return vim.split(args_string, " +")
              end,
              cwd = "''${workspaceFolder}",
              stopOnEntry = false,
            },
          }
        '';
      }
      plenary-nvim
      {
        plugin = todo-comments-nvim;
        config = toLua "require('todo-comments').setup()";
      }
      vim-tmux-navigator
      harpoon
      # header_42_vim
      undotree
      neodev-nvim
      cmp_luasnip
      cmp-nvim-lsp
      luasnip
      friendly-snippets
      vim-nix
      vim-fugitive
      # norminette-vim
      {
        plugin = nvim-colorizer-lua;
        config = toLua "require('colorizer').setup()";
      }
      {
        plugin = nvim-cmp;
        config = toLuaFile ./lua/plugins/cmp.lua;
      }
      {
        plugin = conform-nvim;
        config = toLuaFile ./lua/plugins/conform.lua;
      }
      {
        plugin = kanagawa-nvim;
        config = toLuaFile ./lua/plugins/kanagawa.lua;
      }
      {
        plugin = nvim-treesitter.withAllGrammars;
        config = toLuaFile ./lua/plugins/treesitter.lua;
      }
      {
        plugin = telescope-nvim;
        config = toLuaFile ./lua/plugins/telescope.lua;
      }

      {
        plugin = nvim-tree-lua;
        config = toLuaFile ./lua/plugins/tree.lua;
      }

      telescope-fzf-native-nvim
      nvim-web-devicons
      # {
      #   plugin = windex-nvim;
      #   config = toLua "require('windex').setup()";
      # }
      {
        plugin = comment-nvim;
        config = toLua "require('Comment').setup()";
      }
      {
        plugin = bufferline-nvim;
        config = toLuaFile ./lua/plugins/bufferline.lua;
      }
      {
        plugin = lualine-nvim;
        config = toLuaFile ./lua/plugins/lualine.lua;
      }
      {
        plugin = dressing-nvim;
        config = toLua "require('dressing').setup{}";
      }
    ];
    extraLuaConfig = ''
      ${builtins.readFile ./lua/options.lua}
      ${builtins.readFile ./lua/remap.lua}
    '';
  };
}
