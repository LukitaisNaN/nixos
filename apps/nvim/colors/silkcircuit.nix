silkcircuit-nvim = buildVimPlugin {
    pname = "silkcircuit.nvim";
    version = "27-08-2025";
    src = fetchFromGitHub {
      owner = "hyperb1iss";
      repo = "silkcircuit-nvim";
      rev = "";
      sha256 = "";
    };
    meta.homepage = "https://github.com/hyperb1iss/silkcircuit-nvim/";
    meta.hydraPlatforms = [ ];
  };
