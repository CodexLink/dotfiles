# dotfiles-configs-archive

Just a collection of configurations of mine.

## Prompt

<div align="center">

[![chips.omp.json git states showcase #1](https://github.com/CodexLink/chips.omp.json/blob/latest/assets/highlight_git_states_1.gif)](https://ohmyposh.dev/docs/themes#chips)

[![chips.omp.json on-the-spot env. change](https://github.com/CodexLink/chips.omp.json/blob/latest/assets/highlight_on_the_spot_env_change.gif)](https://ohmyposh.dev/docs/themes#chips)

</div>

I use Powershell ([pwsh](https://github.com/PowerShell/PowerShell)) with [oh-my-posh](https://github.com/JanDeDobbeleer/oh-my-posh) that uses a custom theme made by me ([chips.omp.json](https://github.com/CodexLink/chips.omp.json)). Wrapped through [Windows Terminal](https://github.com/microsoft/terminal).

- TODO

## `nvim`

### TODO
Video here for demo purposes.

### References for Configuration
> The following are references that I used for basis for my configuration. This can be dotfiles, guide, or whatever that helps me build this configuration.

- [folke's dotfiles](https://github.com/folke/dot/tree/master/config/nvim)
- [LSP Guide (lspconfig, null-ls, mason.nvim, etc.)](https://levelup.gitconnected.com/a-step-by-step-guide-to-configuring-lsp-in-neovim-for-coding-in-next-js-a052f500da2#429b)
- [Moving lines up or down](https://vim.fandom.com/wiki/Moving_lines_up_or_down)
- > [Seen on 'ThePrimeagen's Keybinds and Options (_to which I adapted some of it_)'](https://youtu.be/w7i4amO_zaE?t=1472)
- [LazyVim's `Events` for Lazy-Loading](https://github.com/LazyVim/LazyVim)

## Font

Iosevka + Pragmata Pro Variant (SS08) with Cherry-Picked Symbol Characters from [Nerd Fonts](https://github.com/ryanoasis/nerd-fonts).

### TODO

I have to rebuild this and think of a better font choice if we ever thought we want a new font.

### Font Properties

This font does not include the complete sets provided from Nerd Fonts. The following are the selected icon sets.

With the [Iosevka](https://github.com/be5invis/Iosevka)'s option allowing us to choose Normal, Italics, and Oblique; please note that Normal and Italics are only included.

Compiling them with [fontforge](https://github.com/fontforge/fontforge) with the script provided from the [nerd-fonts-patcher](https://github.com/ryanoasis/nerd-fonts) in addition to the PR request of supporting [TTC files](https://github.com/ryanoasis/nerd-fonts/tree/feature/process-ttc), the script silently fails.

Discretionary Ligatures (dilg) + Cherry-Picked Symbol Characters + Terminal Spacing - No Italic or Oblique Set.

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
