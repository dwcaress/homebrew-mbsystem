class Mbsystem < Formula
  desc "MB-System seafloor mapping software"
  homepage "http://www.mbari.org/products/research-software/mb-system/"
  url "https://github.com/dwcaress/MB-System/archive/5.7.7.tar.gz"
  sha256 "472dfa863905e27c0484f49ba90650bd1c743798d001e0a2a275d0d8c05ffab9"

  env :std
  
  depends_on "gmt"
  depends_on "gdal"
  depends_on "netcdf"
  depends_on "proj"
  depends_on "fftw"
  depends_on "ghostscript"
  depends_on "ffmpeg"
  depends_on "graphicsmagick"
  depends_on "mbopenmotif"
  depends_on "dwcaress/mbsystem/otps"
  option "withgvout-check", "Disable build time checks (not recommended)"
  conflicts_with 'dwcaress/mbsystem/mbsystem-beta', :because => 'mbsystem and mbsystem-beta share the same commands'
  conflicts_with 'dwcaress/mbsystem/mbsystem-betamax', :because => 'mbsystem and mbsystem-betamax share the same commands'

  def install
    args = [
      "--prefix=#{prefix}",
      "--disable-static",
      "--enable-shared",
      "--with-proj-lib=#{Formula["proj"].opt_lib}",
      "--with-proj-include=#{Formula["proj"].opt_include}",
      "--with-fftw-lib=#{Formula["fftw"].opt_lib}",
      "--with-fftw-include=#{Formula["fftw"].opt_include}",
      "--with-motif-lib=#{Formula["openmotif"].opt_lib}",
      "--with-motif-include=#{Formula["openmotif"].opt_include}",
      "--with-otps-dir=#{Formula["dwcaress/mbsystem/otps"].prefix}"
    ]

    ENV['CFLAGS']="-I/usr/X11/include -L/usr/X11/lib"

    system "./configure", *args
    system "make", "check" if build.with? "check"
    system "make", "install"
  end

  def caveats
    <<~EOS

      The GMT_CUSTOM_LIBS needs to be set for all users
      on this computer that want to use mbsystem. Run the
      following command within the home directory:
          gmtset GMT_CUSTOM_LIBS #{HOMEBREW_PREFIX}/lib/mbsystem.so

      Additionally, if not already done within the gmt
      installation, the directories for DCW and GSHHG (borders,
      coast lines, rivers, etc.) need to be set:
          gmtset DIR_DCW #{HOMEBREW_PREFIX}/share/gmt/dcw
          gmtset DIR_GSHHG #{HOMEBREW_PREFIX}/share/gmt/coast

    EOS
  end
end
