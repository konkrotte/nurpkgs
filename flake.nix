{
  description = "My personal NUR repository";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  inputs.systems.url = "github:nix-systems/default";
  outputs = { self, systems, nixpkgs }:
    let eachSystem = nixpkgs.lib.genAttrs (import systems);

    in {
      legacyPackages = eachSystem (system:
        import ./default.nix { pkgs = import nixpkgs { inherit system; }; });
      packages = eachSystem (system:
        let pkgs = self.legacyPackages.${system};
        in {
          default =
            pkgs.beetcamp; # Replace 'hello' with your actual default package
          inherit (pkgs) beetcamp; # Add other packages you want to expose
        });
    };
}
