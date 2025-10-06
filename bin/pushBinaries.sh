#!/usr/bin/env bash
cd ..
cachix push lukitaisnan $(nix path-info ./result)
