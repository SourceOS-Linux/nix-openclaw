{
  description = "SourceOS local-first control node via nix-openclaw";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-openclaw.url = "github:SourceOS-Linux/nix-openclaw";
  };

  outputs = { self, nixpkgs, home-manager, nix-openclaw }:
    let
      # REPLACE: aarch64-darwin (Apple Silicon), x86_64-darwin (Intel), or x86_64-linux
      system = "<system>";
      pkgs = import nixpkgs { inherit system; overlays = [ nix-openclaw.overlays.default ]; };
    in {
      # REPLACE: <user> with your username
      homeConfigurations."<user>" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          nix-openclaw.homeManagerModules.openclaw
          {
            home.username = "<user>";
            home.homeDirectory = "<homeDir>";
            home.stateVersion = "24.11";
            programs.home-manager.enable = true;

            # Downstream declarative deployment only.
            # Canonical contracts live in SourceOS-Linux/sourceos-spec.
            # Runtime implementation lives in SocioProphet/prophet-platform.
            # Execution/evidence lives in SocioProphet/agentplane.
            # Workstation/bootstrap lives in SociOS-Linux/source-os.
            programs.openclaw = {
              documents = ./documents;
              config = {
                gateway = {
                  mode = "local";
                  auth = {
                    token = "<gatewayToken>";
                  };
                };

                channels.telegram = {
                  tokenFile = "<tokenPath>";
                  allowFrom = [ <allowFrom> ];
                  groups = {
                    "*" = { requireMention = true; };
                  };
                };
              };

              instances.default = {
                enable = true;
                plugins = [ ];
              };
            };
          }
        ];
      };
    };
}
