{...}: {
  programs.nixvim = {
    plugins.treesitter = {
      enable = true;
      settings = {
        ensureInstalled = [
          "bash"
          "c"
          "diff"
          "html"
          "lua"
          "luadoc"
          "markdown"
          "nix"
          "go"
          "gomod"
          "gowork"
        ];

        highlight = {
          enable = true;
        };

        indent = {
          enable = true;
        };
      };
    };
  };
}
