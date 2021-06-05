{ pkgs, ... }:
import ../home {
  username = "nickt";
  git = {
    name = "Nick Travers";
    email = "n.e.travers@gmail.com";
  };
  accounts = {
    personal = {
      name = "Nick Travers";
      email = "n.e.travers@gmail.com";
    };
  };
} {
  inherit pkgs;
}
