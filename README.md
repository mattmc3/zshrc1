# Zebrafish

[![MIT License](https://img.shields.io/badge/license-MIT-007EC7.svg)](/LICENSE)
![version](https://img.shields.io/badge/version-v0.6.3-orange)

<a title="Azul [Copyrighted free use], via Wikimedia Commons"
   href="https://commons.wikimedia.org/wiki/File:Zebrafisch.jpg"
   align="right">
<img align="right"
     width="250"
     alt="Zebrafish"
     src="https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/Zebrafisch.jpg/512px-Zebrafisch.jpg">
</a>

> A lightweight, full-featured, blazing-fast Zsh micro-framework. :zebra: :fish:

<br>
<br>

## TLDR;

Download Zebrafish and source it from your `.zshrc`:

```zsh
curl -fsSL https://git.io/zsh-zebrafish -o ${ZDOTDIR:-~}/.zebrafish.zsh
echo 'source ${ZDOTDIR:-~}/.zebrafish.zsh' >> ${ZDOTDIR:-~}/.zshrc
```

## Details

Zebrafish is what you might call a _micro-framework_ for Zsh. It's designed to be a
portable, lightweight, ultra-fast, full-featured Zsh configuration in a single file.
Equally useful on your desktop machine or on a remote server, Zebrafish brings many of
the goodies [found in other shells][fish] to your Zsh configuration. And, it's
ridiculously fast!

Zebrafish's goal is to give you a great DIY Zsh experience from a single file. Other
full Zsh Frameworks like [Oh-My-Zsh][ohmyzsh] and [Prezto][prezto] are nice if
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
| help                | Enable the Zsh built-in help                                               |
| colorized-man-pages | Add a splash of color to your man pages                                    |
| zfunctions          | Use a `functions` directory in `$ZDOTDIR` for your custom Zsh functions    |
| zshrcd              | Use a `zshrc.d` directory in `$ZDOTDIR` to load config files               |
| zcompletions        | Use a `completions` directory in `$ZDOTDIR` to add your custom completions |
| plugins             | Include popular plugins from [zsh-users]                                   |
| prompt              | Use the amazing [starship] prompt                                          |
| compinit            | Initialize completions                                                     |

## Plugins

Zebrafish includes a few essential plugins:
- [zsh-defer](https://github.com/romkatv/zsh-defer)
- [autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
- [history-substring-search](https://github.com/zsh-users/zsh-history-substring-search)
- [syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)

## Installation

### Install as a single file

Grab the Zebrafish file via `curl`, and source it from your `.zshrc`:

```zsh
curl -fsSL https://git.io/zsh-zebrafish -o ${ZDOTDIR:-~}/.zebrafish.zsh
echo 'source ${ZDOTDIR:-~}/.zebrafish.zsh' >> ${ZDOTDIR:-~}/.zshrc
```

### Install from the git repository

Grab the Zebrafish file via `curl`, and source it from your `.zshrc`:

```zsh
git clone https://github.com/mattmc3/zebrafish ${ZDOTDIR:-~/.config/zsh}/plugins/zebrafish
echo 'source ${ZDOTDIR:-~/.config/zsh}/plugins/zebrafish/zebrafish.zsh' >> ${ZDOTDIR:-~}/.zshrc
```

### Install with a Zsh plugin manager

To install using a Zsh plugin manager, add the following to your .zshrc

- [pz]: `pz source mattmc3/zebrafish`
- [zcomet]: `zcomet load mattmc3/zebrafish`
- [zgenom]: `zgenom load mattmc3/zebrafish`
- [znap]: `znap source mattmc3/zebrafish`

Note that when using a plugin manager, you may prefer to turn off Zebrafish's built-in
plugin management with `zstyle ':zebrafish:disable' features plugins`.

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

### Adding plugins

Zebrafish gives you a small set of essential plugins, but you will likely want to add
your own. That's no problem! Zebrafish gives you total control of the plugin list.
Just set this `zstyle` before sourcing Zebrafish.

**Note** - you'll want to include the [zsh-defer] before any plugins you want to load
faster. If you have a plugin you don't want to defer, list it before [zsh-defer].

```zsh
# Make a list of the github plugins you want
myplugins=(
  # include zsh-defer before any plugins you want load faster
  romkatv/zsh-defer
  # keep these standard Zebrafish plugins
  zsh-users/zsh-autosuggestions
  zsh-users/zsh-history-substring-search
  # add new favorites to my plugin list
  zsh-users/zsh-completions
  zshzoo/copier
  peterhurford/up.zsh
  rupa/z
  # plugins from other git providers
  https://gitlab.com/code-stats/code-stats-zsh
  # always load this one last
  zdharma-continuum/fast-syntax-highlighting
)

# assign that list to the appropriate zstyle
zstyle ':zebrafish:external' plugins $myplugins
```

### Use a different plugin manager

Zebrafish gives you simplified, and highly performant plugin management, but if you
want to use something else, simply disable the 'plugins' feature.

```zsh
# disable the plugin feature
# (you can add other features to this list too)
disable_features=(plugins)
zstyle ':zebrafish:disable' features $disable_features
```

### Use on a server

Zebrafish is great for use on a server since it's just a single .zsh file. But, in a
server environment, you might not want Zebrafish to try to go out to the internet
and grab plugins or the [Starship][starship] prompt. You can easily run Zebrafish in an
isolated environment by disabling these features:

```zsh
# disable any features that grab stuff from the web
# because you might not want that on a server
zstyle ':zebrafish:disable' features \
  prompt \
  plugins
```

### Customizing your prompt

Zebrafish uses the Starship][starship] prompt. The Starship configuration file is
specified in the `$STARSHIP_CONFIG` variable, which defaults to
`~/.config/starship/zebrafish.toml`.

You can point `$STARSHIP_CONFIG` to another file, or you can modify the `zebrafish.toml`
file yourself. Configuration instructions for Starship [can be found here](https://starship.rs/config/).

### Using a different prompt

If you prefer to use a prompt other than [Starship][starship], you can disable the
Zebrafish prompt, and include your preferred prompt in the plugins list.

```zsh
# disable the Zebrafish prompt
zstyle ':zebrafish:disable' features prompt

# Example using the romkatv/powerlevel10k prompt plugin
# another popular prompt plugin is sindresorhus/pure
plugins=(
  romkatv/powerlevel10k
  romkatv/zsh-defer
  zsh-users/zsh-autosuggestions
  zsh-users/zsh-history-substring-search
  zsh-users/zsh-syntax-highlighting
)
zstyle ':zebrafish:external' plugins $plugins
```

## Performance

Zebrafish is blazing fast. In my tests it was 3 times faster than [prezto] and
nearly 5 times faster to load than [ohmyzsh].

Zebrafish achieves much of its performance by being smaller and simpler than the big
frameworks. It also leverages the [zsh-defer] plugin to get you to a prompt faster. When
loading plugins, everything loaded after zsh-defer will use it to source your plugin.

You can test the speed of your Zsh config for yourself by running the following command:

```zsh
for i in $(seq 1 10); do
  /usr/bin/time zsh -i -c exit
done
```

![zebrafish](https://raw.githubusercontent.com/mattmc3/zebrafish/resources/img/benchmark.png)


[fish]: https://fishshell.com
[grml-zshrc]: https://github.com/grml/grml-etc-core/blob/master/etc/zsh/zshrc
[ohmyzsh]: https://github.com/ohmyzsh/ohmyzsh
[prezto]: https://github.com/sorin-ionescu/prezto
[pz]: https://github.com/mattmc3/pz
[starship]: https://starship.rs
[zcomet]: https://github.com/agkozak/zcomet
[zgenom]: https://github.com/jandamm/zgenom
[znap]: https://github.com/marlonrichert/zsh-snap
[zsh-defer]: https://github.com/romkatv/zsh-defer
[zsh-users]: https://github.com/zsh-users/
