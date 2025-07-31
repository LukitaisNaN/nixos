{ input, ...}:

{

  services.libinput.enable = true;

  #services.displayManager.defaultSession = "lightdm";
  services.xserver = {
                  enable = true;
                  displayManager.lightdm.enable = true;
                  desktopManager = {
                          deepin.enable = true;
                  };
  };

}

