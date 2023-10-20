<!-- Only use `code` style for commands, hotkeys, and filenames. -->

# dotfiles

cterdam's personal computing environment setup for Unix-like (Mac) systems.

## Installing on macOS

### 1. Basic dependencies

- Download the [IBM Plex](https://www.ibm.com/plex/) font.

  - Follow the link to the Github releases page. Download the OpenType font
    from the latest release.

  - To install, after decompressing, drag all subfolders of the `OpenType`
    folder to Font Book.

- In terminal, run `xcode-select --install` to download developer tools.

- Follow [these steps](#setting-up-a-new-ssh-key) to set up a new SSH key for
  this device.

- Now clone this repo over SSH and destroy the dummy SSH config created in the
  previous step:

  ```zsh
  git clone --recursive git@github.com:cterdam/dotfiles.git ~/cterdam/dotfiles
  rm ~/.ssh/config
  ```

- Set up terminal appearance by importing `hbpro.terminal` to terminal
  profiles.

- Install [Oh My Zsh](https://ohmyz.sh/).

  - After Oh My Zsh is installed and launched, install custom ZSH theme and
    plugins:

    ```zsh
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
    git clone https://github.com/esc/conda-zsh-completion ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/conda-zsh-completion
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    ```

### 2. Development Environment

- clang for C-family languages should come installed with the system.

- Install [Anaconda](https://www.anaconda.com/).

  - This should also install Python3, Jupyter, among
    [other packages](https://docs.anaconda.com/anaconda/packages/pkg-docs/).

- Install [Java](https://www.oracle.com/java/technologies/downloads/).

  - At time of writing, Java 17 is the latest LTS version.

    - Java 17 or any other LTS version should work just fine, but if for any
      reason a lower version of Java is needed (e.g. Search Engines course),
      then the `jdt` for `coc-java` might not work correctly. In that case
      follow [this issue][JAVAISSUE] to replace the automatically-downloaded
      `jdt` with an older version which works with lower versions of Java.

      - Specifically,

      ```
      Version 57 of JDT Lang Sever works fine
      https://download.eclipse.org/jdtls/milestones/0.57.0/

      Quick hack for those who are facing this issue
      Replace all directories/files in
      ~/.config/coc/extensions/coc-java-data/server
      with directories/files from above extracted JDT lang server tar.
      ```

      [JAVAISSUE]: https://github.com/neoclide/coc-java/issues/99

- Install [Golang](https://go.dev/).

- Install tools for C#:

  - Install Microsoft's [.NET][.NET] SDK.

    [.NET]: https://dotnet.microsoft.com/en-us/download/dotnet

    - This installs command `dotnet` to build and run C# apps.

  - Install [Mono](https://www.mono-project.com/).

    - This installs commands `csc` and `mcs` to compile single C# files, as
      well as `mono` to run the compiled executable.

- Install [Node.js](https://nodejs.org/en/).

### 3. Practical Tools

- Install [homebrew](https://brew.sh/).

  - Upon finishing installation, the script will print a 'Next steps' section
    which mentions two commands to run in order to add homebrew to PATH. Run
    them.

- Now install [vim](https://www.vim.org/) with `brew install vim`.

  - MacOS already comes with a builtin distribution of vim, but the default
    version lacks many key features such as conceal, lua, perl, and
    python3. The version of vim on homebrew includes these features.

  - Upon finishing installing the brew version, run `which vim` and you might
    see that it's still the system vim (and not the brew vim) which gets
    evoked. This is because brew-installed apps are not given priority in PATH.
    Don't worry about it; `cterdam.zshrc` will fix this.

  - Install [yarn](https://classic.yarnpkg.com/en/) with `sudo npm install
    --global yarn`.

    - This is for [markdown-preview][MDPV], and possibly some COC extensions.

    [MDPV]: https://github.com/iamcco/markdown-preview.nvim

  - Install [Bash Language Server][BASHLS] with `sudo npm i -g
    bash-language-server`.

    [BASHLS]: https://github.com/bash-lsp/bash-language-server

    - This is for [COC-sh](https://github.com/josa42/coc-sh).

  - Install [Rust](https://www.rust-lang.org/).

    - And install [silicon](https://github.com/Aloxaf/silicon) with `brew
      install silicon`.

    - This is for [vim-silicon](https://github.com/segeljakt/vim-silicon).

  - Install [Universal Ctags][UCTAGS] with `brew install --HEAD
    universal-ctags/universal-ctags/universal-ctags`

    [UCTAGS]: https://github.com/liuchengxu/vista.vim/issues/159

    - This is for [vista.vim](https://github.com/liuchengxu/vista.vim).
    

- Install [tmux](https://github.com/tmux/tmux) with `brew install tmux`.

  - When it's done, install [Tmux Plugin Manager][TPM]. Don't worry about
    installing actual plugins for now: `cterdam.tmux.conf` will take care of
    it.

    [TPM]: https://github.com/tmux-plugins/tpm

### 4. Other Packages

#### Programming Languages Cont'd

- Install [Octave](https://octave.org/index.html) with `brew install octave`.

#### Jekyll for Github Pages

- Install [Jekyll](https://jekyllrb.com/docs/installation/macos/).

  - The above link basically tells you to run these:

    ```zsh
    brew install chruby ruby-install xz
    ruby-install ruby 3.1.3
    ruby -v # 3.1.3p185 or above
    sudo gem install jekyll
    ```

#### Other Fonts

- Install [Liberation Fonts][LIBFONT].

  - Installation requires the fontforge command, which can be installed with
    `brew install fontforge`.

  - Installation also requires the `fonttools` Python package, which should
    come installed with Anaconda.

  - This is for the English resume.

  [LIBFONT]: https://github.com/liberationfonts/liberation-fonts

#### Misc

- Install other UNIX tools:

  ```zsh
  brew install bat git-delta less tree tldr shellcheck jq
  pip install vim-vint
  ```

- Install [Rime](https://rime.im/).

  - Rime needs to be used with its [plum](https://github.com/rime/plum)
    package manager, which is already incorporated as a submodule.

  - Install all default Rime packages:

    ```zsh
    cd $HOME/cterdam/dotfiles/plum
    bash rime-install :all
    ```

  - Then install the WU HAN Chinese and Cantonese Soeng-Ping packages:

    ```zsh
    bash rime-install yuxifongfei/hubehua MrCorn0-0/jyutsp
    ```

- Install [MacTeX](https://tug.org/mactex/), the recommended LaTeX
  distribution for macOS.

  - Test `latexmk` and `latexindent`. If `latexindent` does not work, install
    the following packages:

    ```zsh
    sudo cpan install YAML::Tiny File::HomeDir Unicode::GCString
    ```

### 5. Activate shell scripts

- We have not dealt with `zshrc` in the new system yet, but the Anaconda and Oh
  My Zsh installation scripts should have created one in the home directory.
  Read it through, but everything there should already be incorporated into
  `cterdam.zshrc` which will be installed later. So just delete it so we can use
  our own shell script:

  ```zsh
  rm $HOME/.zshrc
  ```

- Now activate the shell scripts:

  - Link `cterdam.zshrc` to the real `zshrc` location:

    ```zsh
    ln -s $HOME/cterdam/dotfiles/cterdam.zshrc $HOME/.zshrc
    ```

  - Restart shell, then restart again. Now type `Prefix` `Shift + I` to
    install tmux plugins.

    - `Prefix` is the tmux prefix, by default `Ctrl+b`.

  - To prevent COC from throwing permission errors in vim, first reset
    permissions for the `$HOME/.config` folder:

    ```zsh
    sudo chown -R $(whoami) $HOME/.config
    ```

  - Now run `sudo vim` and it will auto install all plugins, including COC
    plugins.

    - Currently, C# diagnostics and completion in Vim is supported by
      [omnisharp-vim][ONSV], and not part of COC. Check if COC has an active
      [extension][COCEX] for C#. If yes, switch away from omnisharp-vim. If
      no, the existing script integrates omnisharp-vim well already. Just open
      any `.cs` file and follow the instruction and type `Y` to download the
      language server.

      [ONSV]: https://github.com/OmniSharp/omnisharp-vim
      [COCEX]: https://github.com/neoclide/coc.nvim/wiki/Using-coc-extensions

  - Deploy Rime engine.

### 6. Macvim

- To conveniently open files with vim from Finder, after finishing the above
  instructions, install [MacVim](https://macvim-dev.github.io/macvim/).

- Open MacVim Preferences, and set "After last window closes" to "Quit
  MacVim".

#### Register filetypes to open with MacVim

- Open this location in Finder:

  ```zsh
  cd $CTERDAMRC/fts/dummy
  open .
  ```

- Select all files, and press `Command + Option + I`. Select MacVim in the
  "Open with" menu, and click on "Change All...".

#### Adding new filetypes

- Append the new filetype extension name, without the dot, as a new line into
  `$CTERDAMRC/fts/ftlist`. Do not leave empty lines in the file.

  - After inserting, sort all lines in the file. This can be done either in
    vim by `:1,%sort`, or in the shell with `sort -o
    $CTERDAMRC/fts/ftlist{,}`.

- Then repopulate the `dummy` folder:

  ```zsh
  repopft $CTERDAMRC/fts/dummy $CTERDAMRC/fts/ftlist
  ```

  - It may simply create the needed new file(s), or print out other diagnostic
    messages.  Follow them to fix the `dummy` folder and the `ftlist` file. If
    things are complicated, just remove the `dummy` directory altogether, and
    run the command again.

- Then, follow instructions in the last section to register the new filetypes.

### 7. Profile

- Files related to personal information are stored in another private repo
  [`cterdam/profile`](https://github.com/cterdam/profile), incorporated as a
  submodule in the `utility` directory.

- Drag the `utility` folder to the macOS Dock.

## Installing on a Linux server without sudo access

- Configure SSH connection on server:

  ```zsh
  vim ~/.ssh/authorized_keys
  ```

  - Paste the public key of any connecting device into this file.
    Comment lines can start with `#`.

- Change the default shell to `zsh`:

  ```zsh
  chsh -s $(which zsh)
  ```

- Follow [these steps](#setting-up-a-new-ssh-key) to set up a new SSH key for
  this device.

- Now clone this repo over SSH and destroy the dummy SSH config created in the
  previous step:

  ```zsh
  git clone --recursive git@github.com:cterdam/dotfiles.git ~/cterdam/dotfiles
  rm ~/.ssh/config
  ```


- Install [Oh My Zsh](https://ohmyz.sh/).

  - After Oh My Zsh is installed and launched, install custom ZSH theme and
    plugins:

    ```zsh
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
    git clone https://github.com/esc/conda-zsh-completion ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/conda-zsh-completion
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    ```

- Install Anaconda.

  - Retrieve the [Anaconda installer](https://www.anaconda.com/download) with
    `wget` and run it with the default shell.

  - When the installer finishes, inspect the paragraph it inserts into the
    default shell config. Update `cterdam.zshrc` with that conda location.

- Install [Tmux Plugin Manager][TPM].

  [TPM]: https://github.com/tmux-plugins/tpm

- Now activate the shell scripts:

  - Delete old `zshrc`:

    ```zsh
    rm $HOME/.zshrc
    ```

  - Link `cterdam.zshrc` to the real `zshrc` location:

    ```zsh
    ln -s $HOME/cterdam/dotfiles/cterdam.zshrc $HOME/.zshrc
    ```

  - Restart shell, then restart again. Now type `Prefix` `Shift + I` to
    install tmux plugins.

    - `Prefix` is the tmux prefix, by default `Ctrl+b`.

- Install additional packages if they are not already on the cluster:

    ```zsh
    conda install tmux nodejs rust go
    npm install yarn bash-language-server
    conda install -c conda-forge vim bat git-delta tree tldr universal-ctags
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

- Follow [these steps](#setting-up-a-new-ssh-key) to set up a new SSH key for
  this device.

- Now clone this repo over SSH and destroy the dummy SSH config created in the
  previous step:

  ```zsh
  git clone --recursive git@github.com:cterdam/dotfiles.git ~/cterdam/dotfiles
  rm ~/.ssh/config
  ```

- Run the setup script with `bash $HOME/cterdam/dotfiles/server_setup.sh`

- This will automate most of what's in this README file on a Linux
  environment.

- C family languages, Anaconda and Java should come pre-installed in Deep
  Learning AMI. Due to being on a Linux server, this script does not
  install .NET, Latex, and Rime.

- After the script finishes, you will be taken to zsh. Manually run the
  following:

  ```zsh
  rm $HOME/.*.pre-oh-my-zsh* || true
  rm $HOME/.zshrc || true
  ln -s $HOME/cterdam/dotfiles/cterdam.zshrc $HOME/.zshrc
  ```

- Then log out and back in the remote instance. Go to `tmux` and send `Prefix`
  `Shift+I` to install tmux plugins.

- If the local instance is also running `tmux`, then these keys might need
  to be sent twice in order to reach the remote instance. That is, press
  `Prefix` `Prefix` `Shift+I` `Shift+I`. The default Prefix for `tmux` is
  `Ctrl+B`.

- Launch `vim` to install vim plugins.

- Init conda with `conda init zsh` and re-login.

- Install other packages which couldn't be installed without re-sourcing the
  shell:

  ```zsh
  gem install jekyll bundler
  ```

## Setting up a new SSH key

- Produce a new pair of keys:

  ```zsh
  ssh-keygen -t ed25519 -C "your_email@example.com"
  ```

  Name the key after the device and save it in `~/.ssh`.

- Link that keypair to `cterdam` and `cterdam.pub`:

  ```zsh
  ln -s ~/.ssh/<PRIVATE_KEY> ~/.ssh/cterdam
  ln -s ~/.ssh/<PUBLIC_KEY> ~/.ssh/cterdam.pub
  ```

- Add the contents of `cterdam.pub` to GitHub as a new SSH key.

- Create the `~/.ssh/config` file, and insert this content:

  ```sshconfig
  Host github.com
      IdentityFile ~/.ssh/cterdam
  ```


## Troubleshooting

- Anaconda cannot install.

  - If installation cannot start, change install to [for the current user
    only, as opposed for all users][CONDAUSERS].

    [CONDAUSERS]: https://stackoverflow.com/questions/75968081/i-cant-install-anaconda-on-a-macbook-pro-m1-with-ventura-13-3-1

  - If installation ultimately fails, [change the owner of shell config files
    to the current user][CONDATROUBLESHOOT]:

    [CONDATROUBLESHOOT]: https://docs.anaconda.com/anaconda/user-guide/troubleshooting/#the-installation-failed-message-when-running-a-pkg-installer-on-osx

    ```zsh
    sudo chown -R $USER ~/.bash_profile ~/.config/fish/config.fish ~/.tcshrc ~/.xonshrc ~/.zshrc
    ```

- After macOS update, some things fall apart. E.g. `git` disappears.

  - Reinstall Xcode Command Line Tools tools by running
    `xcode-select --install`.

- COC Java plugin crashes.

  - This happens when the language server is started on the same directory
    multiple times. Just clear cache with `:CocCommand java.clean.workspace`.

## Submodules

Use `git submodule status --recursive` to see all submodules.

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

