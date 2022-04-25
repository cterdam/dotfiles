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
# - CTERDAMHOME
#   - CTERDAMRC
#   - CTERDAMBIN

# CTERDAMHOME directory to hold all my terminal material
CTERDAMHOME="$HOME/cterdam"

# Make sure that CTERDAMHOME exists (if exists, nothing changes)
mkdir -p $CTERDAMHOME

# }}}
# CTERDAMRC {{{

# CTERDAMRC directory to hold all cterdam's custom rc files
# CTERDAMRC should be named dotfiles as cloned from my git repo.
CTERDAMRC="$CTERDAMHOME/dotfiles"

# These rc file names should all start with "cterdam" as in my git repo.
# The files are all symlinked to their default location.
# This directory should be git cloned.

# VIM ========================================================================

# cterdam's vimrc file
cterdamvimrc="$CTERDAMRC/cterdam.vimrc"

# Location for vimrc
vimrcloc="$HOME/.vim/vimrc"

# Symlink, if not already present
if [[ ! -f $vimrcloc ]]; then
    ln -s $cterdamvimrc $vimrcloc
fi

# coc settings json file
cterdamcocsettings="$CTERDAMRC/cterdamcoc.json"

# Location for coc settings
cocsettingsloc="$HOME/.vim/coc-settings.json"

# Symlink, if not already present
if [[ ! -f $cocsettingsloc ]]; then
    ln -s $cterdamcocsettings $cocsettingsloc
fi

# GIT ========================================================================

# cterdam's gitconfig file
cterdamgitconfig="$CTERDAMRC/cterdam.gitconfig"

# Location for zshrc
gitconfigloc="$HOME/.gitconfig"

# Symlink, if not already present
if [[ ! -f $gitconfigloc ]]; then
    ln -s $cterdamgitconfig $gitconfigloc
fi

# ZSH ========================================================================

# cterdam's zshrc file
cterdamzshrc="$CTERDAMRC/cterdam.zshrc"

# Location for zshrc
zshrcloc="$HOME/.zshrc"

# Symlink, if not already present
# Actually this doesn't work, symlinking has to be done manually.
# If there is no zshrc in the appointed location, how can we execute any script?
if [[ ! -f $zshrcloc ]]; then
    ln -s $cterdamzshrc $zshrcloc
fi

# TMUX =======================================================================

# cterdam's tmux.conf file
cterdamtmuxconf="$CTERDAMRC/cterdam.tmux.conf"

# Location for tmux.conf
tmuxconfloc="$HOME/.tmux.conf"

# Symlink, if not already present
if [[ ! -f $tmuxconfloc ]]; then
    ln -s $cterdamtmuxconf $tmuxconfloc
fi

# RIME =======================================================================

# cterdamrimerc directory for all Rime dotfiles
cterdamrimerc="$CTERDAMRC/cterdam.rime"

# Location for Rime config folder
rimeloc="$HOME/Library/Rime"

# Symlink all rime rc files into the correct location for Rime
for cterdamrimercfile in $cterdamrimerc/*
do
    rimercfile="$rimeloc/$(basename $cterdamrimercfile)"
    if [[ ! -f $rimercfile ]]; then
        ln -s $cterdamrimercfile $rimercfile
    fi
done

# ============================================================================

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
            echo "Entering $cterdamrimerc"
            cd $cterdamrimerc
            ;;
        -h)
            echo "Available configs: vi(m), coc, git, zsh, tmux, rime"
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

# CTERDAMBIN directory to hold all my executables.
# This will be given priority in PATH.
CTERDAMBIN="$CTERDAMHOME/bin"

# Make sure that CTERDAMBIN exists (if exists, nothing changes)
mkdir -p $CTERDAMBIN

# Symlink all vim binaries from homebrew to CTERDAMBIN, if not already present
# Reason is homebrew on Mac installs vim with more options than the default vim
homebrewbinloc="/opt/homebrew/bin"
for hbvimbin in $homebrewbinloc/(*vim*|vi)
do
    slvimbin="$CTERDAMBIN/$(basename $hbvimbin)" 
    if [[ ! -f $slvimbin ]]; then
        ln -s $hbvimbin $slvimbin
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

# Uncomment this function to use bat for git diff command
# git() {
#     if [ "$1" = "diff" ]; then
#       # Eat the 'diff'
#       shift
#       batdiff $@
#     else
#         command git "$@"
#     fi
# }

# Use bat to view man pages
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# Use gruvbox theme for bat
export BAT_THEME="gruvbox-dark"

# }}}
# OHMYZSH {{{

# Path to oh-my-zsh installation
export ZSH="/Users/sterdam/.oh-my-zsh"

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes for a list of themes
ZSH_THEME="candy"

# Use case-sensitive completion
CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Disable auto-setting terminal title
DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
plugins=(
    git
    web-search
    copyfile
    macos
)
# git: autocompletions with git commands
# web-search `google milan` to google search milan
# copyfile: copy the contents of a file to the system clipboard
# macos: some mac os aliases

# Rest of oh-my-zsh
source $ZSH/oh-my-zsh.sh

# }}}
# CONDA {{{

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
    # Altrenative one-line implementation
    # [[ :$PATH: == *:$1:* ]]
    if [[ :$PATH: == *:$1:* ]]; then
        true
    else
        false
    fi
}

# Adds something to PATH, head or tail, if not already included
addpath() {
    if ! inpath $1; then
        if [[ $2 == "head" ]]; then
            export PATH="$1:$PATH"
        else # default on tail
            export PATH="$PATH:$1"
        fi
    fi
}

# Prepend CTERDAMBIN if not included aleady
addpath $CTERDAMBIN head

# }}}
