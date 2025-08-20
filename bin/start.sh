#!/bin/sh

# Ask for sudo permission
echo "Este programa necesita permisos de administrador. Te va a pedir que pongas tu contraseña para poder continuar"
[ "$UID" -eq 0 ] || exec sudo "$0" "$@"

# Clone nix repository if...
echo "Checking if nix configuration folder exists..."

# If .config/nixos doesn't exist, create it (aka clone git repository)
if [ ! -d "$HOME/.config/nixos" ]; then
  echo "Creating nix configuration directory..."
  mkdir -p "$HOME/.config"				# Create .config dir (Does nothing if .config already exists) 
  cd "$HOME/.config"					# cd into .config
  echo "Downloading github repository..."		 
  git clone git@github.com:LukitaisNaN/nixos.git	# Clone using ssh
  echo "OK!"

# If repository was already downloaded, skip clonation and set ssh url
else
  echo "Directory already exists, skipping clonation..."
  cd "$HOME/.config/nixos"					# cd nixos repository
  echo "Setting ssh url..."

  git remote set-url origin git@github.com:LukitaisNaN/nixos.git	# Change url, just in case it was cloned using http

  # Check that it was correctly set.
  if [ "$(git remote get-url origin)" = "git@github.com:LukitaisNaN/nixos.git" ]; then
    echo "OK!"
  else
    echo "ERROR: Failed to set remote URL. =("
    exit 1
  fi
fi

cd "$HOME"

# Create symbolic link to 'Desktop' or 'Escritorio' dir
if [ -d "$HOME/Desktop" ]; then
  ln -s "$HOME/.config/nixos/users/ebo/home.nix" "$HOME/Desktop/apps.nix"
else
  ln -s "$HOME/.config/nixos/users/ebo/home.nix" "$HOME/Escritorio/apps.nix"
fi

# Use nix cachix to get binaries from community instead of rebuilding everything on
# every lock update
echo "Installing nix cachix..."
nix-env -iA cachix -f https://cachix.org/api/v1/install
sudo cachix use nix-community
echo "DONE"

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

