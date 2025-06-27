{ input, ...}:

{

  services.libinput.enable = true;

  services.displayManager.defaultSession = "cinnamon";
  services.cinnamon.apps.enable = true;
  services.xserver = {
                  enable = true;
                  displayManager.lightdm.enable = true;
                  desktopManager = {
                          cinnamon.enable = true;
                  };
  };

}

