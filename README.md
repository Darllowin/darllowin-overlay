# darllowin-overlay

Personal Gentoo overlay.

## Packages

| Package | Description |
|---------|-------------|
| `media-gfx/lightningview` | Lightning-fast cross-platform image viewer and video player |

## Setup

### eselect (recommended)

```sh
eselect repository add darllowin git https://github.com/Darllowin/darllowin-overlay.git
emaint sync -r darllowin
```

### Manual

```sh
cat > /etc/portage/repos.conf/darllowin.conf <<EOF
[darllowin]
location = /var/db/repos/darllowin
sync-type = git
sync-uri = https://github.com/Darllowin/darllowin-overlay.git
auto-sync = yes
EOF
emerge --sync darllowin
```

## Install packages

```sh
emerge --ask media-gfx/lightningview::darllowin
```
