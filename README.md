# Zebrafish

[![MIT License](https://img.shields.io/badge/license-MIT-007EC7.svg)](/LICENSE)
![version](https://img.shields.io/badge/version-v2.0.0-orange)

> A powerful starter .zshrc

## Description

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

| zsh init functions  | description                                                   |
| ------------------- | ------------------------------------------------------------- |
| zsh_environment     | set common zsh environment variables                          |
| zsh_history         | set zsh history options and variables                         |
| zsh_options         | set common zsh options                                        |
| zsh_color           | setup color for built-in utilities                            |
| zsh_utility         | setup zsh built-in utilities                                  |
| zsh_completion      | set zsh built-in completion system                            |
| zsh_compstyle       | set zstyle completion styles                                  |
| zsh_prompt          | set zsh prompt                                                |
| zsh_plugins         | setup zsh plugins                                             |
| zsh_confd           | use a Fish-like conf.d directory for sourcing configs         |
| zsh_funcdir         | use a Fish-like functions directory for lazy-loaded functions |

## Installation

Clone Zebrafish and source it from your `.zshrc`:

```zsh
git clone https://github.com/mattmc3/zebrafish ${ZDOTDIR:-~}/.zebrafish
```

Or download a single Zebrafish file and make it your own.

```zsh
curl -fsSL https://raw.githubusercontent.com/mattmc3/zebrafish/main/zebrafish.zsh -o ${ZDOTDIR:-~}/.zebrafish.zsh
```

Next, call whatever Zsh init functions you want from Zebrafish in your `.zshrc`:

```zsh
# .zshrc
source ${ZDOTDIR:-~}/.zebrafish.zsh
zsh_environment
zsh_history
zsh_utility
zsh_prompt 'fade'
zsh_completion
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
