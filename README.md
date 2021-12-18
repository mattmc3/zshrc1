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

> :zebra: :fish: A small, fast, single Zsh include file for an awesome Zsh base config.

<br>
<br>

## Details

Zebrafish's goal is simply to bring you a featureful, fast, and modern Zsh shell
experience via a single include file you source from your .zshrc. You can use it on your
desktop, or on a remote server with ease.

Frameworks like [Oh-My-Zsh][ohmyzsh] and [Prezto][prezto] are great if you want
everything-and-the-kitchen-sink, but you pay a performance and complexity penalty for
using these frameworks.

Many prefer to build their own Zsh config from scratch, but that can be a lot of work
and often requires you to pull together functionality already baked into the Zsh
frameworks you leave behind.

Zebrafish is simpler. Similar to [Grml's .zshrc][grml-zshrc], Zebrafish gives you a
full-featured Zsh config, but encompassed in one simple to use and understand include.

Feel free to use it as-is and build off it, or fork it and make it your own.

## Installation

### Install with a Zsh plugin manager

To install using a Zsh plugin manager, add the following to your .zshrc

- [pz]: `pz source mattmc3/zebrafish`
- [zcomet]: `zcomet load mattmc3/zebrafish`
- [zgenom]: `zgenom load mattmc3/zebrafish`
- [znap]: `znap source mattmc3/zebrafish`

### Install manually

Grab the Zebrafish file via `curl`, and source it from your `.zshrc`:

```zsh
curl -fsSL https://raw.githubusercontent.com/mattmc3/zebrafish/main/zebrafish.zsh -o ${ZDOTDIR:-$HOME/.config/zsh}/zebrafish.zsh
echo 'source ${ZDOTDIR:-$HOME/.config/zsh}/zebrafish.zsh' >> ${ZDOTDIR:-~}/.zshrc
```

### Customization

You can chose to only enable certain features by setting the following `zstyle`:

```zsh
# set this zstyle in your .zshrc and remove the features you don't want
zstyle ':zebrafish:enable' features \
    environment \
    zshopts \
    history \
    completion-styles \
    keybindings \
    termtitle \
    help \
    colorized-man-pages \
    zfunctions \
    zshrcd \
    completions \
    compinit
```

[grml-zshrc]: https://github.com/grml/grml-etc-core/blob/master/etc/zsh/zshrc
[ohmyzsh]: https://github.com/ohmyzsh/ohmyzsh
[prezto]: https://github.com/sorin-ionescu/prezto
[zshzoo]: https://github.com/zshzoo/zshzoo
[pz]: https://github.com/mattmc3/pz
[zcomet]: https://github.com/agkozak/zcomet
[zgenom]: https://github.com/jandamm/zgenom
[znap]: https://github.com/marlonrichert/zsh-snap
