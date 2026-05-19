class Releases < Formula
  desc "Changelog indexer and registry for AI agents and developers"
  homepage "https://releases.sh"
  version "0.38.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/buildinternet/releases-cli/releases/download/v#{version}/releases-darwin-arm64.gz"
      sha256 "689c1977f9726064ec501c955c052f866844a73052b34c37aca2ce34487ddbd1"
    else
      url "https://github.com/buildinternet/releases-cli/releases/download/v#{version}/releases-darwin-x64.gz"
      sha256 "2e5d50a3b6026e58fc81101ea3e0d9f7b97b145ff01803115a7a74cad0de07a8"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/buildinternet/releases-cli/releases/download/v#{version}/releases-linux-arm64.gz"
      sha256 "8088425808c76adcb98701c51cc00e269402f54674fa3b2044ba680bf987310d"
    else
      url "https://github.com/buildinternet/releases-cli/releases/download/v#{version}/releases-linux-x64.gz"
      sha256 "db4c95736560186eae3bea6965d47c5f2aa929e27a8d89656093e0960e5f3c7d"
    end
  end

  def install
    # Single-binary .gz decompresses to a platform-suffixed filename
    # (e.g. releases-darwin-arm64). Rename to "releases" on install.
    binary = Dir["releases-*"].find { |f| File.file?(f) }
    bin.install binary => "releases"

    generate_completions_from_executable(bin/"releases", "completion", shells: [:bash, :zsh, :fish])
  end

  test do
    assert_match "releases", shell_output("#{bin}/releases --version")
    assert_match "complete -F _releases releases", shell_output("#{bin}/releases completion bash")
  end
end
