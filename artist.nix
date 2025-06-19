{inputs, config, pkgs, ... }:

{

environment.systemPackages = with pkgs; [
    aseprite              # Sprite drawing app
    bitwig-studio         # DAW
    blender               # 3D modeler
    godot                 # Godot v4.x
    godot3                # Godot v3.6
    jack2                 # Audio mixer
    kdePackages.kdenlive  # Video editor
    krita                 # General drawing app
];
}
