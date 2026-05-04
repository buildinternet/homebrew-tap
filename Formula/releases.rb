class Releases < Formula
  desc "Changelog indexer and registry for AI agents and developers"
  homepage "https://releases.sh"
  version "0.27.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/buildinternet/releases-cli/releases/download/v#{version}/releases-darwin-arm64.gz"
      sha256 "b9e503c1759d3672b1d2127120130741208fbd4234612bdd301b2f0c02823888"
    else
      url "https://github.com/buildinternet/releases-cli/releases/download/v#{version}/releases-darwin-x64.gz"
      sha256 "9d0c7cd8a77b691ebe5225e33e5d7173331c8b13bc3858a3555ac4757fbd6a41"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/buildinternet/releases-cli/releases/download/v#{version}/releases-linux-arm64.gz"
      sha256 "9769293bb3c699b628d0ad5a7ec1afb73306135b44c60984cc2e8c8079dc43db"
    else
      url "https://github.com/buildinternet/releases-cli/releases/download/v#{version}/releases-linux-x64.gz"
      sha256 "294849ecc9dcacb04855461361f63e06b11f8c44f5f55947395f62d83689acf6"
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
