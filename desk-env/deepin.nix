{ input, ...}:

{

  services.libinput.enable = true;

  #services.displayManager.defaultSession = "lightdm";
  services.cinnamon.apps.enable = true;
  services.xserver = {
                  enable = true;
                  displayManager.lightdm.enable = true;
                  desktopManager = {
                          deepin.enable = true;
                  };
  };

}

