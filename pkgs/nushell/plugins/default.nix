{
  lib,
  config,
  newScope,
}:

lib.makeScope newScope (
  self: with self; {
    compress = callPackage ./compress.nix { };
  }
)
