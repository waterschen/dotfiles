#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")";

git pull origin master;
git submodule update --init --recursive;

function doIt() {
	rsync --exclude ".git/" \
		--exclude ".DS_Store" \
		--exclude ".osx" \
		--exclude ".gitmodules" \
		--exclude "bootstrap.sh" \
		--exclude "brew.sh" \
		--exclude "README.md" \
		--exclude "LICENSE-MIT.txt" \
        --exclude "iTerm2.preferences" \
		--exclude "plugins" \
		-avh --no-perms . ~;
	rsync --exclude ".git/" \
		--exclude ".DS_Store" \
		-avh --no-perms plugins $ZSH/custom;
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
	doIt;
else
	read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
	echo "";
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		doIt;
	fi;
fi;
unset doIt;
