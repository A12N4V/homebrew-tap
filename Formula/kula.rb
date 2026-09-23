# Homebrew formula. The release workflow rewrites VERSION and the sha256 values
# and pushes this file to the tap repo (github.com/A12N4V/homebrew-tap).
#   brew install A12N4V/tap/kula
class Kula < Formula
  desc "Git, with a map: local-first git client with a knowledge-graph view"
  homepage "https://github.com/A12N4V/kula"
  version "0.1.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/A12N4V/kula/releases/download/v#{version}/kula-aarch64-apple-darwin.tar.gz"
      sha256 "9fe55a94b910c01091c8557cf9be2ff5e43876ba70059b155ad0148b19c5c312"
    end
    on_intel do
      url "https://github.com/A12N4V/kula/releases/download/v#{version}/kula-x86_64-apple-darwin.tar.gz"
      sha256 "012bfc81c07857c9c9e9cf7e3f623d099add9110e3b9c8ce6ee5458409b07ed7"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/A12N4V/kula/releases/download/v#{version}/kula-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "ad108940b1928d7a2bb83739bb0cda0aa61a97404fd76b56a1e19a78e5153ca1"
    end
    on_intel do
      url "https://github.com/A12N4V/kula/releases/download/v#{version}/kula-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "2a96833fa566da2fe5c487c307815328778042fdaa02c2f99ffd1b64c2e56b08"
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
