# Zebrafish

[![MIT License](https://img.shields.io/badge/license-MIT-007EC7.svg?style=flat-square)](/LICENSE)

<a title="Azul [Copyrighted free use], via Wikimedia Commons"
   href="https://commons.wikimedia.org/wiki/File:Zebrafisch.jpg"
   align="right">
<img align="right"
     width="250"
     alt="Zebrafish"
     src="https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/Zebrafisch.jpg/512px-Zebrafisch.jpg">
</a>

> A small, fast, single Zsh include file for an awesome Zsh base config.

<br>
<br>

## Details

Frameworks like [Oh-My-Zsh][omz] and [Prezto][prezto] are great if you want
everything-and-the-kitchen-sink, but you pay a performance and complexity penalty for
using big Zsh frameworks.

You also could build your own Zsh config from scratch, but that can be a lot of work and
often requires you to pull together functionality already baked into the Zsh frameworks
you leave behind.

Zebrafish is simpler. Similar to [Grml's .zshrc][grml-zshrc], Zebrafish givesy you a
full featured Zsh config, but encompassed in one simple to use and understand include.

Feel free to use it as-is and build off it, or fork it and make it your own.

## Usage

In your .zshrc, simply source Zebrafish

```zsh
ZEBRAFISH_HOME="${ZDOTDIR:-$HOME/.config/zsh}/plugins/zebrafish"
[[ -d $ZEBRAFISH_HOME ]] || git clone --depth 1 https://github.com/zshzoo/zebrafish $ZEBRAFISH_HOME
source $ZEBRAFISH_HOME/zebrafish.zsh
```

[grml-zshrc]: https://github.com/grml/grml-etc-core/blob/master/etc/zsh/zshrc
[omz]: https://github.com/ohmyzsh/ohmyzsh
[prezto]: https://github.com/sorin-ionescu/prezto
