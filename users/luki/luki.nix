{ config }:
{
  users.users.lukita = {
    isNormalUser = true;
    description = "Lukita";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      home-manager
    ];
  };

}
