class Releases < Formula
  desc "Changelog and release-notes registry for developers and AI agents"
  homepage "https://releases.sh"
  version "0.74.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/buildinternet/releases-cli/releases/download/v#{version}/releases-darwin-arm64.gz"
      sha256 "d203dcf0e3134fd3f9adfa8b558a8c3fba77b0e8926cd40ee8081d6f69cc1d68"
    else
      url "https://github.com/buildinternet/releases-cli/releases/download/v#{version}/releases-darwin-x64.gz"
      sha256 "56b7a5ea8a53ba603a1fca6778de290aa79c2c551a8a063b2509967d004960cb"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/buildinternet/releases-cli/releases/download/v#{version}/releases-linux-arm64.gz"
      sha256 "5db20ddedd9a78f18679f7255b458a458739849fcf0c31dd68a4b73004e65877"
    else
      url "https://github.com/buildinternet/releases-cli/releases/download/v#{version}/releases-linux-x64.gz"
      sha256 "4c1238bf82a08d11ef17d38e649d972cfbc6e5ea7999f45babce2e40fe910227"
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
