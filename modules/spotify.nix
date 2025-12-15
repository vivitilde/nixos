{ config, pkgs, inputs, spicePkgs, ...}: {
 # spicetify setup for spotify

  environment.systemPackages = with pkgs; [ 
    spotify
  ];
  programs.spicetify = 
  let
    spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
  in
  {
    enable = true;
    theme = spicePkgs.themes.text;
    enabledExtensions = with spicePkgs.extensions; [
      adblockify
      hidePodcasts
      shuffle
      keyboardShortcut
    ];
  };
}

  
