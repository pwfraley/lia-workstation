# LIA-Workstation

Eine Linux Distribution für alle die nichts mit Computern am Hut haben. Einfach installieren und loslegen.

## Basis

Als Basis für die LIA-Workstation dient Fedora Silverblue.

## Kanäle (Tags)

Jede Edition wird in mehreren Tags veröffentlicht:

| Tag | Bedeutung |
|---|---|
| `:stable` | Empfohlen. Zeigt immer auf die aktuell stabile Fedora-Version (zur Zeit 44). Ein Wechsel auf eine neue Fedora-Version passiert automatisch mit einem normalen Update. |
| `:testing` | Die nächste Fedora-Version im Test (zur Zeit 45). Nur für Testrechner. |
| `:44`, `:45`, … | Feste Fedora-Version. Bleibt bis zum Ende der Fedora-Unterstützung bei dieser Version. |

Umstellen eines bestehenden Systems (z. B. von `:44` auf `:stable`):

```bash
rpm-ostree rebase ostree-unverified-registry:ghcr.io/pwfraley/lia-workstation:stable
```

## Editionen

### LIA-Workstation

Die LIA-Workstation ist ein Basis System für generelle Computer nutzung. Es enthält alles was man für die täglichen Aufgaben am Computer braucht.

#### Installation

```bash
rpm-ostree rebase ostree-unverified-registry:ghcr.io/pwfraley/lia-workstation:stable
```

### LIA-Office-Workstation

Die LIA-Office-Workstation ist optimiert für die Nutzung als einfacher Bürorechner. Zusätzlich zu der in LIA-Workstation installierten Software sind hier noch Anwendungen dabei die Sie im Büroalltag benötigen.

#### Installation

```bash
rpm-ostree rebase ostree-unverified-registry:ghcr.io/pwfraley/lia-office-workstation:stable
```

### LIA-Developer-Workstation

Die LIA-Developer-Workstation richtet sich an Software-Developer. Sie enthält die wichtigsten Tools um Software mit Linux zu entwickeln, egal ob Desktop- oder Webanwendungen. Alles was man zur Softwareentwicklung braucht ist mit an Board.

#### Installation

```bash
rpm-ostree rebase ostree-unverified-registry:ghcr.io/pwfraley/lia-developer-workstation:stable
```
