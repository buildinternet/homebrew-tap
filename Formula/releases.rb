class Releases < Formula
  desc "Changelog and release-notes registry for developers and AI agents"
  homepage "https://releases.sh"
  version "0.83.5"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/buildinternet/releases/releases/download/v#{version}/releases-darwin-arm64.gz"
      sha256 "8f9a65676ec9bc4fda618bb77c37344e4da88e08d12d41c7cc531752d2dabb38"
    else
      url "https://github.com/buildinternet/releases/releases/download/v#{version}/releases-darwin-x64.gz"
      sha256 "df3fb22c5169aa27672569370ce055d30e966fa43ffd73a5d0c97a6a300d406d"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/buildinternet/releases/releases/download/v#{version}/releases-linux-arm64.gz"
      sha256 "d085fcf3b463d1320d056a09560e24126231c1b46578ab648691da9f9bbeba85"
    else
      url "https://github.com/buildinternet/releases/releases/download/v#{version}/releases-linux-x64.gz"
      sha256 "1f0f9c025e237bec558e32a54b52371bbf55291e274ef0337fdb92639edc14bf"
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
