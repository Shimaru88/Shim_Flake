{email, ...}: {
  programs.git = {
    enable = true;
    userName = "Shimaru88";
    userEmail = "${email}";
  };
}
