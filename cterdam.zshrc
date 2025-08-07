# vim:foldmethod=marker filetype=zsh

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
if [[ -d "$HOME/Library/Rime" ]]; then
    rimeloc="$HOME/Library/Rime"
elif [[ -d "$HOME/.config/ibus/rime/" ]]; then
    rimeloc="$HOME/.config/ibus/rime/"
elif [[ -d "$HOME/.ibus/rime/" ]]; then
    rimeloc="$HOME/.ibus/rime/"
elif [[ -d "$HOME/.local/share/fcitx5/rime/" ]]; then
    rimeloc="$HOME/.local/share/fcitx5/rime/"
fi

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
secretfile="$CTERDAMRC/utility/profile/shell/.exec.sh"

# }}}
# {{{ SSH

# cterdam's ssh config file
cterdamsshconf="$CTERDAMRC/cterdam.sshconfig"

# Location for ssh config
sshconfloc="$HOME/.ssh/config"

# Symlink, if not already present
if [[ -f $cterdamsshconf && ! -f $sshconfloc ]]; then
    ln -s $cterdamsshconf $sshconfloc
fi

# }}}
# HG {{{

# cterdam's hgrc file
cterdamhgrc="$CTERDAMRC/cterdam.hgrc"

# Location for hgrc
hgrcloc="$HOME/.hgrc"

# Symlink, if not already present
if [[ -f $cterdamhgrc && ! -f $hgrcloc ]]; then
    ln -s $cterdamhgrc $hgrcloc
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
            echo "Available configs: vi(m), coc, exe, git, zsh, tmux, rime, readme, server, secret, ssh"
            ;;
        coc)
            $EDITOR $cterdamcocsettings
            ;;
        exe)
            echo "Entering $CTERDAMEXE"
            cd $CTERDAMEXE
            ;;
        git)
            $EDITOR $cterdamgitconfig
            ;;
        hg)
            $EDITOR $cterdamhgrc
            ;;
        p10k)
            $EDITOR $cterdamp10k
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
# GIT {{{

# Function to view git diff with bat
batdiff() {
    command git diff --name-only --diff-filter=d $@ | xargs bat --diff
}

# Command to view the root of this git repo
alias gitroot='git rev-parse --show-toplevel'

# Command to view git logline
alias gll='git logline'

# }}}
# CONDA {{{

if [[ -d $HOME/'opt/anaconda3' ]]; then
    condahomeloc=$HOME/'opt/anaconda3'
elif [[ -d '/opt/anaconda3' ]]; then
    condahomeloc='/opt/anaconda3'
elif [[ -d $HOME/anaconda3 ]]; then
    condahomeloc=$HOME/anaconda3
elif [[ -d $HOME/'opt/miniconda3' ]]; then
    condahomeloc=$HOME/'opt/miniconda3'
elif [[ -d '/opt/miniconda3' ]]; then
    condahomeloc='/opt/miniconda3'
elif [[ -d $HOME/miniconda3 ]]; then
    condahomeloc=$HOME/miniconda3
elif [[ -f /usr/local/bin/conda ]]; then
    condahomeloc='/usr/local'
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
# GENERAL {{{

# Get current system name
sysname() {
    case $(uname -a) in
        *googler*)
            echo "gLinx"
            ;;
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

# Add this device key to ssh-agent so it can be forwarded to remotes
ssh-add ~/.ssh/cterdam &> /dev/null

# Use conda python and pip instead of any system-installed versions
alias python3="python"
alias pip3="pip"

# Aliases for python and ipython
alias py="python"
alias ipy="ipython"

# Clear thoroughly
alias clear="clear && clear"

# Show Chinese characters; Do not show pycache
alias tree="tree -N -I '__pycache__'"

# Load secrets
source $secretfile

# Edit anything with vim
export EDITOR="vim"

# Use vim key bindings on cmdline
bindkey -v

# Do actual work here
cd $CTERDAMHOME

# Alias for ls
alias l="ls"

# Use gruvbox theme for bat
export BAT_THEME="gruvbox-dark"

# Use bat to view man pages
if [[ `sysname` == "macOS" ]]; then
    export MANPAGER="bat -p"
else
    export MANPAGER="bat -l man -p"
fi

# Load fzf shell integration
source <(fzf --zsh)

# Load Node Version Manager (NVM) if found
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# }}}
# {{{ AUTO

# Automatically run function when changing directory
function change_dir_auto() {

    # Run in zsh-compatible local mode
    emulate -L zsh

    # Auto ls
    ls

    # If in tmux, force redraw status line
    if [[ -n "$TMUX" ]]; then
        tmux refresh-client -S
    fi

}
if [[ ${chpwd_functions[(r)change_dir_auto]} != "change_dir_auto" ]]; then
  chpwd_functions+=("change_dir_auto")
fi

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

    # These commands are managed by the brew installation of chruby

    # Use chruby to manage alternative Ruby versions
    source $(brew --prefix)/opt/chruby/share/chruby/chruby.sh
    # Enable auto-switching of Rubies specified by .ruby-version files
    source $(brew --prefix)/opt/chruby/share/chruby/auto.sh

    # Configure ruby version for Jekyll for Github Pages
    chruby ruby-3.4.1

else

    export GEM_HOME="$HOME/gems"
    addpath $HOME/gems/bin tail

fi

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

# Fix issue where bat goes by batcat on some Linux systems
batexe=$CTERDAMBIN/bat
if [[ ! "$(command -v bat)" && "$(command -v batcat)" ]]; then
    ln -s `which batcat` $batexe
fi

# }}}
# TMUX {{{

# Pick correct tmux command name
if [ $(sysname) = "gLinx" ]; then
    # Use tmx2 as tmux command name on gLinux
    tmuxname=tmx2
    # Use tmux completion for tmx2
    compdef tmx2=tmux
else
    tmuxname=tmux
fi

# Start tmux session if not running
if [[ -z "$TMUX" ]]; then
    $tmuxname new-session -A -s $(sysname)
fi

# Make tmux refresh every second
# The same setting in tmux.conf doesn't seem to work
tmux set-option -g status-interval 1

# }}}
# GOOGLE {{{

if [ $(sysname) = "gLinx" ]; then

    # Use hgd
    source /etc/bash_completion.d/hgd

    # Load GDM common bashrc
    if [ -r /google/data/ro/teams/deepmind-eng/config/bashrc ] ; then
        source /google/data/ro/teams/deepmind-eng/config/bashrc
    fi
    # Load XManager bashrc
    if [ -r /google/data/ro/teams/dmgi/configs/google_xm_bashrc ] ; then
        source /google/data/ro/teams/dmgi/configs/google_xm_bashrc
    fi
    # Load Adbrain bashrc
    if [ -r /usr/share/adbrain/adbrain.sh ] ; then
        . /usr/share/adbrain/adbrain.sh
    fi

    # path shortcuts
    alias sa="cd learning/deepmind/incubation/applied_language/conv_ai/supportassist"
    alias gemax="cd learning/gemini/gemax/experimental/supportassist"
    alias gt="cd gdm/ads/geminitagger"
    alias exp="cd experimental/users/cterdam"

    # program shortcuts
    alias er='/google/data/ro/users/ho/hooper/er'
    alias hm='/google/bin/releases/heinzelmaennchen-team-policy/cli/hm'
    alias legoml='/google/data/ro/teams/legoml/legoml'
    alias bkill='/google/data/ro/teams/borgtools/bkill'
    alias colab="/google/bin/releases/grp-ix-team/rapid/colab-cli/cli.par"
    alias gemini='/google/bin/releases/gemini-cli/tools/gemini'

    # hg aliases
    alias hgs='hg status'
    alias hgl='hg citc -l'
    alias hgc='hg commit'
    alias hgmu='hg amend && hg ut'

    # Fig integration -----------------------------------------------------------------
    # go/zsh-prompt#zsh-fig-prompt-fig-status-fig-prompt-and-powerlevel10k-custom-segment

    ### Fig prompt file

    # Fig prompt file on google3
    figpromptsource=/google/src/files/head/depot/google3/experimental/fig_contrib/prompts/fig_status/zsh/fig_prompt

    # Location for fig prompt
    figpromptloc="$HOME/.figprompt"

    # Copy, if not already present
    if [[ -f $figpromptsource && ! -f $figpromptloc ]]; then
        cp $figpromptsource $figpromptloc
    fi

    # Source the fig prompt file
    source $figpromptloc

    ### Fig status file

    # Fig status file on google3
    figstatussource=/google/src/head/depot/google3/experimental/fig_contrib/prompts/fig_status/fig_status.py

    # Location for fig prompt
    figstatusloc="$HOME/.figstatus"

    # Copy, if not already present
    if [[ -f $figstatussource && ! -f $figstatusloc ]]; then
        cp $figstatussource $figstatusloc
    fi

    # Template Arguments:
    #   FIG_PROMPT_MODIFIED: Replaced with $modified
    #   FIG_PROMPT_ADDED: Replaced with $added
    #   FIG_PROMPT_DELETED: Replaced with $deleted
    #   FIG_PROMPT_UNKNOWN: Replaced with $unknown
    #   FIG_PROMPT_UNEXPORTED: Replaced with $unexported
    #   FIG_PROMPT_OBSOLETE: Replaced with $obsolete
    #   FIG_PROMPT_CL: Replaced with $cl
    #   FIG_PROMPT_DESCRIPTION: Replaced with $description
    #   FIG_PROMPT_CHANGENAME: Replaced with $changename
    #   FIG_PROMPT_HAS_SHELVE: Replaced with $has_shelve
    function get_fig_prompt_template() {
        echo -n '%F{black}FIG_PROMPT_ADDED'
        echo -n '%F{black}FIG_PROMPT_MODIFIED'
        echo -n '%F{black}FIG_PROMPT_DELETED'
        echo -n '%F{black}FIG_PROMPT_UNKNOWN'
        echo -n '%F{black}FIG_PROMPT_HAS_SHELVE'
        echo -n '%F{black}FIG_PROMPT_UNEXPORTED'
        echo -n '%F{black}FIG_PROMPT_OBSOLETE'
        echo -n '  %F{black}FIG_PROMPT_DESCRIPTION'
        echo -n ' %F{240}FIG_PROMPT_CL'
    }

    # Custom p10k segment for fig
    # Will only appear when the directory is a citc client
    function prompt_fig() {
        local fig_prompt
        fig_prompt="$(get_fig_prompt)"
        p10k segment -f 208 -c $fig_prompt -t $fig_prompt
    }

fi

# }}}
