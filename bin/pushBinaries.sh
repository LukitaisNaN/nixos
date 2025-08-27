#!/usr/bin/env bash

nix-build | cachix push nix-community
