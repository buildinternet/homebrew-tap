class Releases < Formula
  desc "Changelog and release-notes registry for developers and AI agents"
  homepage "https://releases.sh"
  version "0.57.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/buildinternet/releases-cli/releases/download/v#{version}/releases-darwin-arm64.gz"
      sha256 "96d4d45d23ac88cc0367d03836ffc83cb036aa831dc5c883c30b87a1dbcb1c42"
    else
      url "https://github.com/buildinternet/releases-cli/releases/download/v#{version}/releases-darwin-x64.gz"
      sha256 "f4efd3ae6861c650ba878db6714cb247f3429a1ceaedc9d7498eabdb51f0d8f2"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/buildinternet/releases-cli/releases/download/v#{version}/releases-linux-arm64.gz"
      sha256 "6555e1e92207d16834e03fb8ca9561636c52bb077ef7a3d21cf3d7d9c813c21c"
    else
      url "https://github.com/buildinternet/releases-cli/releases/download/v#{version}/releases-linux-x64.gz"
      sha256 "554bee675201c33610a907135866d0d9d73d9e77f5295d4344b37226437c65b9"
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
