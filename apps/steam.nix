{inputs, config, pkgs, ... }:

{

environment.systemPackages = with pkgs; [
   protonplus
];

# Fix pipewire's audio crackling while playing
environment.variables = {
  PULSE_LATENCY_MSEC = "60";
};

programs.steam = {
  enable = true;
  remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
  dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
};


}
