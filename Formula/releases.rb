class Releases < Formula
  desc "Changelog and release-notes registry for developers and AI agents"
  homepage "https://releases.sh"
  version "0.81.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/buildinternet/releases-cli/releases/download/v#{version}/releases-darwin-arm64.gz"
      sha256 "58eda99f495563b37cd1403435feade0230720a2ee7a8f2922aad4d2c23c8a28"
    else
      url "https://github.com/buildinternet/releases-cli/releases/download/v#{version}/releases-darwin-x64.gz"
      sha256 "e9b0d3b2ddb8f33428b5abbf006e49f30b32a2dfa06ead0f854118063c90aac3"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/buildinternet/releases-cli/releases/download/v#{version}/releases-linux-arm64.gz"
      sha256 "8c0fd1cb0e94f8b1b7005ef77f68b7a1617b404e2772ca309b88afb432fe22fd"
    else
      url "https://github.com/buildinternet/releases-cli/releases/download/v#{version}/releases-linux-x64.gz"
      sha256 "0dd9b3eabcb2ee19cc6448ccd76add67a34cb9360ab7a50a86f9d858bb81400e"
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
