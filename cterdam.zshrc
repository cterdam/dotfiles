# vim:foldmethod=marker

# cterdam.zshrc: cterdam's own zshrc file.
# See https://github.com/cterdam/linuxrc

# TMUX {{{

# Start tmux session "default" if tmux not running
if [[ -z "$TMUX" ]]; then
    tmux attach -t default || tmux new -s default
fi

# }}}
# OHMYZSH {{{

# Path to oh-my-zsh installation
export ZSH="/Users/sterdam/.oh-my-zsh"

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes for a list of themes
ZSH_THEME="candy"

# Disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    git
)

# Rest of oh-my-zsh
source $ZSH/oh-my-zsh.sh

# }}}
# GENERAL {{{

# Edit anything with vim
export EDITOR="vim"

# }}}
# CTERDAMHOME {{{

# Intended directory structure:
# - CTERDAMHOME
#   - CTERDAMRC
#   - CTERDAMBIN

# CTERDAMHOME directory to hold all my terminal material
export CTERDAMHOME="$HOME/cterdam"

# Make sure that CTERDAMHOME exists (if exists, nothing changes)
mkdir -p $CTERDAMHOME

# }}}
# CTERDAMRC {{{

# CTERDAMRC directory to hold all my custom rc files
# CTERDAMRC should be named linuxrc as cloned from my git repo.
# These rc file names should all start with "cterdam" as in my git repo.
# The files are all sourced from from their default location.
export CTERDAMRC="$CTERDAMHOME/linuxrc"

# 'rc vim' to edit the vimrc file, and et cetera.
rc () {
    case $1 in
        "vim")
            $EDITOR $CTERDAMRC/cterdam.vimrc
            ;;
        "zsh")
            $EDITOR $CTERDAMRC/cterdam.zshrc
            ;;
        "tmux")
            $EDITOR $CTERDAMRC/cterdam.tmux.conf
            ;;
    esac
}

# Some things to consider in the future:
# - symlinking the original rc files to the cterdam ones instead of sourcing

# }}}
# CTERDAMBIN {{{

# CTERDAMBIN directory to hold all my executables.
# This will be given priority in PATH.
export CTERDAMBIN="$CTERDAMHOME/bin"

# Make sure that CTERDAMBIN exists (if exists, nothing changes)
mkdir -p $CTERDAMBIN

# Symlink all vim binaries from homebrew to CTERDAMBIN
# If symlink already present in CTERDAMBIN then nothing changes.
# Reason is homebrew on Mac installs vim with more options than the default vim
homebrewbinloc="/opt/homebrew/bin"
for hbvimbin in $homebrewbinloc/*vim*
do
    slvimbin="$CTERDAMBIN/$(basename $hbvimbin)" 
    if [[ ! -f $slvimbin ]]; then
        ln -s $hbvimbin $slvimbin
    fi
done

# }}}
# PATH {{{

# 'showpath' to print each PATH directory on its own line
alias showpath='echo $PATH | sed "s/\:/\n/g"'

# 'add2path X tail' to append X to PATH,
# 'add2path Y head' to prepend Y to PATH.
# No change is made if the argument is already in PATH.
add2path() {
    if [[ :$PATH: != *:$1:* ]]; then
        if [[ $2 == "head" ]]; then
            export PATH=$1:$PATH
        else # implies $2 == "tail"
            export PATH=$PATH:$1
        fi
    fi
}

# Append clangd (installed with brew) if not included already
clangdpath="/opt/homebrew/opt/llvm/bin"
add2path $clangdpath tail

# Prepend CTERDAMBIN if not included aleady
add2path $CTERDAMBIN head

# }}}
