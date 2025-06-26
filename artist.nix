{ pkgs, ... }:

{

environment.systemPackages = with pkgs; [
    aseprite              # Sprite drawing app
    blender               # 3D modeler
    godot                 # Godot v4.x
    godot3                # Godot v3.6
    kdePackages.kdenlive  # Video editor
    krita                 # General drawing app
    mixxx                 # DJ mixer
];
}
