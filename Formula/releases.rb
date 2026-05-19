class Releases < Formula
  desc "Changelog indexer and registry for AI agents and developers"
  homepage "https://releases.sh"
  version "0.39.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/buildinternet/releases-cli/releases/download/v#{version}/releases-darwin-arm64.gz"
      sha256 "ce416c74a83fcd84c2862bc2964f7309f23809d2dce644b049b0eba2055dc9e2"
    else
      url "https://github.com/buildinternet/releases-cli/releases/download/v#{version}/releases-darwin-x64.gz"
      sha256 "49d52e97e496e499967fdb7dd5f7ad36237f13cc2cdb2dcfad982050d7c4e611"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/buildinternet/releases-cli/releases/download/v#{version}/releases-linux-arm64.gz"
      sha256 "07b0544d3b8312b8133e10424601a5dfc64ea6efe3f7d9bdb2707a87993ff901"
    else
      url "https://github.com/buildinternet/releases-cli/releases/download/v#{version}/releases-linux-x64.gz"
      sha256 "e9e20c369dd781e223f5be8495e8a2d88c7393ea6c0278daf4ec311b407cfb5d"
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
