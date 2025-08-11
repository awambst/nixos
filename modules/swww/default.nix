{ inputs, system, ... }:
{
  environment.systemPackages = [ 
    inputs.swww.packages.${system}.swww 
  ];
}
