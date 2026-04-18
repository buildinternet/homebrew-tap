class Releases < Formula
  desc "Changelog indexer and registry for AI agents and developers"
  homepage "https://releases.sh"
  version "0.15.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/buildinternet/releases-cli/releases/download/v#{version}/releases-darwin-arm64.gz"
      sha256 "14e3c475e1c49e2fefc3be043a02c93d2db06e5f4e977f81e12d58715b2f5b95"
    else
      url "https://github.com/buildinternet/releases-cli/releases/download/v#{version}/releases-darwin-x64.gz"
      sha256 "25e34ebff600053ae2ea21ab347ec5b63ed410a48d2479f91d38097ba5024061"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/buildinternet/releases-cli/releases/download/v#{version}/releases-linux-arm64.gz"
      sha256 "31c4bcf2ed22d75daaae42af78fc8fbc8427db9acef08d2b4fdf91142c75152f"
    else
      url "https://github.com/buildinternet/releases-cli/releases/download/v#{version}/releases-linux-x64.gz"
      sha256 "c5e145a0ce2776284e02078f425f524e14ae66d9b1b51fedcc863eb692be23e4"
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
