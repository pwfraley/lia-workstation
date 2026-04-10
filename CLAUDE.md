# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

LIA-Workstation is a custom Linux distribution based on **Fedora Silverblue 44** (ostree-based, immutable desktop). The project produces three container image editions, each layering on top of the previous:

1. **Base** (`Containerfile.base`) — built from `quay.io/fedora/fedora-silverblue:44`; installs common tools (zsh, neovim, kitty, chromium, distrobox, netbird, stow, nextcloud-client, nerd-fonts, MS Core Fonts, Tela-circle icons)
2. **Office** (`Containerfile.office`) — inherits from the published base image; adds LibreOffice suite + google-inter-fonts
3. **Developer** (`Containerfile.developer`) — inherits from the published base image; currently identical to Office (needs dev tooling added)

The published base image registry is `github.com/pwfraley/lia-workstation:44`.

## Build Commands

Build a specific edition locally with podman:

```sh
# Base image
podman build -f Containerfile.base -t lia-workstation:44 .

# Office edition (requires the published base image to be accessible)
podman build -f Containerfile.office -t lia-office-workstation:44 .

# Developer edition
podman build -f Containerfile.developer -t lia-developer-workstation:44 .
```

There are no lint, test, or CI commands — this is a pure container image project.

## Key Architecture Notes

- **Layer discipline matters**: Each `RUN` layer in a Containerfile adds image size. Combine related installs and always pair `dnf5 install` with `&& dnf5 clean all` in the same `RUN` step. Downloaded artifacts (fonts, cloned repos) must be removed in the same layer they are created.
- **`rpm-ostree cleanup -a`** is run at the end of each Containerfile to keep the ostree boot state consistent — keep this as the final step.
- **`systemctl enable` calls** inside the base image configure services that activate on first boot of the installed system (e.g., `netbird`, `rpm-ostreed-automatic.timer`).
- The Developer edition currently duplicates the Office edition's package list — it needs to be differentiated with actual development packages.
- Comments and documentation in this repo are in **German**.
