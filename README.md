# darllowin_overlay

Personal Gentoo overlay.

## Packages

| Package | Description |
|---------|-------------|
| `media-gfx/lightningview` | Lightning-fast cross-platform image viewer and video player |

## Setup

### eselect (recommended)

```sh
eselect repository add darllowin_overlay git https://github.com/Darllowin/darllowin-overlay.git
emaint sync -r darllowin_overlay
```

### Manual

```sh
cat > /etc/portage/repos.conf/darllowin_overlay.conf <<EOF
[darllowin_overlay]
location = /var/db/repos/darllowin_overlay
sync-type = git
sync-uri = https://github.com/Darllowin/darllowin-overlay.git
auto-sync = yes
EOF
emaint sync -r darllowin_overlay
```

## Install packages

```sh
emerge --ask media-gfx/lightningview::darllowin_overlay
```
