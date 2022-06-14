<!-- Only use `code` style for commands, hotkeys, and filenames. -->

# dotfiles

cterdam's personal computing environment setup for Unix-like (Mac) systems.

## Installing on a new Mac

### 1. Basic dependencies

- Download the [IBM Plex](https://www.ibm.com/plex/) font.

  - Follow the link to the Github releases page. Download the OpenType font
    from the latest release.

  - To install, after decompressing, drag all subfolders of the `OpenType`
    folder to Font Book.

- In the Mac terminal, type `git` to trigger downloading developer tools.

- Log in to [Github](https://github.com/) and follow its [tutorial][GHSSH] to
  set up a new SSH key.

  [GHSSH]:
  https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent

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

### 2. Programming Languages

- clang for C-family languages should come installed with the system.

- Install [Anaconda](https://www.anaconda.com/).

  - This should also install Python3, Jupyter, among
    [other packages](https://docs.anaconda.com/anaconda/packages/pkg-docs/).

- Install [Java](https://www.oracle.com/java/technologies/downloads/).

  - At time of writing, Java 17 is the latest LTS version.

- Install [Golang](https://go.dev/).

- Install tools for C#:

  - Install Microsoft's [.NET][.NET] SDK.

    [.NET]: https://dotnet.microsoft.com/en-us/download/dotnet

    - This installs command `dotnet` to build and run C# apps.

  - Install [Mono](https://www.mono-project.com/).

    - This installs commands `csc` and `mcs` to compile single C# files, as
      well as `mono` to run the compiled executable.

- Install [Node.js](https://nodejs.org/en/).

### 3. Development Environment

- Install [Oh My Zsh](https://ohmyz.sh/).

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

- Install [tmux](https://github.com/tmux/tmux) with `brew install tmux`.

  - When it's done, install [Tmux Plugin Manager][TPM]. Don't worry about
    installing actual plugins for now: `cterdam.tmux.conf` will take care of
    it.

    [TPM]: https://github.com/tmux-plugins/tpm

### 4. Other Packages

- Install other UNIX tools:

  ```zsh
  brew install bat git-delta less tree
  ```

- Install [Rime](https://rime.im/).

  - After installing Rime, install its [plum](https://github.com/rime/plum)
    package manager. First download it:

    ```zsh
    cd ~/cterdam
    git clone git@github.com:rime/plum.git
    ```

  - Then use it to download all Rime packages:

    ```zsh
    cd plum
    bash rime-install :all
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

  - Now run `vim` and it will auto install all plugins, including COC plugins.

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
  [`cterdam/profile`](https://github.com/cterdam/profile). To make it more
  accessible, after finishing with the above instructions, clone that repo
  into the `utility` directory:

  ```
  cd $CTERDAMRC/utility
  git clone git@github.com:cterdam/profile.git
  ```

- And drag the `utility` folder to the macOS Dock.

## Submodules

`github-markdown-css` is incorporated as a git submodule.

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

