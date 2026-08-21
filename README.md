![GitHub Downloads (all assets, all releases)](https://img.shields.io/github/downloads/dariogriffo/lowfi-debian/total)
![GitHub Downloads (all assets, latest release)](https://img.shields.io/github/downloads/dariogriffo/lowfi-debian/latest/total)
![GitHub Release](https://img.shields.io/github/v/release/dariogriffo/lowfi-debian)
![GitHub Release Date](https://img.shields.io/github/release-date/dariogriffo/lowfi-debian)

<h1>
   <p align="center">
     <a href="https://lowfi.org/"><img src="https://github.com/dariogriffo/lowfi-debian/blob/main/lowfi-logo.png" alt="lowfi Logo" width="128" style="margin-right: 20px"></a>
     <a href="https://www.debian.org/"><img src="https://github.com/dariogriffo/lowfi-debian/blob/main/debian-logo.png" alt="Debian Logo" width="104" style="margin-left: 20px"></a>
     <br>lowfi for Debian
   </p>
</h1>
<p align="center">
 lowfi is a tiny rust app that serves a single purpose: play lofi. It'll do this as simply as it can: no albums, no ads, just lofi..
</p>

# lowfi for Debian

This repository contains build scripts to produce the _unofficial_ Debian packages
(.deb) for [lowfi](https://github.com/talwat/lowfi/) hosted at [deb.griffo.io](https://deb.griffo.io)

Currently supported Debian distros are:
- Bookworm (v12)
- Trixie (v13)
- Forky (v14)
- Sid (testing)

Currently supported Ubuntu distros are:
- Jammy (22.04)
- Noble (24.04)
- Questing (25.10)
- Resolute (26.04)

Supported architectures:
- amd64 (x86_64)

Upstream publishes a Linux binary for x86_64 only, so no other architecture
is available.

> ⚠️ The current upstream binary is built against glibc 2.38, which is newer
> than the glibc in Bookworm (2.36) and Jammy (2.35). The package declares
> that requirement, so apt on those two releases reports it as not
> installable rather than installing something that cannot start. It works on
> Trixie, Forky, Sid, Noble, Questing and Resolute.

This is an unofficial community project to provide a package that's easy to
install on Debian. If you're looking for the lowfi source code, see
[lowfi](https://github.com/talwat/lowfi/).

## Install/Update

📖 **Step-by-step install guide:** [Debian](https://deb.griffo.io/install-latest-lowfi-in-debian.html) · [Ubuntu](https://deb.griffo.io/install-latest-lowfi-in-ubuntu.html)

### The Debian way

> ⚠️ **From 1 October 2026, apt access requires a yearly subscription**
> ([deb.griffo.io](https://deb.griffo.io)). To use this tool for free, download
> the .deb from the [Releases](https://github.com/dariogriffo/lowfi-debian/releases) page
> and install it manually (see below).

```sh
sudo install -d -m 0755 /etc/apt/keyrings
curl -fsSL https://deb.griffo.io/EA0F721D231FDD3A0A17B9AC7808B4DD62C41256.asc | sudo gpg --dearmor --yes -o /etc/apt/keyrings/deb.griffo.io.gpg
echo "deb [signed-by=/etc/apt/keyrings/deb.griffo.io.gpg] https://deb.griffo.io/apt $(lsb_release -sc 2>/dev/null) main" | sudo tee /etc/apt/sources.list.d/deb.griffo.io.list
sudo apt update 
sudo apt install -y lowfi
```

### Manual Installation

1. Download the .deb package for your Debian version available on
   the [Releases](https://github.com/dariogriffo/lowfi-debian/releases) page.
2. Install the downloaded .deb package.

```sh
sudo dpkg -i <filename>.deb
```
## Updating

To update to a new version, just follow any of the installation methods above. There's no need to uninstall the old version; it will be updated correctly.

## Roadmap

- [x] Produce a .deb package on GitHub Releases
- [x] Set up a debian mirror for easier updates

## Disclaimer

- This repo is not open for issues related to lowfi. This repo is only for _unofficial_ Debian packaging.
