# Homebrew formula. The release workflow rewrites VERSION and the sha256 values
# and pushes this file to the tap repo (github.com/A12N4V/homebrew-tap).
#   brew install A12N4V/tap/kula
class Kula < Formula
  desc "Git, with a map: local-first git client with a knowledge-graph view"
  homepage "https://github.com/A12N4V/kula"
  version "0.2.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/A12N4V/kula/releases/download/v#{version}/kula-aarch64-apple-darwin.tar.gz"
      sha256 "436b72b638b0ae1dc89e40693fbd34b01479344950ff8f196861e80775127022"
    end
    on_intel do
      url "https://github.com/A12N4V/kula/releases/download/v#{version}/kula-x86_64-apple-darwin.tar.gz"
      sha256 "8395f1b7760ec0db288839c2e95d9a25d055bea5a0fbcc81ba816edf25f00270"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/A12N4V/kula/releases/download/v#{version}/kula-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "f5201c19d270223d1fff718bdf505823e750b1daa49e50200435821c2876af3a"
    end
    on_intel do
      url "https://github.com/A12N4V/kula/releases/download/v#{version}/kula-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "3c912f81321308e9ed60a735fb29d263aa980f5d91c4fbb5ad7f427c94e6a197"
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
