{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  name = "myproject";
  venvDir = "./venv";
  buildInputs = with pkgs; [
    python37Packages.venvShellHook
    python37Packages.mpi4py
    python37Packages.pytorch
    python37Packages.soundfile
  ];

  nativeBuildInputs = with pkgs; [
    # vim integration packages.
    # python37Packages.jedi # This nixpkg is too outdated.
    python37Packages.flake8
  ];

  preShellHook = ''
    unset SOURCE_DATE_EPOCH
  '';
  postShellHook = ''
    # libstdc++.so.6
    export LD_LIBRARY_PATH=${pkgs.lib.makeLibraryPath [pkgs.stdenv.cc.cc]}

    # pip install -r requirements.txt
    pip install -e .
  '';
}
