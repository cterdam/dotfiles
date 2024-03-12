# vim:foldmethod=marker

# cterdam.zshrc: cterdam's personal zshrc file.
# See https://github.com/cterdam/dotfiles

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

# Make profile directory only readable by self
chmod -R 700 $CTERDAMRC/utility/profile

# }}}
# CTERDAMRC {{{

# rc files are all symlinked to their default location.

# VIM {{{

# cterdam's vimrc file
cterdamvimrc="$CTERDAMRC/cterdam.vimrc"

# Location for vimrc
mkdir -p $HOME/.vim
vimrcloc="$HOME/.vim/vimrc"

# Symlink, if not already present
if [[ -f $cterdamvimrc && ! -f $vimrcloc ]]; then
    ln -s $cterdamvimrc $vimrcloc
fi

# cterdam's coc settings json file
cterdamcocsettings="$CTERDAMRC/cterdamcoc.json"

# Location for coc settings
cocsettingsloc="$HOME/.vim/coc-settings.json"

# Symlink, if not already present
if [[ -f $cterdamcocsettings && ! -f $cocsettingsloc ]]; then
    ln -s $cterdamcocsettings $cocsettingsloc
fi

# cterdam's pylintrc file
cterdampylintrc="$CTERDAMRC/cterdam.pylintrc"

# Location for pylinerc
pylintrcloc="$HOME/.pylintrc"

# Symlink, if not already present
if [[ -f $cterdampylintrc && ! -f $pylintrcloc ]]; then
    ln -s $cterdampylintrc $pylintrcloc
fi

# }}}
# GIT {{{

# cterdam's gitconfig file
cterdamgitconfig="$CTERDAMRC/cterdam.gitconfig"

# Location for gitconfig
gitconfigloc="$HOME/.gitconfig"

# Symlink, if not already present
if [[ -f $cterdamgitconfig && ! -f $gitconfigloc ]]; then
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

# cterdam's powerlevel10k config file
cterdamp10k="$CTERDAMRC/cterdam.p10k.zsh"

# Location for powerlevel10k config
p10kloc="$HOME/.p10k.zsh"

# Symlink, if not already present
if [[ -f $cterdamp10k && ! -f $p10kloc ]]; then
    ln -s $cterdamp10k $p10kloc
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

# cterdam's rime directory for all Rime dotfiles
cterdamrime="$CTERDAMRC/cterdam.rime"

# Location for Rime config folder
rimeloc="$HOME/Library/Rime"

# Symlink all rime files into the correct location for Rime
if [[ -d $rimeloc ]]; then
    for cterdamrimefile in $cterdamrime/*
    do
        rimefileloc="$rimeloc/$(basename $cterdamrimefile)"
        if [[ -f $cterdamrimefile && ! -f $rimefileloc ]]; then
            ln -s $cterdamrimefile $rimefileloc
        fi
    done
fi

# }}}
# {{{ SECRET

# Locate secrets
secretfile="$CTERDAMRC/utility/profile/shell/exec.sh"

# }}}
# {{{ SSH CONFIG

# cterdam's ssh config file
cterdamsshconf="$CTERDAMRC/cterdam.sshconfig"

# Location for ssh config
sshconfloc="$HOME/.ssh/config"

# Symlink, if not already present
if [[ -f $cterdamsshconf && ! -f $sshconfloc ]]; then
    ln -s $cterdamsshconf $sshconfloc
fi

# }}}

# Edit dotfiles with vim
rc () {
    case $1 in
        '')
            echo "Entering $CTERDAMRC"
            cd $CTERDAMRC
            ;;
        -h)
            echo "Available configs: vi(m), coc, git, zsh, tmux, rime, readme, server, secret, ssh"
            ;;
        coc)
            $EDITOR $cterdamcocsettings
            ;;
        git)
            $EDITOR $cterdamgitconfig
            ;;
        p10k)
            $EDITOR $cterdamp10k
            ;;
        pylint)
            $EDITOR $cterdampylintrc
            ;;
        readme)
            $EDITOR $CTERDAMRC/README.md
            ;;
        rime)
            echo "Entering $cterdamrime"
            cd $cterdamrime
            ;;
        secret)
            $EDITOR $secretfile
            ;;
        server)
            $EDITOR $CTERDAMRC/server_setup.sh
            ;;
        ssh)
            $EDITOR $cterdamsshconf
            ;;
        tmux)
            $EDITOR $cterdamtmuxconf
            ;;
        vi | vim)
            $EDITOR $cterdamvimrc
            ;;
        zsh)
            $EDITOR $cterdamzshrc
            ;;
        *)
            echo "No config for $1!"
            ;;
    esac
}

# }}}
# ZSH {{{

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to oh-my-zsh installation
export ZSH="$HOME/.oh-my-zsh"

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes for a list of themes
# ZSH_THEME="candy"
ZSH_THEME="powerlevel10k/powerlevel10k"

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
    conda
    conda-zsh-completion
    copybuffer
    copyfile
    copypath
    git
    history
    macos
    python
    web-search
    zsh-autosuggestions
    zsh-syntax-highlighting
)

# Individual WhatIs:
# conda: provide aliases for conda commands themselves
# conda-zsh-completion: Complete conda command arguments
# copybuffer: Ctrl + O to copy command line buffer to clipboard
# copyfile: `copyfile` to copy a file to clipboard
# copypath: `copypath` to copy current directory path
# git: autocompletions with git commands
# history: `h` to show history, `hs` to grep history
# macos: `cdf` to cd to current Finder location, `rmdsstore` to remove dsstore
# python: `py` for python, `pyclean` to clean dummy files
# web-search `google milan` to google search milan
# zsh-syntax-highlighting: provides highlighting when on command line
# zsh-autosuggestions: auto-suggest zsh commands on command line

# TODO: Some things to consider in the future:
# ChrisPenner/copy-pasta: use copy and paste like in GUI

# AUTO-SUGGEST STRATGEGY
# completion: Chooses a suggestion based on what tab-completion would suggest.
#     (requires zpty module)
# match_prev_cmd: Like history, but chooses the most recent match whose
#     preceding history item matches the most recently executed command
# history: Chooses the most recent match from history.
ZSH_AUTOSUGGEST_STRATEGY=(completion history match_prev_cmd)

# Rest of oh-my-zsh
source $ZSH/oh-my-zsh.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# }}}
# GENERAL {{{

# Use anaconda python and pip instead of any system-installed versions
alias python3="python"
alias pip3="pip"

# Aliases for python and ipython
alias py="python"
alias ipy="ipython"

# Alias for ls
alias l="ls"

# Load secrets
source $secretfile

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
if [ ! "$(command -v bat)" ]; then
    alias bat='batcat'
fi

# Get current system name
sysname() {
    case $(uname -a) in
        *Ubuntu*)
            echo "Ubntu"
            ;;
        *Darwin*)
            echo "macOS"
            ;;
        *Linux*)
            echo "Linux"
            ;;
        *)
            echo "admin"
    esac
}

# }}}
# PATH {{{

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

# Prepend pip install path
if ! inpath ~/.local/bin; then
    addpath ~/.local/bin head
fi

# Prepend CTERDAMBIN
if ! inpath $CTERDAMBIN; then
    addpath $CTERDAMBIN head
fi

# Add rust path
cargoenv="$HOME/.cargo/env"
if [[ -f $cargoenv ]]; then
    source $cargoenv
fi

# Fix ruby versioning issues for Jekyll
if [[ `sysname` == "macOS" ]]; then
    # Use chruby to manage alternative Ruby versions
    source $(brew --prefix)/opt/chruby/share/chruby/chruby.sh
    # Enable auto-switching of Rubies specified by .ruby-version files
    source $(brew --prefix)/opt/chruby/share/chruby/auto.sh
    # Use ruby version 3.1.3 (for Jekyll for Github Pages)
    chruby ruby-3.1.3
elif [[ `sysname` == "Ubntu" ]]; then
    export GEM_HOME="$HOME/gems"
    addpath $HOME/gems/bin tail
fi

# Add cobot home to path
export COBOT_HOME=$CTERDAMHOME/cobot_home
if ! inpath $COBOT_HOME/bin; then
    addpath $COBOT_HOME/bin tail
fi

# Add Maple to path
addpath /Library/Frameworks/Maple.framework/Versions/Current/bin tail

# }}}
# ANACONDA {{{

if [[ -d $HOME/'opt/anaconda3' ]]; then
    condahomeloc=$HOME/'opt/anaconda3'
elif [[ -d '/opt/anaconda3' ]]; then
    condahomeloc='/opt/anaconda3'
elif [[ -f /usr/local/bin/conda ]]; then
    condahomeloc='/usr/local'
elif [[ -d $HOME/anaconda3 ]]; then
    condahomeloc=$HOME/anaconda3
fi

# >>> conda initialize >>>
condaloc=$condahomeloc/'bin/conda'
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$($condaloc 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "$condahomeloc/etc/profile.d/conda.sh" ]; then
        . "$condahomeloc/etc/profile.d/conda.sh"
    else
        addpath "$condahomeloc/bin" head
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# }}}
# CTERDAMBIN {{{

# Symlink all vim binaries from homebrew to CTERDAMBIN, if not already present
# Reason is homebrew on Mac installs vim with more options than the default vim
homebrewbinloc="/opt/homebrew/bin"
if [[ -d $homebrewbinloc ]]; then
    for homebrewvimbin in $homebrewbinloc/(*vim*|vi)
    do
        cterdamvimbin="$CTERDAMBIN/$(basename $homebrewvimbin)"
        if [[ ! -f $cterdamvimbin ]]; then
            ln -s $homebrewvimbin $cterdamvimbin
        fi
    done
fi

# Empower all scripts in CTERDAMRC/scripts, and symlink to CTERDAMBIN if not
# already present
for exefile in $CTERDAMEXE/*
do
    chmod 755 $exefile
    binexe="$CTERDAMBIN/$(basename $exefile)"
    if [[ ! -f $binexe ]]; then
        ln -s $exefile $binexe
    fi
done

# Fix issue where bat goes by batcat on Ubuntu
batexe=$CTERDAMBIN/bat
if [[ `sysname` == "Ubuntu" && ! -f $batexe ]]; then
    ln -s `which batcat` $batexe
fi

# }}}
# TMUX {{{

# Start tmux session if not running
if [[ -z "$TMUX" ]]; then
    tmux attach -t $(sysname) || tmux new -s $(sysname)
fi

# }}}
