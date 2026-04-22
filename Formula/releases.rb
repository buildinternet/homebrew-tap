class Releases < Formula
  desc "Changelog indexer and registry for AI agents and developers"
  homepage "https://releases.sh"
  version "0.19.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/buildinternet/releases-cli/releases/download/v#{version}/releases-darwin-arm64.gz"
      sha256 "4e41ce4668f20d2919bbe5e5f3ff8b3834536c42e7c20fdf412fe8c8780f5f24"
    else
      url "https://github.com/buildinternet/releases-cli/releases/download/v#{version}/releases-darwin-x64.gz"
      sha256 "4a7db592e1aa50caef7c273e0f82c188b746414aa0a70c225d4d46751f9d74ff"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/buildinternet/releases-cli/releases/download/v#{version}/releases-linux-arm64.gz"
      sha256 "3ec7e8b1478c1ed9d1389c758b8d0160e418db9bc0a4d8ab8e78f56b60cc58a3"
    else
      url "https://github.com/buildinternet/releases-cli/releases/download/v#{version}/releases-linux-x64.gz"
      sha256 "74c9a21c4007777c1fefd63d87a0a25ccc119eb701a3c84551aa150b6441d10a"
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
