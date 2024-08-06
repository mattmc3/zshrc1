# .zshrc1

[![MIT License](https://img.shields.io/badge/license-MIT-007EC7.svg)](/LICENSE)
![version](https://img.shields.io/badge/version-v2.0.0-orange)

> A powerful starter .zshrc

## Description

`.zshrc1` is designed to be a portable, lightweight, ultra-fast, Zsh configuration in a single file. Equally useful on your desktop machine or on a remote server, zshrc1 enables much of the useful functionality already built into Zsh without the need for frameworks. And, it's ridiculously fast!

`.zshrc1`'s goal of giving you a great starter DIY Zsh experience in a single file stands in contrast to other full Zsh Frameworks like [Oh-My-Zsh][ohmyzsh] and [Prezto][prezto]. Those frameworks are nice if you want everything-and-the-kitchen-sink, but you pay a performance and complexity penalty for using these frameworks.

Many prefer to build their own Zsh config from scratch, but that can be a lot of work and often requires you to pull together functionality already baked into the Zsh frameworks you leave behind.

`.zshrc1` is simpler. Similar to [Grml's .zshrc][grml-zshrc], `.zshrc1` gives you everything you need for a full-featured Zsh config, but contained in one simple to grok Zsh include that will grow with you as you use Zsh. It is heavily inspired by the [Fish shell][fish].

Feel free to use it as-is, build off it, or fork it and make it entirely your own.

## Features

- Use a Fish-like `conf.d` directory in `$ZDOTDIR` to load your config files
- Use a Fish-like `functions` directory in `$ZDOTDIR` for your custom Zsh functions
- Use a Fish-like `completions` directory in `$ZDOTDIR` for your custom Zsh completions
- Set common Zsh environment variables
- Enable better Zsh options than the defaults
- Set better Zsh history options and variables
- Colorize output of commands like `ls`, `grep`, and `man`
- Enable built-in Zsh utilities like help, paste magic, and quote magic
- Configure Zsh built-in completion system
- Use built-in Zsh prompt system

## Installation

Clone `.zshrc1` and source it from your `.zshrc`:

```zsh
git clone https://github.com/mattmc3/zshrc1 ${ZDOTDIR:-~}/.zshrc1
```

Or download a single `.zshrc1` file and make it your own.

```zsh
curl -fsSL https://raw.githubusercontent.com/mattmc3/zshrc1/main/.zshrc1 -o ${ZDOTDIR:-~}/.zshrc1
```

Next, source .zshrc1 in your `.zshrc`:

```zsh
# .zshrc
source ${ZDOTDIR:-~}/.zshrc1
```

[fish]: https://fishshell.com
[ohmyzsh]: https://github.com/ohmyzsh/ohmyzsh
[prezto]: https://github.com/sorin-ionescu/prezto
[grml-zshrc]: https://github.com/grml/grml-etc-core/blob/master/etc/zsh/zshrc
