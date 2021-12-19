# Zebrafish

[![MIT License](https://img.shields.io/badge/license-MIT-007EC7.svg)](/LICENSE)
![version](https://img.shields.io/badge/version-v0.6.2-orange)

<a title="Azul [Copyrighted free use], via Wikimedia Commons"
   href="https://commons.wikimedia.org/wiki/File:Zebrafisch.jpg"
   align="right">
<img align="right"
     width="250"
     alt="Zebrafish"
     src="https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/Zebrafisch.jpg/512px-Zebrafisch.jpg">
</a>

> A small, fast, single Zsh include file for an awesome Zsh base config. :zebra: :fish:

<br>
<br>

## Details

Zebrafish is what you might call a _micro-framework_ for Zsh. It's designed to be a
portable, lightweight, ultra-fast, full-featured Zsh configuration in a single file.
Equally useful on your desktop or on a remote server, Zebrafish brings many of the
goodies [found in other shells][fish] to your Zsh configuration without all the bloat.

Zebrafish's goal is to give you a great DIY Zsh experience from a single file. Other
full Zsh Frameworks like [Oh-My-Zsh][ohmyzsh] and [Prezto][prezto] are great if
you want everything-and-the-kitchen-sink, but you pay a performance and complexity
penalty for using these frameworks.

Many prefer to build their own Zsh config from scratch, but that can be a lot of work
and often requires you to pull together functionality already baked into the Zsh
frameworks you leave behind.

Zebrafish is simpler. Similar to [Grml's .zshrc][grml-zshrc], Zebrafish gives you
everything you need for a full-featured Zsh config, but encompassed in one simple to
grok Zsh include that will grow with you as you use Zsh.

Feel free to use it as-is, build off it, or fork it and make it entirely your own.

![zebrafish](https://raw.githubusercontent.com/mattmc3/zebrafish/resources/img/zebrafish.png)

## Features

| feature             | description                                                                |
| ------------------- | -------------------------------------------------------------------------- |
| environment         | Set common environment variables                                           |
| zshopts             | Better Zsh options than the defaults                                       |
| history             | Better Zsh history settings than the defaults                              |
| completion-styles   | Add zstyle completion options                                              |
| keybindings         | Add common key bindings                                                    |
| termtitle           | Set the terminal window title                                              |
| help                | Use the Zsh built-in help where appropriate                                |
| colorized-man-pages | Add a splash of color to your man pages                                    |
| zfunctions          | Use a `functions` directory in `$ZDOTDIR` for your custom Zsh functions    |
| zshrcd              | Use a `zshrc.d` directory in `$ZDOTDIR` to load config files               |
| completions         | Use a `completions` directory in `$ZDOTDIR` to add your custom completions |
| plugins             | Include popular plugins from [zsh-users]                                   |
| prompt              | Include the amazing [starship] prompt                                      |
| compinit            | Initialize completions                                                     |

## Plugins

Zebrafish includes a few essential plugins from [zsh-users]:
- [autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
- [history-substring-search](https://github.com/zsh-users/zsh-history-substring-search)
- [syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)

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
zf_url=https://raw.githubusercontent.com/mattmc3/zebrafish/main/zebrafish.zsh
curl -fsSL $zf_url -o ${ZDOTDIR:-$HOME/.config/zsh}/zebrafish.zsh
echo 'source ${ZDOTDIR:-$HOME/.config/zsh}/zebrafish.zsh' >> ${ZDOTDIR:-~}/.zshrc
```

## Customization

### Disable features

You can chose to disable certain features by setting the following `zstyle`. Perhaps
you are already using a plugin manager and don't want Zebrafish to load any plugins.

```zsh
# set this zstyle in your .zshrc before sourcing Zebrafish to disable features
zstyle ':zebrafish:disable' features plugins
```

The `$zf_features` variable contains everything that's currently enabled in Zebrafish
if you want to see the list of what you can disable, or refer to this readme.

### Use on a server

In a server environment, you might not want Zebrafish to try to go out to the internet
and grab plugins or prompts. You can easily run Zebrafish in an isolated environment
with the following config:

```zsh
# disables the features that grab stuff from the web
zstyle ':zebrafish:disable' features \
  prompt \
  plugins
```

### Using a different prompt

If you prefer to use a prompt other than [starship], you can disable the Zebrafish
prompt, and include your preferred prompt in the plugins list.

```zsh
# disable the Zebrafish prompt
zstyle ':zebrafish:disable' features prompt

# add pure prompt, and then all the standard stuff as well
zstyle ':zebrafish:external' plugins \
  sindresorhus/pure
  zsh-users/zsh-autosuggestions \
  zsh-users/zsh-history-substring-search \
  zsh-users/zsh-syntax-highlighting
```


[grml-zshrc]: https://github.com/grml/grml-etc-core/blob/master/etc/zsh/zshrc
[ohmyzsh]: https://github.com/ohmyzsh/ohmyzsh
[prezto]: https://github.com/sorin-ionescu/prezto
[zsh-users]: https://github.com/zsh-users/
[pz]: https://github.com/mattmc3/pz
[zcomet]: https://github.com/agkozak/zcomet
[zgenom]: https://github.com/jandamm/zgenom
[znap]: https://github.com/marlonrichert/zsh-snap
[fish]: https://fishshell.com
[starship]: https://starship.rs
