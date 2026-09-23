# Homebrew formula. The release workflow rewrites VERSION and the sha256 values
# and pushes this file to the tap repo (github.com/A12N4V/homebrew-tap).
#   brew install A12N4V/tap/kula
class Kula < Formula
  desc "Git, with a map: local-first git client with a knowledge-graph view"
  homepage "https://github.com/A12N4V/kula"
  version "0.1.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/A12N4V/kula/releases/download/v#{version}/kula-aarch64-apple-darwin.tar.gz"
      sha256 "29044414eb2c88ecfbf8eee7089e90a02fdf3f122da5381ba7047c22e2d51f09"
    end
    on_intel do
      url "https://github.com/A12N4V/kula/releases/download/v#{version}/kula-x86_64-apple-darwin.tar.gz"
      sha256 "f4d03e93f2ca2caca487f2b0a0f945b452df84f2a5d86cf79176db131f9602b5"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/A12N4V/kula/releases/download/v#{version}/kula-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "d0a1faf6cbe2cf7e052d702f27a3b50529324ae761433b618bf3bd1de052b8bb"
    end
    on_intel do
      url "https://github.com/A12N4V/kula/releases/download/v#{version}/kula-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "d3bc4bfb75bfe373e527f7c3aeccba446c2cd51e4b5341fa932a924909a7841b"
    end
  end

  depends_on "git"

  def install
    bin.install "kula"
  end

  test do
    system "git", "init", "-q", testpath/"r"
    (testpath/"r/a.py").write "def hello():\n    return world()\n\ndef world():\n    return 1\n"
    system bin/"kula", "-C", testpath/"r", "index"
    assert_match "world", shell_output("#{bin}/kula -C #{testpath}/r query world")
  end
end
