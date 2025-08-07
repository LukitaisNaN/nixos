#!/bin/bash

echo "Checking if nix configuration folder exists..."

if [ ! -d "~/.config/nixos"]; then
  echo "Creating nix configuration directory..."
  mkdir -p ~/.config/
  cd ~/.config/
  echo "Downloading github repository..."
  git clone git@github.com:LukitaisNaN/nixos.git
  echo "OK!"
else
  echo "Directory already exists, skiping clonation..."
  cd ~/.config/nixos
  echo "Setting ssh url..."

  # Set
  git remote set-url origin git@github.com:LukitaisNaN/nixos.git

  # Check 
  if [ "$(git remote get-url origin)" = "git@github.com:LukitaisNaN/nixos.git" ]; then
    echo "OK!"
  else
    echo "Failed to verify remote URL. =("
    exit 1
  fi

fi

cd

if [ -d "~/Desktop"]; then
  ln -s ~/.config/nixos/users/ebo/home.nix ~/Desktop/apps.nix
else
  ln -s ~/.config/nixos/users/ebo/home.nix ~/Escritorio/apps.nix
fi

sudo nixos-rebuild switch --flake ~/.config/nixos/#eborito

cat "Ahora se va a generar una clave que es necesaria para la nube.
Te va a pedir un par de cosas. No hace falta que escribas nada, solo tocá enter."  

ssh-keygen

echo "Ahora pasame lo de acá abajo por wsp :P"
cat ~/.ssh/id*.pub
