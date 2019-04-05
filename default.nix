# create docker images using `nix-build`
# load with `docker load < result`
# run with `docker run -it --rm haskell_stack` for interactive with vt

{ pkgs ? import <nixpkgs> {} }:
with pkgs;
with dockerTools;

let
  hs-stack-base = buildLayeredImage {
    name = "hs-stack-base";
    tag = "latest";

    contents = [
      # mandatory packages
      stack
      ghc
      iana-etc        # https://github.com/NixOS/nixpkgs/issues/39296
      cacert          # https://github.com/snoyberg/http-client/issues/31
      glibc_multi     # for ldconfig (TODO: use `musl`?)
      binutils        # for ar
    ];

    maxLayers = 128;
  };
in
buildImage {
  name = "hs-stack";
  tag = "latest";
  diskSize = 4096;

  fromImage = hs-stack-base;

  contents = [
    # optional util packages (for easy image testing/debuging)
    coreutils       # for ls
    findutils       # for find
    which           # for which
    gnugrep         # for grep
    bashInteractive # for bash
    wget            # for downloading a file
  ];

  runAsRoot = ''
    mkdir -p /tmp
    mkdir -p /data

    cd /data
    # which stack
    # stack new test
  '';

  # config = {
  #     Cmd = [ "/bin/ls" ];
  #     WorkingDir = "/data";
  #     Volumes = {
  #       "/data" = {};
  #     };
  # };
}
