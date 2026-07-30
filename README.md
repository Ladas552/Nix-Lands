![nix](https://socialify.git.ci/Ladas552/Nix-Lands/image?font=Rokkitt&language=1&logo=https%3A%2F%2Fraw.githubusercontent.com%2FNixOS%2Fnixos-artwork%2Frefs%2Fheads%2Fmaster%2Flogo%2Fnix-snowflake-rainbow.svg&name=1&owner=1&pattern=Transparent&stargazers=1&theme=Dark)

# What is this?
This is my multi host, modular Nix config. It declares configs for different programs using Nix language, such as:
- [Noctalia shell](https://github.com/noctalia-dev/noctalia-shell) - desktop components with generous customizability
- [Niri](https://github.com/YaLTeR/niri) - Scrollable Tilling Wayland Compositor via Community [Niri-nix](https://codeberg.org/BANanaD3V/niri-nix) module
- Firefox and Thunderbird wrapped with [adifox](https://github.com/NotAShelf/adifox) that uses a truly lazy loaded Nix module system - [adios](https://github.com/adisbladis/adios)
- Excellent [Hjem](https://github.com/feel-co/hjem) linker with set of modules of [Hjem-rum](https://github.com/snugnug/hjem-rum)

I also declare configuration as packages/wrappers that you can try with `nix run
github:Ladas552/Nix-Lands#app`, replace `app` with:

- [nvf](https://github.com/NotAShelf/nvf) - Nix declared Neovim (current daily driver)
- all the other wrappers/scripts/packages in [pkgs directory](./pkgs/default.nix)

# Overview of things to note

## Hosts

- 2 NixOS hosts with Nvidia and Intel, and AMD APU on laptops. Both on ZFS and NixPort is using [Impermanence](https://github.com/nix-community/impermanence)
- [NixOS-WSL](https://github.com/nix-community/NixOS-WSL) for Windows partition
- NixIso for my portable NixOS image
- NixWool is my Hetzner cloud that runs [Tangled.sh](https://tangled.org/) knot

## Modular
My config modules are imported automatically, but only merges if the host variant is matching to the host I am building. This is accomplished by [nosh](https://codeberg.org/poacher/nosh), a simple lib to make modular configs without `mkIf` option hell. I [forked it](https://tangled.org/ladas552.me/nosh) to better suit my use case.

Depending on a host, I pass `meta` special arg that carry specific to this host information

## Docs
I write comments on things, that might explain certain ways of doing things, or leave not working options in comments for people to find. This is to not look up one thing twice, and just look at the nix file itself.

Also, I have [Norg document](./nix.norg), containing notes and TODO for the config

I also write some [blog posts about Nix](https://nix.ladas552.me/), feel free to check it out

## Nvfetcher

I also have inputs in `./_sources/`, they are generated with `nvfetcher` after editing the `./nvfetcher.toml` file. Instead of `nix flake update`, I update them with `nix run nixpkgs#nvfetcher`.

To use them, use inputs from it:

```nix
sources = pkgs.callPackage "${self}/_sources/generated.nix" { };
```

Then with `sources.<input-name>.src` you can skip manual fetching for neovim plugins for example.

Also nvfetcher can be used to fetch nixos modules. Even if I don't do this currently

[Check out a blog post about it](https://nix.ladas552.me/posts/Nvfetcher/)

## tack
Instead of using flake.nix to fetch files, I use [tack](https://github.com/manic-systems/tack). Basically makes flake inputs lazy without breaking flake interface.

## Screenshot if you care
![desktop](https://blog.ladas552.me/assets/desktop/desktop.png)

## Name

Yes, it is a [JoJo's reference](https://github.com/user-attachments/assets/7c467d52-a430-4bb3-9493-a5ffa0d69dd4)
## Mirrors
Code is hosted in two repositories for your and my convenience:
- Main Tangled: https://tangled.org/ladas552.me/Nix-Lands
- Read-only GitHub: https://github.com/Ladas552/Nix-Lands
- My older archived config: https://github.com/Ladas552/Flake-Ocean
- My even older archived config: https://github.com/Ladas552/Nix-Is-Unbreakable

# Credits
I take a lot of things from the internet and different configs too. So I credit people in comments to snippets that I stole.

If you want to check every person that I stole things from, go to my [List of configs](https://github.com/stars/Ladas552/lists/nix-flakes)

Also for that [one guy](https://codeberg.org/Dich0tomy/snowstorm) who switched to codeberg

Also, thanks to everyone in Nix community for being so awesome, wouldn't be there without ya
