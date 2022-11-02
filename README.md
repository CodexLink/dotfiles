# dotfiles-configs-archive

Just a collection of configurations that I commonly use.

## Notice

**It's under construction.**

## Prompt

I use Powershell ([pwsh](https://github.com/PowerShell/PowerShell)) along with [oh-my-posh](https://github.com/JanDeDobbeleer/oh-my-posh) that uses a custom theme made by me ([chips.omp.json](https://github.com/CodexLink/chips.omp.json)). Wrapped through [Windows Terminal](https://github.com/microsoft/terminal).

- TODO

### Demo

TODO

## `nvim`

TODO

### Bases

The following are the base configuration that I followed or looked through:

- [craftzdog's dotfiles](https://github.com/craftzdog/dotfiles-public/blob/master/.config/nvim/lua/craftzdog/plugins.lua)
- [wbthomason's dotfiles](https://github.com/wbthomason/dotfiles/blob/linux/neovim/.config/nvim/lua/plugins.lua)

### Demo

TODO

## Font

Iosevka + Pragmata Pro Variant (SS08) with Cherry-Picked Symbol Characters from [Nerd Fonts](https://github.com/ryanoasis/nerd-fonts).

### Font Properties

This font does not include the complete sets provided from Nerd Fonts. The following are the selected icon sets.

With the [Iosevka](https://github.com/be5invis/Iosevka)'s option allowing us to choose Normal, Italics, and Oblique; please note that Normal and Italics are only included.

Compiling them with [fontforge](https://github.com/fontforge/fontforge) with the script provided from the [nerd-fonts-patcher](https://github.com/ryanoasis/nerd-fonts) in addition to the PR request of supporting [TTC files](https://github.com/ryanoasis/nerd-fonts/tree/feature/process-ttc), the script silently fails.

D]iscretionary Ligatures (dilg) + Cherry-Picked Symbol Characters + Terminal Spacing - No Italic or Oblique Set.

<Picture Here>

### How to Build

You need to pull the docker repository and build the docker on your own. That is if you were having problems with the script not running due to characters. That was an issue to encoding. I recommend building the font in Docker Container. `git pull`ing the repository is huge, therefore not recommended.

```txt
docker build -t iosevka-build .; docker run -it -v ${PWD}:/build iosevka-build super-ttc::iosevka-codex-link
```

### Patching with Nerd Font

I'm aware that Nerd Font Patcher doesn't like TTC files, therefore you need to adjust by setting things up by yourself.

Please fetch the `font-patcher.py` from the [feature/process-tcc] branch and replace it from the current upstream local branch that you have.

...

> To be continued.

```
.\fontforge -script font-patcher.py --glyphdir ./glyphs/ --mono --windows --complete --careful --progressbars E:\Developments\Forks\iosevka-docker\dist/.super-ttc/iosevka-codex-link.ttc -out E:\Developments\Forks\iosevka-docker\dist\patched-nerd-fonts
```

We should consider this cherry-picked version.

```
.\ffpython font-patcher.py --glyphdir ./glyphs/ --adjust-line-height --careful --codicons --fontawesome --fontawesomeextension --material --mono --octicons --powerline --powerlineextra --progressbars --weather --windows E:\Developments\Forks\iosevka-docker\dist/.super-ttc/iosevka-codex-link.ttc -out E:\Developments\Forks\iosevka-docker\dist\patched-nerd-fonts
```

## Credits

> Currently on construction.

- Base Configuration for OMP (Oh-My-Posh) [Inspiration] | https://www.youtube.com/watch?v=5-aK2_WwrmMa
- Command to Clipboard | https://stackoverflow.com/questions/43633273/copy-current-location-to-clipboard
- PowerShell Command Function Creation | https://docs.microsoft.com/en-us/powershell/scripting/learn/ps101/09-functions?view=powershell-7.2
- ??? | https://stackoverflow.com/questions/61824177/visual-block-mode-not-working-in-vim-with-c-v-on-wslwindows-10
- (VIM) Multiple Lines at Ones | https://riptutorial.com/vim/example/7301/insert-text-into-multiple-lines-at-once
- ??? | For allowing to let us build in docker environment. https://github.com/avivace/iosevka-docker
- https://jdhitsolutions.com/blog/powershell/8969/powershell-predicting-with-style/
- https://devblogs.microsoft.com/powershell/announcing-psreadline-2-1-with-predictive-intellisense/
- https://stackoverflow.com/questions/63079605/powershell-6-0-command-line-background-color-with-ansi-sequences-psreadline
- https://docs.microsoft.com/en-us/powershell/module/psreadline/set-psreadlineoption?view=powershell-7.2
- https://stackoverflow.com/questions/71283083/accept-part-of-the-autocompletion
