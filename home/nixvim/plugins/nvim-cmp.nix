{ config, pkgs, inputs, ... }:

{
  programs.nixvim = {
    plugins.luasnip = {
      enable = true;
    };

    plugins.cmp-nvim-lsp = {
      enable = true;
    };

    plugins.cmp-path = {
      enable = true;
    };

# plugins.friendly-snippets = {
#   enable = true;
# };

# TODO: Waiting on this bug to be fixed https://github.com/NixOS/nixpkgs/issues/306367
# https://nix-community.github.io/nixvim/NeovimOptions/index.html?highlight=extralua#extraluapackages
    extraLuaPackages = ps: [
# Required by luasnip
      ps.jsregexp
    ];

# Autocompletion
    plugins.cmp = {
      enable = true;

      settings = {
        snippet = {
          expand = ''
            function(args)
            require('luasnip').lsp_expand(args.body)
            end
            '';
        };

        completion = {
          completeopt = "menu,menuone,noinsert";
        };

# For an understanding of why these mappings were
# chosen, you will need to read `:help ins-completion`
#
# No, but seriously, Please read `:help ins-completion`, it is really good!
        mapping = {
          "<C-n>" = "cmp.mapping.select_next_item()";
          "<C-p>" = "cmp.mapping.select_prev_item()";
          "<C-b>" = "cmp.mapping.scroll_docs(-4)";
          "<C-f>" = "cmp.mapping.scroll_docs(4)";
          "<C-y>" = "cmp.mapping.confirm { select = true }";
# "<CR>" = "cmp.mapping.confirm { select = true }";
# "<Tab>" = "cmp.mapping.select_next_item()";
# "<S-Tab>" = "cmp.mapping.select_prev_item()";

          "<C-Space>" = "cmp.mapping.complete {}";

          "<C-l>" = ''
            cmp.mapping(function()
                if luasnip.expand_or_locally_jumpable() then
                luasnip.expand_or_jump()
                end
                end, { 'i', 's' })
            '';
          "<C-h>" = ''
            cmp.mapping(function()
                if luasnip.locally_jumpable(-1) then
                luasnip.jump(-1)
                end
                end, { 'i', 's' })
            '';

        };

# WARNING: If plugins.cmp.autoEnableSources Nixivm will automatically enable the 
# corresponding source plugins. This will work only when this option is set to a list.
# If you use a raw lua string, you will need to explicitly enable the relevant source
# plugins in your nixvim configuration.
        sources = [
        {
          name = "luasnip";
        }
# Adds other completion capabilites.
#  nvim-cmp does not ship with all sources by default. They are split
#  into multiple repos for maintenance purposes.
        {
          name = "nvim_lsp";
        }
        {
          name = "path";
        }
        ];
      };
    };
  };
}
