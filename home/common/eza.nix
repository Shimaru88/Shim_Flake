{...}: {
  programs.eza = {
    enable = true;
    git = true;
    icons = true;
    extraOptions = [
      "--group-directories-first"
      "--header"
      "-o"
      "--no-permissions"
      "--hyperlink"
    ];
  };
}
