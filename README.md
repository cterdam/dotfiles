<!-- Only use `code` style for commands, hotkeys, and filenames. -->

# dotfiles

cterdam's personal computing environment setup for Unix-like (Mac) systems.

## Installing on macOS

### 1. Basic dependencies

- Download the [IBM Plex](https://www.ibm.com/plex/) font.

  - Follow the link to the Github releases page. Download the OpenType font from the
    latest release.

  - To install, after decompressing, drag all subfolders of the `OpenType` folder to
    Font Book.

- In terminal, run `xcode-select --install` to download developer tools.

- Follow [these steps](#setting-up-a-new-ssh-key) to set up a new SSH key for this
  device.

- Now clone this repo over SSH and destroy the dummy SSH config created in the previous
  step:

  ```zsh
  git clone --recursive git@github.com:cterdam/dotfiles.git ~/cterdam/dotfiles
  rm ~/.ssh/config
  ```

- In Finder, add `~/cterdam` to the side bar.

- Set up terminal appearance by importing `hbpro.terminal` to terminal profiles.

- Install [Oh My Zsh](https://ohmyz.sh/).

  - After Oh My Zsh is installed and launched, install [ZSH theme and
    plugins](#zsh-theme-and-plugins).

### 2. Development Environment

- Install [Conda](https://docs.anaconda.com/miniconda/miniconda-install/).

- Install [Java](https://www.oracle.com/java/technologies/downloads/).

- Install [Golang](https://go.dev/dl/).

- Install [Node.js](https://nodejs.org/en/download/prebuilt-installer).

### 3. Practical Tools

- Install [homebrew](https://brew.sh/).

  - Upon finishing installation, the script will print a 'Next steps' section which
    mentions two commands to run in order to add homebrew to PATH. Run them.

- Now install [vim](https://www.vim.org/) with `brew install vim`.

  - MacOS already comes with a builtin distribution of vim, but the default version
    lacks many key features such as conceal, lua, perl, and python3. The version of vim
    on homebrew includes these features.

  - Install [yarn](https://classic.yarnpkg.com/en/docs/install) with `sudo npm install
    --global yarn`.

    - This is for [markdown-preview][MDPV], and possibly some COC extensions.

    [MDPV]: https://github.com/iamcco/markdown-preview.nvim

  - Install [Bash Language Server][BASHLS] with `sudo npm i -g bash-language-server`.

    [BASHLS]: https://github.com/bash-lsp/bash-language-server

    - This is for [COC-sh](https://github.com/josa42/coc-sh).

  - Install [Rust](https://www.rust-lang.org/tools/install).

    - Use the command found on the website. Prepend `sudo` and run it.

    - The installer might show some commands to run after installation. You can still
      run them to avoid any surprises, but the `zshrc` is supposed to take care of
      configuring the correct paths once activated.

    - And install [silicon](https://github.com/Aloxaf/silicon) with `brew install
      silicon`.

    - This is for [vim-silicon](https://github.com/segeljakt/vim-silicon).

  - Install [Universal Ctags][UCTAGS] with `brew install --HEAD universal-ctags`

    [UCTAGS]: https://github.com/liuchengxu/vista.vim/issues/159

    - This is for [vista.vim](https://github.com/liuchengxu/vista.vim).

- Install [tmux](https://github.com/tmux/tmux) with `brew install tmux`.

  - Also install [Tmux Plugin Manager](https://github.com/tmux-plugins/tpm) with `git
    clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm`.

  - Don't worry about installing actual plugins for now: `cterdam.tmux.conf` will take
    care of it.

### 4. Activate shell scripts

- We have not dealt with `zshrc` in the new system yet, but the Conda and Oh My Zsh
  installation scripts should have created one in the home directory. Read it through,
  but everything there should already be incorporated into `cterdam.zshrc` which will be
  installed later. So just delete it so we can use our own shell script:

  ```zsh
  rm $HOME/.zshrc
  ```

- Now activate the shell scripts:

  - Link `cterdam.zshrc` to the real `zshrc` location:

    ```zsh
    ln -s $HOME/cterdam/dotfiles/cterdam.zshrc $HOME/.zshrc
    ```

  - Restart shell, then restart again. Now type `Prefix` `Shift + I` to install tmux
    plugins.

    - `Prefix` is the tmux prefix, by default `Ctrl+b`.

  - Ensure ownership of vim and COC folders:

    ```zsh
    sudo chown -R `whoami` $HOME/.vim
    sudo chown -R $(whoami) $HOME/.config
    ```

  - Now run `sudo vim` and it will auto install all plugins, including COC plugins.

### 5. Other Packages

- Install [Docker](https://docs.docker.com/desktop/install/mac-install/).

- Install [JupyterLab Desktop](https://github.com/jupyterlab/jupyterlab-desktop).

- Install [Jekyll](https://jekyllrb.com/docs/installation/macos/) for GitHub pages.

  - The link basically says run these:

    ```zsh
    brew install chruby ruby-install xz
    ruby-install ruby 3.1.3
    ruby -v # 3.1.3p185 or above
    sudo gem install jekyll
    ```

- Install [Liberation Fonts](https://github.com/liberationfonts/liberation-fonts).

  - To install, simply download the TTF file from the latest release.

  - This is for the English resume.

- Install [MacTeX](https://tug.org/mactex/), the recommended LaTeX distribution for
  macOS.

  - Test `latexmk` and `latexindent`. If `latexindent` does not work, install the
    following packages:

    ```zsh
    sudo cpan install YAML::Tiny File::HomeDir Unicode::GCString
    ```

- Install [Rime](https://rime.im/) for Chinese input.

  - Rime needs to be used with its [plum](https://github.com/rime/plum) package manager,
    which is already incorporated as a submodule.

  - Install all default Rime packages:

    ```zsh
    cd $HOME/cterdam/dotfiles/plum
    bash rime-install :all
    ```

  - Then install the WU HAN Chinese and Cantonese Soeng-Ping packages:

    ```zsh
    bash rime-install cterdam/hubehua cterdam/jyutsp
    ```

  - Deploy Rime engine. Log out and log back in.

- Install other UNIX tools:

  ```zsh
  brew install bat git-delta git-lfs less tree tldr shellcheck jq reattach-to-user-namespace
  brew install xquartz --cask
  pip install vim-vint ipython black
  ```

  - `reattach-to-user-namespace` is needed for the `tmux-yank` plugin.

#### Optional Packages

- Install [Octave](https://octave.org/index.html) with `brew install octave`.

- Install tools for C#:

  - Install Microsoft's [.NET][.NET] SDK.

    [.NET]: https://dotnet.microsoft.com/en-us/download/dotnet

    - This installs command `dotnet` to build and run C# apps.

  - Install [Mono](https://www.mono-project.com/).

    - This installs commands `csc` and `mcs` to compile single C# files, as well as
      `mono` to run the compiled executable.

### 6. Macvim

- To conveniently open files with vim from Finder, after finishing the above
  instructions, install [MacVim](https://macvim-dev.github.io/macvim/).

- Open MacVim Preferences, and set "After last window closes" to "Quit MacVim".

#### Register filetypes to open with MacVim

- Open this location in Finder:

  ```zsh
  cd $CTERDAMRC/fts/dummy
  open .
  ```

- Select all files, and press `Command + Option + I`. Select MacVim in the "Open with"
  menu, and click on "Change All...".

### 7. Profile

- Files related to personal information are stored in another private repo
  [`cterdam/profile`](https://github.com/cterdam/profile), incorporated as a submodule
  in the `utility` directory.

- Drag the `utility` folder to the macOS Dock.

## Installing on a Linux remote

### Remote access

- To use an SSH key to connect to remote:

  - On the server, insert local public keys into this file. Comment lines can start with
    `#`.

    ```zsh
    vim ~/.ssh/authorized_keys
    ```

  - Locally, register an entry in `~/.ssh/config`.

    - Use `ForwardAgent yes` so the remote can use the local's ssh-agent for things like
      GitHub, without needing its separate key.

  - Optionally, make a local executable for connection in `$CTERDAMRC/exe`.

- Optionally, use X11 to forward clipboard content from remote to local:

  - Ensure that remote `/etc/ssh/sshd_config` contains this line:

    ```zsh
    X11Forwarding yes
    ```

  - Ensure `xauth` is installed on server.

  - If connecting through local macOS, ensure that local connections are made from
    XQuartz, and that `$DISPLAY` is set.

  - Either use `ssh -Y -C` each session, or add these to local `ssh` config:

    ```zsh
    ForwardX11 yes
    ForwardX11Timeout 0
    Compression yes
    ```

### Environment setup

- Change the default shell to `zsh`:

  ```zsh
  chsh -s $(which zsh)
  ```

- Clone this repo over SSH:

  ```zsh
  git clone --recursive git@github.com:cterdam/dotfiles.git ~/cterdam/dotfiles
  ```

- Install [Oh My Zsh](https://ohmyz.sh/).

  - After Oh My Zsh is installed and launched, install [ZSH theme and
    plugins](#zsh-theme-and-plugins).

- Install [Conda](https://docs.anaconda.com/miniconda/miniconda-install/).

  - Retrieve the installer with `wget` and run it with the default shell.

  - When the installer finishes, inspect the paragraph it inserts into the default shell
    config. Update `cterdam.zshrc` with that conda location.

- Install [Tmux Plugin Manager][TPM].

  [TPM]: https://github.com/tmux-plugins/tpm

  - The install instruction should just amount to cloning a repo into this location:

    ```zsh
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    ```

  - No need to manually change `~/.tmux.conf` because this is covered in shell scripts.

- Now activate shell scripts:

  - Delete old `zshrc`:

    ```zsh
    rm $HOME/.zshrc
    ```

  - Link `cterdam.zshrc` to the real `zshrc` location:

    ```zsh
    ln -s $HOME/cterdam/dotfiles/cterdam.zshrc $HOME/.zshrc
    ```

  - Restart shell, then restart again. Now type `Prefix` `Shift + I` to install tmux
    plugins.

    - `Prefix` is the tmux prefix, by default `Ctrl+b`.

- Install additional packages if they are not already on the cluster:

    ```zsh
    conda install tmux nodejs rust go
    npm install yarn bash-language-server
    conda install -c conda-forge vim bat git-delta tree tldr universal-ctags
    pip install vim-vint black
    ```

## Installing on a new Deep Learning EC2 instance

- On local machine, register remote instance in `~/.ssh/config`:

  ```config
  Host <NICKNAME>
      HostName ec2-12-345-67-890.compute-1.amazonaws.com
      User ubuntu
      IdentityFile ~/.ssh/my_key.pem
  ```

- SSH into the instance, then do all the work there.

- Follow [these steps](#setting-up-a-new-ssh-key) to set up a new SSH key for this
  device.

- Now clone this repo over SSH and destroy the dummy SSH config created in the previous
  step:

  ```zsh
  git clone --recursive git@github.com:cterdam/dotfiles.git ~/cterdam/dotfiles
  rm ~/.ssh/config
  ```

- Run the setup script with `bash $HOME/cterdam/dotfiles/server_setup.sh`

- This will automate most of what's in this README file on a Linux environment.

- C family languages, Anaconda and Java should come pre-installed in Deep Learning AMI.
  Due to being on a Linux server, this script does not install .NET, Latex, and Rime.

- After the script finishes, you will be taken to zsh. Manually run the following:

  ```zsh
  rm $HOME/.*.pre-oh-my-zsh* || true
  rm $HOME/.zshrc || true
  ln -s $HOME/cterdam/dotfiles/cterdam.zshrc $HOME/.zshrc
  ```

- Then log out and back in the remote instance. Go to `tmux` and send `Prefix` `Shift+I`
  to install tmux plugins.

- If the local instance is also running `tmux`, then these keys might need to be sent
  twice in order to reach the remote instance. That is, press `Prefix` `Prefix`
  `Shift+I` `Shift+I`. The default Prefix for `tmux` is `Ctrl+B`.

- Launch `vim` to install vim plugins.

- Init conda with `conda init zsh` and re-login.

- Install other packages which couldn't be installed without re-sourcing the shell:

  ```zsh
  gem install jekyll bundler
  ```

## Setting up a new SSH key

This section is a *summary* of native instructions from GitHub found [here][GHSSH].

[GHSSH]: https://docs.github.com/en/authentication/connecting-to-github-with-ssh/about-ssh

- Produce a new pair of keys:

  ```zsh
  ssh-keygen -t ed25519 -C "your_email@example.com"
  ```

  Name the key after the device and save it in `~/.ssh`.

- Link that keypair to `cterdam` and `cterdam.pub`:

  ```zsh
  ln -s ~/.ssh/<KEY_NAME> ~/.ssh/cterdam
  ln -s ~/.ssh/<KEY_NAME>.pub ~/.ssh/cterdam.pub
  ```

- Copy the contents of `cterdam.pub`

  ```zsh
  cat ~/.ssh/cterdam.pub | pbcopy
  ```

  And add it to GitHub [here](https://github.com/settings/keys) both as an
  Authentication key and as a Signing key.

- Create the `~/.ssh/config` file, and insert this content:

  ```sshconfig
  Host github.com
      IdentityFile ~/.ssh/cterdam
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
  `$CTERDAMRC/fts/ftlist`. Do not leave empty lines in the file.

  - After inserting, sort all lines in the file. This can be done either in vim by
    `:1,%sort`, or in the shell with `sort -o $CTERDAMRC/fts/ftlist{,}`.

- Then repopulate the `dummy` folder:

  ```zsh
  repopft $CTERDAMRC/fts/dummy $CTERDAMRC/fts/ftlist
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

  - If installation ultimately fails, [change the owner of shell config files to the
    current user][CONDATROUBLESHOOT]:

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

  - Any Java LTS version should work just fine, but if for any reason a lower version of
    Java is needed (e.g. Search Engines course), then the `jdt` for `coc-java` might not
    work correctly. In that case follow [this issue][JAVAISSUE] to replace the
    automatically-downloaded `jdt` with an older version which works with lower versions
    of Java. Specifically,

    ```
    Version 57 of JDT Lang Sever works fine
    https://download.eclipse.org/jdtls/milestones/0.57.0/

    Quick hack for those who are facing this issue
    Replace all directories/files in
    ~/.config/coc/extensions/coc-java-data/server
    with directories/files from above extracted JDT lang server tar.
    ```

    [JAVAISSUE]: https://github.com/neoclide/coc-java/issues/99

- Rust installation script needs to alter shell files which are nonexistent.

  - Just use the graphic installer. After running the installer, the installed Rust
    environment might not be in `$PATH` right away, but the our `zshrc` should take care
    of that once activated.

- Vim installed through brew does not seem to replace system vim.

  - Upon finishing installing the brew version, run `which vim` and you might see that
    it's still the system vim (and not the brew vim) which gets evoked. This is because
    brew-installed apps are not given priority in PATH.  Don't worry about it;
    `cterdam.zshrc` will fix this.

## Submodules

Use `git submodule status --recursive` to see all submodules.

If submodule folders appear empty after cloning, run this to download all submodules
(and their submodules, if any):

```zsh
git submodule update --init --recursive
```

Note that updating the parent repo will not automatically update submodules.  To update
submodules, since git 1.8.2 the option `--remote` was added to support updating to
latest tips of remote branches:

```zsh
git submodule update --recursive --remote
```

Or, if cloning this parent repo for the first time, run this to ensure you download
everything:

```zsh
git clone --recursive <project url>
```
