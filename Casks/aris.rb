cask "aris" do
  version "1.2.0"
  sha256 "f6609b877e117ff8b2a3d0f52773ec02a79e98160882614b8fbec267eae5edee"

  url "https://github.com/LumenJSN/Aris/releases/download/v#{version}/Aris-#{version}.dmg"
  name "Aris"
  desc "Agent for everything on your desktop, in the MacBook notch"
  homepage "https://arismac.app/"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on macos: :sonoma

  app "Aris.app"

  # Aris is ad-hoc signed and not notarized (the project has no Developer ID), so Gatekeeper would refuse the
  # first launch. Clear the download quarantine flag on the copy this cask installed.
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
    After each update macOS sees a new program: grant Aris's permissions again in System Settings if asked.
  EOS
end
