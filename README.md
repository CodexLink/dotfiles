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

Iosevka + Pragmata Pro Variant (SS08) with Complete Set of [Nerd Fonts](https://github.com/ryanoasis/nerd-fonts).

_Baked with Iosevka's Build Script, Created in TTF format, patched with Nerd Font's Font Patcher in the following parameters: `--complete --mono`_

[![Iosevka Configuration #1](https://github.com/CodexLink/dotfiles-configs-archive/blob/latest/assets/iosevka_config_1.png)](https://typeof.net/Iosevka/)
[![Iosevka Configuration #2-1](https://github.com/CodexLink/dotfiles-configs-archive/blob/latest/assets/iosevka_config_2_1.png)](https://typeof.net/Iosevka/)
[![Iosevka Configuration #2-2](https://github.com/CodexLink/dotfiles-configs-archive/blob/latest/assets/iosevka_config_2_2.png)](https://typeof.net/Iosevka/)
[![Iosevka Configuration #3](https://github.com/CodexLink/dotfiles-configs-archive/blob/latest/assets/iosevka_config_3.png)](https://typeof.net/Iosevka/)

[See build configuration for more information](https://github.com/CodexLink/dotfiles-configs-archive/blob/latest/font-recipe/private-build-plans.toml)

### How to Build

- You need to have a copy of the Iosevka repository, learn how to clone and install pre-requisites from [here](https://github.com/be5invis/Iosevka/blob/main/doc/custom-build.md).

- After that, copy my font-recipe file (_private-build-plans.toml_) and replace it from the existing `private-build-plans.toml` of the Iosevka repository.

- Once done, issue the following command (_with the location of your prompt set to the main directory of the Iosevka repository_): `npm run build -- ttf::iosevka-codex-link`

  > This will create `ttf` and `ttf-unhinted` from the `dist` folder, found in the Iosevka repository.

**Once done, you are ready to patch the font.**

### Patching with Nerd Font

- You need [Docker](https://www.docker.com/), [fontforge](https://fontforge.org/en-US/), [Nerd Font's](https://github.com/ryanoasis/nerd-fonts) [FontPatcher (_from latest upstream_)](https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FontPatcher.zip), and [python](https://www.python.org/) to patch the font.

- Once you setup everything, issue the following command: `docker run --rm -v <Root directory>\Iosevka\dist\iosevka-codex-link\ttf:/in -v <Root directory>\Iosevka\dist\patched:/out nerdfonts/patcher --also-windows --careful --complete --mono`

> Modify the `<Root directory` before issueing the command.

Please check the [font patcher's option](https://github.com/ryanoasis/nerd-fonts#examples) if you wish to go more than what is provided.

After patching, install and you are good to go!

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
