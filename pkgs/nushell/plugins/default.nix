{
  lib,
  config,
  newScope,
}:

lib.makeScope newScope (
  self: with self; {
    clipboard = callPackage ./clipboard.nix { };
    compress = callPackage ./compress.nix { };
  }
)
