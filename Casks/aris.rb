cask "aris" do
  version "1.3.1"
  sha256 "01aa8885fdd887b93b8495eecb5962446e5dac3c5b03aa3e76a3191e973e7d7f"

  url "https://github.com/LumenJSN/Aris/releases/download/v#{version}/Aris-#{version}.dmg"
  name "Aris"
  desc "Agent for everything on your desktop, in the MacBook notch"
  homepage "https://arismac.app/"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates true
  depends_on arch: :arm64
  depends_on macos: :sonoma

  app "Aris.app"

  # Aris is signed with its own self-signed certificate and not notarized (the project has no Developer ID), so
  # Gatekeeper would refuse the first launch. Clear the download quarantine flag on the copy this cask installed.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/Aris.app"]
  end

  uninstall quit: "com.lumenjsn.aris"

  zap trash: [
    "~/.config/aris",
    "~/Library/Containers/com.lumenjsn.aris",
    "~/Library/Preferences/com.lumenjsn.aris.plist",
  ]

  caveats <<~EOS
    Aris is not notarized. This cask clears the quarantine flag after installing, so macOS opens it without the
    "Apple could not verify" prompt. Only install Aris from this tap or github.com/LumenJSN/Aris/releases.
    From 1.3 on Aris updates itself (the notice pill under the notch) and keeps its permissions. Coming from
    1.2.x, grant Aris's permissions once more in System Settings if asked.
  EOS
end
