{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

  outputs = { nixpkgs, ... }:
    let
      eachSystem = pkgBuild:
        builtins.listToAttrs (builtins.map
          (system: { name = system; value = pkgBuild system; })
          [ "aarch64-darwin" "aarch64-linux" "x86_64-darwin" "x86_64-linux" ]);
    in
    {
      packages = eachSystem (system: {
        default = nixpkgs.legacyPackages.${system}.hello;
      });
    };
}
