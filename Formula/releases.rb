class Releases < Formula
  desc "Changelog indexer and registry for AI agents and developers"
  homepage "https://releases.sh"
  version "0.34.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/buildinternet/releases-cli/releases/download/v#{version}/releases-darwin-arm64.gz"
      sha256 "e53f555126a428879fb90bd6f3df7c30c1ec4f86d3d687baa3edf1dd8559c2d6"
    else
      url "https://github.com/buildinternet/releases-cli/releases/download/v#{version}/releases-darwin-x64.gz"
      sha256 "7a1b04f37d7342612707ccaf373e47d6416ea08a2eb6fd9593781177c24c4094"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/buildinternet/releases-cli/releases/download/v#{version}/releases-linux-arm64.gz"
      sha256 "5836704539474b25ab0cdd6304c0261edeae8a5549da2ae6d8c8eb0b0dde1954"
    else
      url "https://github.com/buildinternet/releases-cli/releases/download/v#{version}/releases-linux-x64.gz"
      sha256 "4f370c6a8a5e2c86a135b8ed4b42b593e0bdc17a355db8ec5895d0dbeb91a9c1"
    end
  end

  def install
    # Single-binary .gz decompresses to a platform-suffixed filename
    # (e.g. releases-darwin-arm64). Rename to "releases" on install.
    binary = Dir["releases-*"].find { |f| File.file?(f) }
    bin.install binary => "releases"
  end

  test do
    assert_match "releases", shell_output("#{bin}/releases --version")
  end
end
