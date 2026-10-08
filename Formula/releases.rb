class Releases < Formula
  desc "Changelog and release-notes registry for developers and AI agents"
  homepage "https://releases.sh"
  version "0.83.2"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/buildinternet/releases/releases/download/v#{version}/releases-darwin-arm64.gz"
      sha256 "9a1ce1bcea8d3d7e218757b74153bd90b368c01559cadb8b7afb002c5c988581"
    else
      url "https://github.com/buildinternet/releases/releases/download/v#{version}/releases-darwin-x64.gz"
      sha256 "bda998a2a0a06106ff047c810055d5c7d44d7dfbeb03f074b4a20f2450cc594f"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/buildinternet/releases/releases/download/v#{version}/releases-linux-arm64.gz"
      sha256 "a75565228af54fe2d4ba3bc89798694d2863cfbcdb3c7ba8a5a670ad760ead42"
    else
      url "https://github.com/buildinternet/releases/releases/download/v#{version}/releases-linux-x64.gz"
      sha256 "b920e8357f1922240426b7b8cb3748671b0e545bad2e483925e09610e7769e7d"
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
