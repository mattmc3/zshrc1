# .zshrc1

[![MIT License](https://img.shields.io/badge/license-MIT-007EC7.svg)](/LICENSE)
![version](https://img.shields.io/badge/version-v1.0.0-orange)

> A powerful starter .zshrc

## TLDR;

Download zshrc1 and source it from your `.zshrc`:

```zsh
curl -fsSL https://raw.githubusercontent.com/mattmc3/zshrc1/main/.zshrc1 -o ${ZDOTDIR:-~}/.zshrc1
echo 'source ${ZDOTDIR:-~}/.zshrc1' >> ${ZDOTDIR:-~}/.zshrc
```

## Details

zshrc1 is designed to be a portable, lightweight, ultra-fast, Zsh configuration in a
single file. Equally useful on your desktop machine or on a remote server, zshrc1
enables much of the useful functionality already built into Zsh without the need for
plugins. And, it's ridiculously fast!

zshrc1's goal is to give you a great starter DIY Zsh experience from a single file.
Other full Zsh Frameworks like [Oh-My-Zsh][ohmyzsh] and [Prezto][prezto] are nice if
you want everything-and-the-kitchen-sink, but you pay a performance and complexity
penalty for using these frameworks.

Many prefer to build their own Zsh config from scratch, but that can be a lot of work
and often requires you to pull together functionality already baked into the Zsh
frameworks you leave behind.

zshrc1 is simpler. Similar to [Grml's .zshrc][grml-zshrc], zshrc1 gives you
everything you need for a full-featured Zsh config, but contained in one simple to
grok Zsh include that will grow with you as you use Zsh.

Feel free to use it as-is, build off it, or fork it and make it entirely your own.

## Features

| feature             | description                                                                |
| ------------------- | -------------------------------------------------------------------------- |
| environment         | Set common environment variables                                           |
| zshopts             | Better Zsh options than the defaults                                       |
| history             | Better Zsh history settings than the defaults                              |
| completion-styles   | Add zstyle completion options                                              |
| keybindings         | Add common key bindings                                                    |
| termtitle           | Set the terminal window title                                              |
| help                | Enable the Zsh built-in help                                               |
| colorized-man-pages | Add a splash of color to your man pages                                    |
| zfunctions          | Use a `functions` directory in `$ZDOTDIR` for your custom Zsh functions    |
| zshrcd              | Use a `conf.d` directory in `$ZDOTDIR` to load config files                |
| compinit            | Initialize completions                                                     |

## Installation

### Install as a single file

Grab the zshrc1 file via `curl`, and source it from your `.zshrc`:

```zsh
curl -fsSL https://raw.githubusercontent.com/mattmc3/zshrc1/main/.zshrc1 -o ${ZDOTDIR:-~}/.zshrc1
echo 'source ${ZDOTDIR:-~}/.zshrc1' >> ${ZDOTDIR:-~}/.zshrc
```

### Install from the git repository

Grab the zshrc1 repo via `git`, and source it from your `.zshrc`:

```zsh
git clone https://github.com/mattmc3/zshrc1 ${ZDOTDIR:-~/.config/zsh}/plugins/zshrc1
echo 'source ${ZDOTDIR:-~/.config/zsh}/plugins/zshrc1/zshrc1.plugin.zsh' >> ${ZDOTDIR:-~}/.zshrc
```

### Install with a Zsh plugin manager

To install using a Zsh plugin manager, add the following to your .zshrc

- [pz]: `pz source mattmc3/zshrc1`
- [zcomet]: `zcomet load mattmc3/zshrc1`
- [zgenom]: `zgenom load mattmc3/zshrc1`
- [znap]: `znap source mattmc3/zshrc1`


[grml-zshrc]: https://github.com/grml/grml-etc-core/blob/master/etc/zsh/zshrc
[ohmyzsh]: https://github.com/ohmyzsh/ohmyzsh
[prezto]: https://github.com/sorin-ionescu/prezto
[pz]: https://github.com/mattmc3/pz
[zcomet]: https://github.com/agkozak/zcomet
[zgenom]: https://github.com/jandamm/zgenom
[znap]: https://github.com/marlonrichert/zsh-snap
