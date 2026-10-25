# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

LIA-Workstation is a custom Linux distribution based on **Fedora Silverblue** (ostree-based, immutable desktop), currently built for Fedora 44 (stable) and 45 (testing). The project produces three container image editions, each layering on top of the previous:

1. **Base** (`Containerfile.base`) — built from `quay.io/fedora/fedora-silverblue:${FEDORA_VERSION}`; installs common tools (zsh, neovim, kitty, chromium, distrobox, netbird, stow, nextcloud-client, nerd-fonts, MS Core Fonts, Tela-circle icons)
2. **Office** (`Containerfile.office`) — inherits from the published base image; adds LibreOffice suite + google-inter-fonts
3. **Developer** (`Containerfile.developer`) — inherits from the published base image; currently identical to Office (needs dev tooling added)

The published base image registry is `ghcr.io/pwfraley/lia-workstation`.

## Fedora Versions & Tags

- All Containerfiles take `ARG FEDORA_VERSION` (default `44`); Office/Developer inherit `ghcr.io/pwfraley/lia-workstation:${FEDORA_VERSION}`.
- The CI matrix in `.github/workflows/build-images.yml` builds every listed version on `main`. Each image is pushed as `:<version>` (e.g. `:44`) plus a moving channel tag `:stable` or `:testing`.
- Testing builds use `continue-on-error`, so they never block stable updates. Do not use a separate maintenance branch: scheduled workflows only run on the default branch.
- Version-specific differences go into `if [ "$FEDORA_VERSION" -ge 45 ]` guards (re-declare `ARG FEDORA_VERSION` after `FROM` to use it in `RUN`).

## Build Commands

Build a specific edition locally with podman:

```sh
# Base image
podman build -f Containerfile.base -t lia-workstation:44 .
podman build -f Containerfile.base --build-arg FEDORA_VERSION=45 -t lia-workstation:45 .

# Office edition (requires the published base image to be accessible)
podman build -f Containerfile.office --build-arg FEDORA_VERSION=44 -t lia-office-workstation:44 .

# Developer edition
podman build -f Containerfile.developer --build-arg FEDORA_VERSION=44 -t lia-developer-workstation:44 .
```

There are no lint or test commands — this is a pure container image project. CI builds and pushes images via GitHub Actions.

## Key Architecture Notes

- **Layer discipline matters**: Each `RUN` layer in a Containerfile adds image size. Combine related installs and always pair `dnf5 install` with `&& dnf5 clean all` in the same `RUN` step. Downloaded artifacts (fonts, cloned repos) must be removed in the same layer they are created.
- **`rpm-ostree cleanup -a`** is run at the end of each Containerfile to keep the ostree boot state consistent — keep this as the final step.
- **`systemctl enable` calls** inside the base image configure services that activate on first boot of the installed system (e.g., `netbird`, `rpm-ostreed-automatic.timer`).
- The Developer edition currently duplicates the Office edition's package list — it needs to be differentiated with actual development packages.
- Comments and documentation in this repo are in **German**.
