{
  nixConfig = {
    extra-substituters = [
      "https://nix-cache.fossi-foundation.org"
    ];
    extra-trusted-public-keys = [
      "nix-cache.fossi-foundation.org:3+K59iFwXqKsL7BNu6Guy0v+uTlwsxYQxjspXzqLYQs="
    ];
  };

  inputs = {
    nix-eda.url = "github:fossi-foundation/nix-eda/7.4.0";
    librelane = {
      url = "github:librelane/librelane/dev";
      inputs.nix-eda.follows = "nix-eda";
    };
  };

  outputs =
    {
      self,
      librelane,
      ...
    }:
    let
      nix-eda = librelane.inputs.nix-eda;
      devshell = librelane.inputs.devshell;
      nixpkgs = nix-eda.inputs.nixpkgs;
      lib = nixpkgs.lib;
    in
    {
      # Outputs
      legacyPackages = nix-eda.forAllSystems (
        system:
        import nixpkgs {
          inherit system;
          overlays = [
            nix-eda.overlays.default
            devshell.overlays.default
            librelane.overlays.default
          ];
        }
      );

      packages = nix-eda.forAllSystems (system: {
        inherit (self.legacyPackages.${system}.python3.pkgs) ;
      });

      devShells = nix-eda.forAllSystems (
        system:
        let
          pkgs = (self.legacyPackages.${system});
        in
        {
          default = pkgs.librelane-shell.override ({
            extra-packages = with pkgs; [
              # Simulation
              iverilog
              verilator

              # Waveform viewing
              gtkwave

              # FPGA prototyping
              #yosys # already in LibreLane
              nextpnr
              icestorm
              trellis
              openfpgaloader

              # Analog
              xschem
              xterm
              ngspice # recompiles for some reason
              klayout
              magic
              netgen
              openvaf-r
            ];

            extra-python-packages =
              ps:
              with ps;
              [
                # Plotting of simulation results (scripts/plot_simulations)
                numpy
                matplotlib
              ]
              ++ (pkgs.lib.optionals (lib.meta.availableOn pkgs.stdenv.hostPlatform cocotb) [ cocotb ]);
          });
        }
      );
    };
}
