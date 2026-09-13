# darllowin_overlay

Personal Gentoo overlay.

## Packages

| Package | Description |
|---------|-------------|
| `media-gfx/lightningview` | Lightning-fast cross-platform image viewer and video player |
| `app-portage/overlay-manager` | TUI overlay manager for Gentoo Linux |
| `media-sound/cassette` | GTK4/Adwaita application that allows you to use Yandex Music service |

## Setup

```sh
eselect repository add darllowin_overlay git https://github.com/Darllowin/darllowin-overlay.git
emaint sync -r darllowin_overlay
```
