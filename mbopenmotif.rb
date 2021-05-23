class Mbopenmotif < Formula
  desc "LGPL release of the Motif toolkit"
  homepage "https://motif.ics.com/motif"
  url "https://downloads.sourceforge.net/project/motif/Motif%202.3.8%20Source%20Code/motif-2.3.8.tar.gz"
  sha256 "859b723666eeac7df018209d66045c9853b50b4218cecadb794e2359619ebce7"
  license "LGPL-2.1"
  
  env :std

  livecheck do
    url :stable
  end

  depends_on "pkg-config" => :build
  depends_on "fontconfig"
  depends_on "freetype"
  depends_on "jpeg"
  depends_on "libpng"

  conflicts_with "lesstif",
    because: "both Lesstif and Openmotif are complete replacements for each other"

  conflicts_with "openmotif",
    because: "the openmotif formula in homebrew-core depends on the brew version of X11 (without GLX) rather than XQuartz (with GLX)"

  def install
    system "./configure --prefix=#{prefix}",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--enable-xft",
                          "--enable-jpeg",
                          "--enable-png",
                          "--disable-printing"

    ENV['CFLAGS']="-I/opt/X11/include -L/opt/X11/lib"

    system "make"
    system "make", "install"

    # Avoid conflict with Perl
    mv man3/"Core.3", man3/"openmotif-Core.3"
  end

  test do
    assert_match /no source file specified/, pipe_output("#{bin}/uil 2>&1")
  end
end
