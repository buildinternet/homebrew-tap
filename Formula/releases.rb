class Releases < Formula
  desc "Changelog and release-notes registry for developers and AI agents"
  homepage "https://releases.sh"
  version "0.84.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/buildinternet/releases/releases/download/v#{version}/releases-darwin-arm64.gz"
      sha256 "5e22be2f71522a007ec1a72c7e9e16b509ca1f9a806d64128e4437d5432c672c"
    else
      url "https://github.com/buildinternet/releases/releases/download/v#{version}/releases-darwin-x64.gz"
      sha256 "900c9aa8d89b7f1beb7c7702a1f8e1328b0877b6f83376e00a61ea20a0153938"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/buildinternet/releases/releases/download/v#{version}/releases-linux-arm64.gz"
      sha256 "20fd11b3db28649fc4c6afc66e05456d24a02bb660a83eee2d9ee26fca0304be"
    else
      url "https://github.com/buildinternet/releases/releases/download/v#{version}/releases-linux-x64.gz"
      sha256 "027c2e613dfe14a15a8435d3b0b233b76c438011636b739ca19710d357d14e39"
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
