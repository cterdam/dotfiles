# dotfiles

cterdam's personal computing environment setup for Unix-like (Mac) systems.

## Installing on a new Mac

- In the Mac terminal, type `git` to trigger downloading developer tools.
- Now that git is installed, log in to Github and follow its [tutorial][GHSSH]
  to set up a new SSH key.
- Now make development directory:
  ```zsh
  cd
  mkdir cterdam
  ```
- Inside `cterdam`, clone this repo over SSH:
  ```zsh
  cd cterdam
  git clone --recursive git@github.com:cterdam/dotfiles.git
  ```
- Once the repo is downloaded, set up terminal appearance by importing
  `hbpro.terminal` to terminal profiles.
- Install [homebrew](https://brew.sh/).
  - Upon finishing installation, the script will print a 'Next steps' section
    which mentions two commands to run in order to add homebrew to PATH. Run
    them.
- Now install vim with `brew install vim`.
  - MacOS already comes with a builtin distribution of vim, but the default
	version lacks many key features such as `conceal`, `lua`, `perl`, and
	`python3`. The version of vim on homebrew includes these features.
  - Upon finishing installing the brew version, run `which vim` and you might
    see that it's still the system vim (and not the brew vim) which gets
	evoked. This is because brew-installed apps are not given priority in PATH.
	Don't worry about it; the zsh scripts to be installed later will fix this.
- Install tmux with `brew install tmux`.
  - When it's done, install [Tmux Plugin Manager](TPM). Don't worry about
	installing actual plugins for now: the tmux script will take care of it.

[GHSSH]:
https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent

[TPM]:
https://github.com/tmux-plugins/tpm

## Submodules

This repo uses the git feature called submodules. This means you can embed
other git repoes inside this one. For example, I use
[sindresorhus/github-markdown-css][GHCSS] to enable previewing markdown in the
Github style. This is incorporated as a submodule.

[GHCSS]:
https://github.com/sindresorhus/github-markdown-css

If submodule folders appear empty after cloning, run this to download all
submodules (and their submodules, if any):

```zsh
git submodule update --init --recursive
```

Note that updating the parent repo will not automatically update submodules.
To update submodules, since git 1.8.2 the option `--remote` was added to
support updating to latest tips of remote branches:

```zsh
git submodule update --recursive --remote
```

Or, if cloning this parent repo for the first time, run this to ensure you
download everything:

```zsh
git clone --recursive <project url>
```