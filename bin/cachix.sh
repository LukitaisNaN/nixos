#!/usr/bin/env bash

bash <(curl -L https://nixos.org/nix/install)

# Ask for sudo permission
echo "Este programa necesita permisos de administrador. Te va a pedir que pongas tu contraseña para poder continuar"
[ "$UID" -eq 0 ] || exec sudo "$0" "$@"

nix-env -iA cachix -f https://cachix.org/api/v1/install

cachix use lukitaisnan

Rebuild
