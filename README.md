# Zebrafish

[![MIT License](https://img.shields.io/badge/license-MIT-007EC7.svg)](/LICENSE)
![version](https://img.shields.io/badge/version-v2.0.0-orange)

> A powerful starter .zshrc

## TLDR;

Download Zebrafish and source it from your `.zshrc`:

```zsh
curl -fsSL https://raw.githubusercontent.com/mattmc3/zebrafish/main/zebrafish.zsh -o ${ZDOTDIR:-~}/zebrafish.zsh
echo 'source ${ZDOTDIR:-~}/zebrafish.zsh' >> ${ZDOTDIR:-~}/.zshrc
```

## Details

Zebrafish is designed to be a portable, lightweight, ultra-fast, Zsh configuration in a
single file. Equally useful on your desktop machine or on a remote server, Zebrafish
enables much of the useful functionality already built into Zsh without the need for
plugins. And, it's ridiculously fast!

Zebrafish's goal is to give you a great starter DIY Zsh experience from a single file.
Other full Zsh Frameworks like [Oh-My-Zsh][ohmyzsh] and [Prezto][prezto] are nice if
you want everything-and-the-kitchen-sink, but you pay a performance and complexity
penalty for using these frameworks.

Many prefer to build their own Zsh config from scratch, but that can be a lot of work
and often requires you to pull together functionality already baked into the Zsh
frameworks you leave behind.

Zebrafish is simpler. Similar to [Grml's .zshrc][grml-zshrc], Zebrafish gives you
everything you need for a full-featured Zsh config, but contained in one simple to
grok Zsh include that will grow with you as you use Zsh.

Feel free to use it as-is, build off it, or fork it and make it entirely your own.

## Features

- Use a `conf.d` directory in `$ZDOTDIR` to load runcom config files
- Use a `functions` directory in `$ZDOTDIR` for your custom Zsh functions
- Use a `plugins` directory in `$ZDOTDIR` for your custom Zsh plugins

| plugins             | description                                        |
| ------------------- | -------------------------------------------------- |
| environment         | Set common environment variables                   |
| history             | Better Zsh history settings than the defaults      |
| directory           | Set directory options and define directory aliases |
| editor              | Zsh keybindings and ZLE config                     |
| color               | Add a splash of color to your shell                |
| utility             | Add Zsh utilities                                  |
| completion          | Initialize completions                             |
| compstyle           | Add zstyle completion styles                       |
| prompt              | Initialize Zsh prompt                              |

## Installation

### Install as a single file

Grab the Zebrafish file via `curl`, and source it from your `.zshrc`:

```zsh
curl -fsSL https://raw.githubusercontent.com/mattmc3/zebrafish/main/zebrafish.zsh -o ${ZDOTDIR:-~}/zebrafish.zsh
echo 'source ${ZDOTDIR:-~}/zebrafish.zsh' >> ${ZDOTDIR:-~}/.zshrc
```

### Install from the git repository

Grab the Zebrafish repo via `git`, and source it from your `.zshrc`:

```zsh
git clone https://github.com/mattmc3/zebrafish ${ZDOTDIR:-~/.config/zsh}/plugins/zebrafish
echo 'source ${ZDOTDIR:-~/.config/zsh}/plugins/zebrafish/zebrafish.plugin.zsh' >> ${ZDOTDIR:-~}/.zshrc
```

### Install with a Zsh plugin manager

To install using a Zsh plugin manager, add the following to your `.zshrc`

- [antidote]: `antidote install mattmc3/zebrafish`
- [zcomet]: `zcomet load mattmc3/zebrafish`
- [zgenom]: `zgenom load mattmc3/zebrafish`
- [znap]: `znap source mattmc3/zebrafish`


[grml-zshrc]: https://github.com/grml/grml-etc-core/blob/master/etc/zsh/zshrc
[ohmyzsh]: https://github.com/ohmyzsh/ohmyzsh
[prezto]: https://github.com/sorin-ionescu/prezto
[zsh-utils]: https://github.com/belak/zsh-utils
[antidote]: https://github.com/mattmc3/antidote
[zcomet]: https://github.com/agkozak/zcomet
[zgenom]: https://github.com/jandamm/zgenom
[znap]: https://github.com/marlonrichert/zsh-snap
