{ pkgs, ... }:

{
  packageOverrides = pkgs: {
    nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
      inherit pkgs;
    };
  };

  xsession.pointerCursor = {
    package = pkgs.capitaine-cursors;
    name = "Capitaine Cursors";
    size = 24;
  };
}
