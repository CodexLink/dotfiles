# dotfiles-configs-archive

Just a collection of configurations varying from package managers, prompt, IDE and much more.

## Notice

**It's under construction. I'm aware some of my keys are exposed, will replace them later on.**

> I'm having hard time doing simple task with `nvim` but I'm up for the challenge.
> Meanwhile, I'm configuring some things.

## Prompt Demo

—

## CLI Demo

—

### CLI Utility Demo

—

## NVIM Demo

—

## Font

Iosevka + Pragmata Pro Variant (SS08) with Complete Icon Set from [Nerd Fonts](https://github.com/ryanoasis/nerd-fonts).
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

## Credits

—
