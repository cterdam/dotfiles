# cfg

## Installing on macOS

### 1. Basic dependencies

- Download the [IBM Plex](https://www.ibm.com/plex/) font.

  - Follow the link to the Github releases page. Download the OpenType font from
    the latest release.

  - To install, after decompressing, drag all subfolders of the `OpenType`
    folder to Font Book.

- In terminal, run `xcode-select --install` to download developer tools.

- Follow [these steps](#setting-up-a-new-ssh-key) to set up a new SSH key for
  this device.

- Now clone this repo over SSH and destroy the dummy SSH config created in the
  previous step:

  ```zsh
  git clone --recursive git@github.com:cterdam/cfg.git ~/llz/cfg
  rm ~/.ssh/config
  ```

- Add `~/llz` to the Finder side bar and Dock.

- Set up terminal appearance by importing `hbpro.terminal` to terminal profiles.

- Install [Oh My Zsh](https://ohmyz.sh/).

  - After Oh My Zsh is installed and launched, install [ZSH theme and
    plugins](#zsh-theme-and-plugins).

### 2. Development Environment

- Install [Conda](https://docs.anaconda.com/miniconda/miniconda-install/).

- Install [Golang](https://go.dev/dl/).

- Install [Node.js](https://nodejs.org/en/download/prebuilt-installer).

- Install [Rust](https://www.rust-lang.org/tools/install).

  - Use the command found on the website. Prepend `sudo` and run it.

  - The installer might show some commands to run after installation. You can still
    run them to avoid any surprises, but the `zshrc` is supposed to take care of
    configuring the correct paths once activated.

### 3. Practical Tools

- Install [homebrew](https://brew.sh/).

  - Upon finishing installation, the script will print a 'Next steps' section which
    mentions two commands to run in order to add homebrew to PATH. Run them.

- Now install Neovim with `brew install neovim`.

  - Install [yarn](https://classic.yarnpkg.com/en/docs/install) with `sudo npm install
    --global yarn`.

    - This is for [markdown-preview][MDPV], and possibly some COC extensions.

    [MDPV]: https://github.com/iamcco/markdown-preview.nvim

  - Install [silicon](https://github.com/Aloxaf/silicon) with `brew install silicon`.

    - This is for [vim-silicon](https://github.com/segeljakt/vim-silicon).

  - Install [code-minimap][CODEMINIMAP] with `cargo install --locked code-minimap`

    [CODEMINIMAP]: https://github.com/wfxr/code-minimap

    - This is for [minimap.vim](https://github.com/wfxr/minimap.vim).

  - Install [universal-ctags][UCTAGS] with `brew install --HEAD universal-ctags`

    [UCTAGS]: https://github.com/liuchengxu/vista.vim/issues/159

    - This is for [vista.vim](https://github.com/liuchengxu/vista.vim).

- Install [tmux](https://github.com/tmux/tmux) with `brew install tmux`.

  - Also install [Tmux Plugin Manager](https://github.com/tmux-plugins/tpm) with
    `git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm`.

  - Don't worry about installing actual plugins for now: `dot/tmux.conf` will
    take care of it.

### 4. Activate shell scripts

- We have not dealt with `zshrc` in the new system yet, but the Conda and Oh My
  Zsh installation scripts should have created one in the home directory. Read
  it through, but everything there should already be incorporated into
  `zshrc` which will be installed later. So just delete it so we can use
  our own shell script:

  ```zsh
  rm $HOME/.zshrc
  ```

- Now activate the shell scripts:

  - Link `dot/zshrc` to the real `zshrc` location:

    ```zsh
    ln -s $HOME/llz/cfg/dot/zshrc $HOME/.zshrc
    ```

  - Restart shell, then restart again. Now type `Prefix` `Shift + I` to install
    tmux plugins.

    - `Prefix` is the tmux prefix, by default `Ctrl+b`.

  - Ensure ownership of vim and COC folders:

    ```zsh
    mkdir -p $HOME/.vim $HOME/.config
    sudo chown -R `whoami` $HOME/.vim
    sudo chown -R $(whoami) $HOME/.config
    ```

  - Now run `sudo nvim` and it will auto install all plugins, including COC
    plugins.

### 5. Secrets

- Obtain `.xyz.asc` from another machine, and put it in `$LLZDOT`
- Import the key into the local GPG agent: `gpg --import $LLZDOT/.xyz.asc`
  - Importing the public key should be unnecessary.
- Find the Key ID of the public key with `gpg --list-keys`
- Give the key the highest trust: `gpg --edit-key <KEY_ID>`

### 6. Other Packages

- Install [Docker](https://docs.docker.com/desktop/install/mac-install/).

- Install [Jekyll](https://jekyllrb.com/docs/installation/macos/) for GitHub
  pages.

  - The link basically says run these:

    ```zsh
    brew install chruby ruby-install xz
    ruby-install ruby 3.4.1
    ruby -v # 3.4.1 or above
    sudo gem install jekyll
    ```

- Install [Liberation
  Fonts](https://github.com/liberationfonts/liberation-fonts).

  - To install, simply download the TTF file from the latest release.

  - This is for the English resume.

- Install [MacTeX](https://tug.org/mactex/), the recommended LaTeX distribution
  for macOS.

  - Test `latexmk` and `latexindent`. If `latexindent` does not work, install the
    following packages:

    ```zsh
    sudo cpan install YAML::Tiny File::HomeDir Unicode::GCString
    ```

- Install [Rime](https://rime.im/) for Chinese input.

  - Rime needs to be used with its [plum](https://github.com/rime/plum) package
    manager, which is already incorporated as a submodule.

  - Install all default Rime packages:

    ```zsh
    cd $HOME/llz/cfg/plum
    bash rime-install :all
    ```

  - Then install the WU HAN Chinese and Cantonese Soeng-Ping packages:

    ```zsh
    bash rime-install cterdam/hubehua cterdam/jyutsp
    ```

  - Deploy Rime engine. Log out and log back in.

- Install other UNIX tools:

  ```zsh
  brew install gpg bat fzf git-delta git-lfs less tree tldr shellcheck jq reattach-to-user-namespace coreutils
  brew install xquartz --cask
  pip install vim-vint ipython black isort
  ```

  - `reattach-to-user-namespace` is needed for the `tmux-yank` plugin.
  - `xquartz` is needed for clipboard forwarding with SSH remote.

#### Optional Packages

- Install [Java](https://www.oracle.com/java/technologies/downloads/).

- Install [JupyterLab
  Desktop](https://github.com/jupyterlab/jupyterlab-desktop).

- Install [Octave](https://octave.org/index.html) with `brew install octave`.

- Install tools for C#:

  - Install Microsoft's [.NET][.NET] SDK.

    [.NET]: https://dotnet.microsoft.com/en-us/download/dotnet

    - This installs command `dotnet` to build and run C# apps.

  - Install [Mono](https://www.mono-project.com/).

    - This installs commands `csc` and `mcs` to compile single C# files, as well
      as `mono` to run the compiled executable.

### 6. Macvim

- To conveniently open files with vim from Finder, after finishing the above
  instructions, install [MacVim](https://macvim-dev.github.io/macvim/).

- Open MacVim Preferences, and set "After last window closes" to "Quit MacVim".

#### Register filetypes to open with MacVim

- Open this location in Finder:

  ```zsh
  cd $LLZHOME/cfg/fts/dummy
  open .
  ```

- Select all files, and press `Command + Option + I`. Select MacVim in the "Open
  with" menu, and click on "Change All...".

## Installing on a Linux remote

- To use an SSH key to connect to remote:

  - On the server, insert local public keys into this file. Comment lines can
    start with `#`.

    ```zsh
    vim ~/.ssh/authorized_keys
    ```

  - Locally, register an entry in `~/.ssh/config`.
    - Ensure `xauth` is installed on server.

- Change the default shell to `zsh`:

  ```zsh
  chsh -s $(which zsh)
  ```

## Setting up a new SSH key

This section is a *summary* of native instructions from GitHub found [here][GHSSH].

[GHSSH]: https://docs.github.com/en/authentication/connecting-to-github-with-ssh/about-ssh

- Produce a new pair of keys:

  ```zsh
  ssh-keygen -t ed25519 -C "your_email@example.com"
  ```

  Name the key after the device and save it in `~/.ssh`.

- Link that keypair to `llz` and `llz.pub`:

  ```zsh
  ln -s ~/.ssh/<KEY_NAME> ~/.ssh/llz
  ln -s ~/.ssh/<KEY_NAME>.pub ~/.ssh/llz.pub
  ```

- Copy the contents of `llz.pub`

  - If on macOS:

    ```sh
    cat ~/.ssh/llz.pub | pbcopy
    ```

  And add it to GitHub [here](https://github.com/settings/keys) both as an
  Authentication key and as a Signing key.

- Create the `~/.ssh/config` file, and insert this content:

  ```sshconfig
  Host github.com
      IdentityFile ~/.ssh/llz
  ```

## Zsh theme and plugins

```zsh
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
git clone https://github.com/esc/conda-zsh-completion ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/conda-zsh-completion
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/KellieOwczarczak/conda.plugin.zsh.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/conda
```

## Troubleshooting

### Adding new filetypes for MacVim

- Append the new filetype extension name, without the dot, as a new line into
  `$LLZHOME/cfg/fts/ftlist`. Do not leave empty lines in the file.

  - After inserting, sort all lines in the file. This can be done either in nvim
    by `:1,%sort`, or in the shell with `sort -o $LLZHOME/cfg/fts/ftlist{,}`.

- Then repopulate the `dummy` folder:

  ```zsh
  repopft $LLZHOME/cfg/fts/dummy $LLZHOME/cfg/fts/ftlist
  ```

  - It may simply create the needed new file(s), or print out other diagnostic messages.
    Follow them to fix the `dummy` folder and the `ftlist` file. If things are
    complicated, just remove the `dummy` directory altogether, and run the command
    again.

- Then, follow instructions in this [section](#register-filetypes-to-open-with-macvim)
  to register the new filetypes.

### Other troubles

- Conda cannot install.

  - If installation cannot start, change install to [for the current user only, as
    opposed for all users][CONDAUSERS].

    [CONDAUSERS]: https://stackoverflow.com/questions/75968081/i-cant-install-anaconda-on-a-macbook-pro-m1-with-ventura-13-3-1

  - If installation ultimately fails, [change the owner of shell config files to
    the current user][CONDATROUBLESHOOT]:

    [CONDATROUBLESHOOT]: https://docs.anaconda.com/anaconda/user-guide/troubleshooting/#the-installation-failed-message-when-running-a-pkg-installer-on-osx

    ```zsh
    sudo chown -R $USER ~/.bash_profile ~/.config/fish/config.fish ~/.tcshrc ~/.xonshrc ~/.zshrc
    ```

- After macOS update, some things fall apart. E.g. `git` disappears.

  - Reinstall Xcode Command Line Tools tools with `xcode-select --install`.

- COC Java plugin crashes.

  - This happens when the language server is started on the same directory multiple
    times. Just clear cache with `:CocCommand java.clean.workspace`.

- A different Java version is needed.

  - Any Java LTS version should work just fine, but if for any reason a lower
    version of Java is needed (e.g. Search Engines course), then the `jdt` for
    `coc-java` might not work correctly. In that case follow [this
    issue][JAVAISSUE] to replace the automatically-downloaded `jdt` with an
    older version which works with lower versions of Java. Specifically,

    ```txt
    Version 57 of JDT Lang Sever works fine
    https://download.eclipse.org/jdtls/milestones/0.57.0/

    Quick hack for those who are facing this issue
    Replace all directories/files in
    ~/.config/coc/extensions/coc-java-data/server
    with directories/files from above extracted JDT lang server tar.
    ```

    [JAVAISSUE]: https://github.com/neoclide/coc-java/issues/99

- Rust installation script needs to alter shell files which are nonexistent.

  - Just use the graphic installer. After running the installer, the installed
    Rust environment might not be in `$PATH` right away, but the our `zshrc`
    should take care of that once activated.

- Vim installed through brew does not seem to replace system vim.

  - Upon finishing installing the brew version, run `which vim` and you might
    see that it's still the system vim (and not the brew vim) which gets evoked.
    This is because brew-installed apps are not given priority in PATH.  Don't
    worry about it; `dot/zshrc` will fix this.

## Submodules

Use `git submodule status --recursive` to see all submodules.

If submodule folders appear empty after cloning, run this to download all:

```zsh
git submodule update --init --recursive
```

Note that updating the parent repo will not automatically update submodules.  To
update submodules:

```zsh
git submodule update --recursive --remote
```

Or, if cloning this parent repo for the first time, run this to download
everything:

```zsh
git clone --recursive <project url>
```
