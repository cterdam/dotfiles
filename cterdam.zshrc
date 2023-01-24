# vim:foldmethod=marker

# cterdam.zshrc: cterdam's personal zshrc file.
# See https://github.com/cterdam/dotfiles

# TMUX {{{

# Start tmux session "default" if tmux not running
if [[ -z "$TMUX" ]]; then
    tmux attach -t default || tmux new -s default
fi

# }}}
# CTERDAMHOME {{{

# Intended directory structure:
# - CTERDAMHOME (development directory)
#   - CTERDAMBIN (script and other binary symlinks)
#   - CTERDAMRC (config files)
#     - CTERDAMEXE (source scripts for execution)

# CTERDAMHOME directory to hold all my terminal material
export CTERDAMHOME="$HOME/cterdam"
mkdir -p $CTERDAMHOME

# CTERDAMBIN directory to hold all my executables.
# This will be given priority in PATH.
export CTERDAMBIN="$CTERDAMHOME/bin"
mkdir -p $CTERDAMBIN

# CTERDAMRC directory to hold all cterdam's custom rc files
# CTERDAMRC should be named dotfiles as cloned from my git repo.
export CTERDAMRC="$CTERDAMHOME/dotfiles"

# CTERDAMEXE directory to hold all scripts to be converted to executables
export CTERDAMEXE="$CTERDAMRC/exe"

# }}}
# CTERDAMRC {{{

# These rc file names should all start with "cterdam" as in my git repo.
# The files are all symlinked to their default location.
# This directory should be git cloned.

# VIM {{{

# cterdam's vimrc file
cterdamvimrc="$CTERDAMRC/cterdam.vimrc"

# Location for vimrc
vimrcloc="$HOME/.vim/vimrc"

# Symlink, if not already present
if [[ -f $cterdamvimrc && ! -f $vimrcloc ]]; then
    ln -s $cterdamvimrc $vimrcloc
fi

# coc settings json file
cterdamcocsettings="$CTERDAMRC/cterdamcoc.json"

# Location for coc settings
cocsettingsloc="$HOME/.vim/coc-settings.json"

# Symlink, if not already present
if [[ -f $cterdamcocsettings && ! -f $cocsettingsloc ]]; then
    ln -s $cterdamcocsettings $cocsettingsloc
fi

# }}}
# GIT {{{

# cterdam's gitconfig file
cterdamgitconfig="$CTERDAMRC/cterdam.gitconfig"

# Location for zshrc
gitconfigloc="$HOME/.gitconfig"

# Symlink, if not already present
if [[ -f cterdamgitconfig && ! -f $gitconfigloc ]]; then
    ln -s $cterdamgitconfig $gitconfigloc
fi

# }}}
# ZSH {{{

# cterdam's zshrc file
cterdamzshrc="$CTERDAMRC/cterdam.zshrc"

# Location for zshrc
zshrcloc="$HOME/.zshrc"

# Symlink, if not already present
# Actually this doesn't work, symlinking has to be done manually.
# If there is no zshrc in the appointed location, how can we execute any script?
if [[ -f $cterdamzshrc && ! -f $zshrcloc ]]; then
    ln -s $cterdamzshrc $zshrcloc
fi

# }}}
# TMUX {{{

# cterdam's tmux.conf file
cterdamtmuxconf="$CTERDAMRC/cterdam.tmux.conf"

# Location for tmux.conf
tmuxconfloc="$HOME/.tmux.conf"

# Symlink, if not already present
if [[ -f $cterdamtmuxconf && ! -f $tmuxconfloc ]]; then
    ln -s $cterdamtmuxconf $tmuxconfloc
fi

# }}}
# RIME {{{

# cterdamrime directory for all Rime dotfiles
cterdamrime="$CTERDAMRC/cterdam.rime"

# Location for Rime config folder
rimeloc="$HOME/Library/Rime"

# Symlink all rime files into the correct location for Rime
for cterdamrimefile in $cterdamrime/*
do
    rimefileloc="$rimeloc/$(basename $cterdamrimefile)"
    if [[ -f $cterdamrimefile && ! -f $rimefileloc ]]; then
        ln -s $cterdamrimefile $rimefileloc
    fi
done

# }}}

# Edit dotfiles with vim
rc () {
    case $1 in
        vim | vi)
            $EDITOR $cterdamvimrc
            ;;
        coc)
            $EDITOR $cterdamcocsettings
            ;;
        git)
            $EDITOR $cterdamgitconfig
            ;;
        zsh)
            $EDITOR $cterdamzshrc
            ;;
        tmux)
            $EDITOR $cterdamtmuxconf
            ;;
        rime)
            echo "Entering $cterdamrime"
            cd $cterdamrime
            ;;
        readme)
            $EDITOR $CTERDAMRC/README.md
            ;;
        -h)
            echo "Available configs: vi(m), coc, git, zsh, tmux, rime, readme"
            ;;
        '')
            echo "Entering $CTERDAMRC"
            cd $CTERDAMRC
            ;;
        *)
            echo "No config for $1!"
            ;;
    esac
}

# }}}
# CTERDAMBIN {{{

# Symlink all vim binaries from homebrew to CTERDAMBIN, if not already present
# Reason is homebrew on Mac installs vim with more options than the default vim
homebrewbinloc="/opt/homebrew/bin"
for homebrewvimbin in $homebrewbinloc/(*vim*|vi)
do
    cterdamvimbin="$CTERDAMBIN/$(basename $homebrewvimbin)"
    if [[ ! -f $cterdamvimbin ]]; then
        ln -s $homebrewvimbin $cterdamvimbin
    fi
done

# Empower all scripts in CTERDAMRC/scripts, and symlink to CTERDAMBIN if not
# already present
for exefile in $CTERDAMRC/exe/*
do
    chmod 755 $exefile
    binexe="$CTERDAMBIN/$(basename $exefile)"
    if [[ ! -f $binexe ]]; then
        ln -s $exefile $binexe
    fi
done

# }}}
# GENERAL {{{

# Edit anything with vim
export EDITOR="vim"

# Show Chinese characters
alias tree='tree -N'

# Do actual work here
cd $CTERDAMHOME

# Function to view git diff with bat
batdiff() {
    command git diff --name-only --diff-filter=d $@ | xargs bat --diff
}

# Use bat to view man pages
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# Use gruvbox theme for bat
export BAT_THEME="gruvbox-dark"

# Command to view the root of this git repo
alias gitroot='git rev-parse --show-toplevel'

# Solve issue on Ubuntu where bat is named batcat
if [[ ! $(command -v bat) ]]; then
    alias bat='batcat'
fi

# }}}
# OHMYZSH {{{

# Path to oh-my-zsh installation
export ZSH="/Users/sterdam/.oh-my-zsh"

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes for a list of themes
ZSH_THEME="candy"

# Use case-insensitive completion
CASE_SENSITIVE="false"

# Use hyphen-insensitive completion. Treat _ and - interchangeably.
HYPHEN_INSENSITIVE="true"

# Just remind me to update when it's time
zstyle ':omz:update' mode reminder

# Trigger auto-update every 13 days
zstyle ':omz:update' frequency 13

# Disable auto-setting terminal title
DISABLE_AUTO_TITLE="true"

# Enable command auto-correction.
ENABLE_CORRECTION="true"

# Display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Mark untracked files under VCS as dirty,
# at the expense of repo status check speed.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Manage the command execution time stamp shown in the history command output.
HIST_STAMPS="yyyy-mm-dd"

# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
plugins=(
    git
    python
    web-search
    copyfile
    copypath
    copybuffer
    macos
    history
)
# git: autocompletions with git commands
# python: `py` for python, `pyclean` to clean dummy files
# web-search `google milan` to google search milan
# copyfile: `copyfile` to copy a file to clipboard
# copypath: `copypath` to copy current directory path
# copybuffer: Ctrl + O to copy command line buffer to clipboard
# macos: some mac os aliases
# history: `h` to show history, `hs` to grep history

# Rest of oh-my-zsh
source $ZSH/oh-my-zsh.sh

# }}}
# ANACONDA {{{

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/sterdam/opt/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/sterdam/opt/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/sterdam/opt/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/sterdam/opt/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# }}}
# PATH {{{

# This section stays at the bottom of zshrc to have final control over PATH

# Prints each PATH directory on its own line
# (assumes no ':' in directory names)
alias showpath='echo $PATH | tr ":" "\n"'

# Returns true iff argument in PATH
inpath() {
    # Alternative one-line implementation
    # [[ :$PATH: == *:$1:* ]]
    if [[ :$PATH: == *:$1:* ]]; then
        true
    else
        false
    fi
}

# Adds something to PATH, head or tail
addpath() {
    if [[ $2 == "head" ]]; then
        export PATH="$1:$PATH"
    elif [[ $2 == "tail" ]]; then
        export PATH="$PATH:$1"
    elif [[ $2 == "" ]]; then
        echo "Usage: addpath TARGET [head|tail]"
    else
        echo "Unknown option: $2"
    fi
}

# Deletes something from PATH, if present
delpath() {
    if [[ $2 == "first" ]]; then
        findstr="s%:$1%%"
    elif [[ $2 == "all" ]]; then
        findstr="s%:$1%%g"
    elif [[ $2 == "" ]]; then
        echo "Usage: delpath TARGET [first|all]"
        return
    else
        echo "Unknown option: $2"
        return
    fi

    export PATH=$(echo :$PATH | sed $findstr | sed "s%^:%%g")
}

# Prepend CTERDAMBIN if not included aleady
if ! inpath $CTERDAMBIN; then
    addpath $CTERDAMBIN head
fi

# Add pip install path
addpath ~/.local/bin head

# Add rust path
source "$HOME/.cargo/env"

# }}}
# ALEXA SOCIALBOT {{{
    # Set cobot home
    export COBOT_HOME=/Users/sterdam/cterdam/cobot_home

    # Add bin to PATH
    addpath $COBOT_HOME/bin tail
# }}}
