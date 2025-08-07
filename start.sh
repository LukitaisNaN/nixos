#!/bin/sh

echo "Checking if nix configuration folder exists..."

if [ ! -d "$HOME/.config/nixos" ]; then
  echo "Creating nix configuration directory..."
  mkdir -p "$HOME/.config"
  cd "$HOME/.config"
  echo "Downloading github repository..."
  git clone git@github.com:LukitaisNaN/nixos.git
  echo "OK!"
else
  echo "Directory already exists, skipping clonation..."
  cd "$HOME/.config/nixos"
  echo "Setting ssh url..."

  git remote set-url origin git@github.com:LukitaisNaN/nixos.git

  if [ "$(git remote get-url origin)" = "git@github.com:LukitaisNaN/nixos.git" ]; then
    echo "OK!"
  else
    echo "Failed to verify remote URL. =("
    exit 1
  fi
fi

cd "$HOME"

if [ -d "$HOME/Desktop" ]; then
  ln -s "$HOME/.config/nixos/users/ebo/home.nix" "$HOME/Desktop/apps.nix"
else
  ln -s "$HOME/.config/nixos/users/ebo/home.nix" "$HOME/Escritorio/apps.nix"
fi

sudo nixos-rebuild switch --flake "$HOME/.config/nixos/#eborito"

echo "Ahora se va a generar una clave que es necesaria para la nube.
Te va a pedir un par de cosas. No hace falta que escribas nada, solo tocá enter."  

ssh-keygen

echo "Ahora pasame lo de acá abajo por wsp :P"

if ls "$HOME/.ssh/id"*.pub 1> /dev/null 2>&1; then
  cat "$HOME/.ssh/id"*.pub
else
  echo "No SSH public key found!"
fi

