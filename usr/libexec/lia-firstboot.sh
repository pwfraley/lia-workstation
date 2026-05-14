#!/bin/bash
set -euo pipefail

# Flathub-Remote systemweit hinzufügen, falls noch nicht vorhanden
flatpak remote-add --if-not-exists --system flathub \
    https://dl.flathub.org/repo/flathub.flatpakrepo

# Flatpaks systemweit installieren
flatpak install -y --system flathub \
    com.github.tchx84.Flatseal \
    com.mattjakeman.ExtensionManager \
    io.github.kolunmi.Bazaar \
    io.github.linx_systems.ClamUI \
    org.gnome.Evolution \
    org.gnome.World.Secrets \
    org.libreoffice.LibreOffice \
    org.onlyoffice.desktopeditors \
    org.gnome.Evolution \
    io.github.seadve.Kooha \
    com.obsproject.Studio \
    com.obsproject.Studio.Plugin.GStreamerVaapi \
    com.obsproject.Studio.Plugin.Gstreamer \
    io.github.alainm23.planify \
    org.gnome.World.Iotas \
    io.github.swordpuffin.rewaita \


# Markierung setzen, damit der Dienst beim nächsten Boot nicht erneut läuft
touch /var/lib/lia-firstboot.done
