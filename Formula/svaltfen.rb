class Svaltfen < Formula
  desc "Retro RPG game"
  homepage "https://github.com/uzudil/svaltfen"
  url "https://github.com/uzudil/svaltfen/archive/v1.0.1.tar.gz"
  sha256 "c68f80c10ad782960215b274d4af80861a27d5beb37297bf9e5e5cea435ae58e"
  license "MIT"

  depends_on "go" => :build

  def install
    # path to internal scripts
    inreplace "svaltfen.go", 'core.Run("bscript",', %Q{core.Run("#{libexec}/bscript",}

    system "go", "build"

    bin.install "svaltfen"
    libexec.install "bscript"
  end

  test do
    require "open3"
    _, stderr = Open3.capture3(bin/"svaltfen", "-help")
    assert_match /Usage of /, stderr
  end
end
