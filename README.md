# Holis =)
Hi! This is a Nix repository I share with my familiars to help them avoid windows as much as possible
meanwhile I can help they with any problems they have with linux.

# Features
- Flakes
- Home-Manager

I use flakes to keep a lock about Nix's unstable channel version.
And home-manager to keep a different home for my relatives.

Also, I created some commands that automatize git managment so they can keep their info in this repo =)

# Commands
Help: Prints an explanation of the next commands, in spanish.
Edit: Opens home.nix to add packages.
Rebuild: Executes "sudo nixos-rebuild switch --flake .config/repoName/#relativeNameOs"
Save: Executes: git add . -> git commit "$USER's automatic update -> git rebase -> git push 
Update: Downloads repo's updates. In case they asked for help, they should execute this to download whatever I changed.
