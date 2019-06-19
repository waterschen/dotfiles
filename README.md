# Dotfiles for oh-my-zsh, vim, git and iTerm2 

![Screenshot of my shell prompt](https://i.imgur.com/cYPH2QM.png)

![Screenshot of my shell vim](https://i.imgur.com/k6ouOSv.png)

![Screenshot of my MacVim](https://i.imgur.com/araeCgv.png)

## Installation

**Warning:** If you want to give these dotfiles a try, you should first fork this repository, review the code, and remove things you don’t want or need. Don’t blindly use my settings unless you know what that entails. Use at your own risk!

### Dependencies

Dependencies required by this repository:

* [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh)
* [iTerm2](https://www.iterm2.com/)

The following plugins don't come with `oh-my-zsh`, just use [Homebrew](https://brew.sh/) to install:

* [pure prompt](https://github.com/sindresorhus/pure)
* [autojump](https://github.com/wting/autojump)
* [fzf](https://github.com/junegunn/fzf)
* [thefuck](https://github.com/nvbn/thefuck)
* [fd](https://github.com/sharkdp/fd)

My favorite font for iTerm2, vim and MacVim:

* [FiraCode](https://github.com/tonsky/FiraCode)

### Using Git and the bootstrap script

You can clone the repository wherever you want. (I like to keep it in `~/Developer/dotfiles`, with `~/dotfiles` as a symlink.) The bootstrapper script will pull in the latest version and copy the files to your home folder.

```bash
git clone https://github.com/waterschen/dotfiles.git && cd dotfiles && source bootstrap.sh
```

To update, `cd` into your local `dotfiles` repository and then:

```bash
source bootstrap.sh
```

Alternatively, to update while avoiding the confirmation prompt:

```bash
set -- -f; source bootstrap.sh
```

### Specify the `$PATH`

If `~/.path` exists, it will be sourced along with the other files, before any feature testing (such as [detecting which version of `ls` is being used](https://github.com/mathiasbynens/dotfiles/blob/aff769fd75225d8f2e481185a71d5e05b76002dc/.aliases#L21-26)) takes place.

Here’s an example `~/.path` file that adds `/usr/local/bin` to the `$PATH`:

```bash
export PATH="/usr/local/bin:$PATH"
```

### Add custom commands without creating a new fork

If `~/.extra` exists, it will be sourced along with the other files. You can use this to add a few custom commands without the need to fork this entire repository, or to add commands you don’t want to commit to a public repository.

My `~/.extra` looks something like this:

```bash
# Git credentials
# Not in the repository, to prevent people from accidentally committing under my name
GIT_AUTHOR_NAME="Mathias Bynens"
GIT_COMMITTER_NAME="$GIT_AUTHOR_NAME"
git config --global user.name "$GIT_AUTHOR_NAME"
GIT_AUTHOR_EMAIL="mathias@mailinator.com"
GIT_COMMITTER_EMAIL="$GIT_AUTHOR_EMAIL"
git config --global user.email "$GIT_AUTHOR_EMAIL"
```

You could also use `~/.extra` to override settings, functions and aliases from my dotfiles repository. It’s probably better to [fork this repository](https://github.com/waterschen/dotfiles/fork) instead, though.

### Sensible macOS defaults

When setting up a new Mac, you may want to set some sensible macOS defaults:

```bash
./.macos
```

### Install Homebrew formulae

When setting up a new Mac, you may want to install some common [Homebrew](https://brew.sh/) formulae (after installing Homebrew, of course):

```bash
./brew.sh
```

Some of the functionality of these dotfiles depends on formulae installed by `brew.sh`. If you don’t plan to run `brew.sh`, you should look carefully through the script and manually install any particularly important ones. A good example is Bash/Git completion: the dotfiles use a special version from Homebrew.

## Feedback

Suggestions/improvements
[welcome](https://github.com/waterschen/dotfiles/issues)!
