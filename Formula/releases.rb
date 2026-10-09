class Releases < Formula
  desc "Changelog and release-notes registry for developers and AI agents"
  homepage "https://releases.sh"
  version "0.83.3"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/buildinternet/releases/releases/download/v#{version}/releases-darwin-arm64.gz"
      sha256 "fb692a13c9c50b96847b2af0dd9771af827d60585d20c503de46fb016b3ce0cb"
    else
      url "https://github.com/buildinternet/releases/releases/download/v#{version}/releases-darwin-x64.gz"
      sha256 "1d3ce683bcf7561fdb033e8f81daa3133604881348195dae11b21c06ea00dce7"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/buildinternet/releases/releases/download/v#{version}/releases-linux-arm64.gz"
      sha256 "a4b8a3ddc62c7c9b29ce60378444dbd67c41fcab3a1e8085cdff83818195d31b"
    else
      url "https://github.com/buildinternet/releases/releases/download/v#{version}/releases-linux-x64.gz"
      sha256 "8dd5743a47a19ef284e641265b815c484f29c501fff5f22ca8f7f2a694ce7fb3"
    end
  end

  def install
    # Single-binary .gz decompresses to a platform-suffixed filename
    # (e.g. releases-darwin-arm64). Rename to "releases" on install.
    binary = Dir["releases-*"].find { |f| File.file?(f) }
    chmod 0755, binary
    bin.install binary => "releases"

    generate_completions_from_executable(bin/"releases", "completion", shells: [:bash, :zsh, :fish])
  end

  test do
    assert_match "releases", shell_output("#{bin}/releases --version")
    assert_match "complete -F _releases releases", shell_output("#{bin}/releases completion bash")
  end
end
