{
  description = "My personal NUR repository";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  inputs.systems.url = "github:nix-systems/default";
  outputs =
    {
      self,
      systems,
      nixpkgs,
    }:
    let
      eachSystem = nixpkgs.lib.genAttrs (import systems);

    in
    {
      legacyPackages = eachSystem (
        system: import ./default.nix { pkgs = import nixpkgs { inherit system; }; }
      );
      packages = eachSystem (
        system: nixpkgs.lib.filterAttrs (_: v: nixpkgs.lib.isDerivation v) self.legacyPackages.${system}
      );
    };
}
