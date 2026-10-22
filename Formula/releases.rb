class Releases < Formula
  desc "Changelog and release-notes registry for developers and AI agents"
  homepage "https://releases.sh"
  version "0.83.4"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/buildinternet/releases/releases/download/v#{version}/releases-darwin-arm64.gz"
      sha256 "30599e01cfddf8d815fbcc3aca95a8b99e2c2d005888ed5f3d2c51e0907e1d89"
    else
      url "https://github.com/buildinternet/releases/releases/download/v#{version}/releases-darwin-x64.gz"
      sha256 "4c14f4e6341a7a3abbcfb937ed3a53e45b894495d6b3d724a2f9ff760df03540"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/buildinternet/releases/releases/download/v#{version}/releases-linux-arm64.gz"
      sha256 "1def76da269f1df4f26452f1ad20d7cf94bf345054b023cd591c70f727d0f2b2"
    else
      url "https://github.com/buildinternet/releases/releases/download/v#{version}/releases-linux-x64.gz"
      sha256 "966fd2b464500304ada8bd4c755cae3a7af7b2dc71213a27607c152b833880b3"
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
