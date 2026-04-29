class Releases < Formula
  desc "Changelog indexer and registry for AI agents and developers"
  homepage "https://releases.sh"
  version "0.20.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/buildinternet/releases-cli/releases/download/v#{version}/releases-darwin-arm64.gz"
      sha256 "d7e97d2567274c3ca2432a0fb3d427cca9591ea2af3c94aa2c118ef324884b95"
    else
      url "https://github.com/buildinternet/releases-cli/releases/download/v#{version}/releases-darwin-x64.gz"
      sha256 "47ad763a22ef0eb0b7ade1b71eea3747b09cdf1ce411b690343e249e63ff50e5"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/buildinternet/releases-cli/releases/download/v#{version}/releases-linux-arm64.gz"
      sha256 "b64f85421a5fab709c2f3101fdff853b78e18054d90c397a6002bb90231d39e9"
    else
      url "https://github.com/buildinternet/releases-cli/releases/download/v#{version}/releases-linux-x64.gz"
      sha256 "6b3bd61d57b044addda847cb42c4d6b15602d2dd4d8d230b0365929f739ec70b"
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
