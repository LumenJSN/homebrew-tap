# Homebrew tap for Aris

```sh
brew tap lumenjsn/tap
brew trust lumenjsn/tap     # Homebrew asks you to trust a third-party tap once
brew install --cask aris
```

[Aris](https://github.com/LumenJSN/Aris) is an agent for everything on your desktop that lives in the MacBook notch.
The cask installs the release DMG from GitHub and clears the download quarantine flag (Aris is ad-hoc signed and not
notarized). Update with `brew upgrade --cask aris`.
