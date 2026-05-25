class Releases < Formula
  desc "Changelog and release-notes registry for developers and AI agents"
  homepage "https://releases.sh"
  version "0.47.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/buildinternet/releases-cli/releases/download/v#{version}/releases-darwin-arm64.gz"
      sha256 "1beac60b167b542a293784e25afef2c6177406512b788ff999fb0e728bd2adb7"
    else
      url "https://github.com/buildinternet/releases-cli/releases/download/v#{version}/releases-darwin-x64.gz"
      sha256 "0b5efa05b61ce85b06b11b7d542e23c74ac628da7f7b07103219f635db20fe59"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/buildinternet/releases-cli/releases/download/v#{version}/releases-linux-arm64.gz"
      sha256 "9b01ddfd13dd5291b2d6d8cc990382b4a1e02497b30e08b41a7b5c5442b5ac81"
    else
      url "https://github.com/buildinternet/releases-cli/releases/download/v#{version}/releases-linux-x64.gz"
      sha256 "a03e89a466f90b898a23be0f4a1ec15f81b0702f5ae7c669b8794f4dc0a50938"
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
