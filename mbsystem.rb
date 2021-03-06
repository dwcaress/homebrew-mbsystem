class Mbsystem < Formula
  desc "MB-System seafloor mapping software"
  homepage "http://www.mbari.org/products/research-software/mb-system/"
  url "https://github.com/dwcaress/MB-System/archive/5.7.8.tar.gz"
  sha256 "aa3f7c7f79a933d22ff7410284c3c7de9ba9416c14f271bec231b2307101abad"

  env :std
  
  depends_on "gmt"
  depends_on "gdal"
  depends_on "netcdf"
  depends_on "proj"
  depends_on "fftw"
  depends_on "ghostscript"
  depends_on "ffmpeg"
  depends_on "graphicsmagick"
  depends_on "openmotif"
  depends_on "dwcaress/mbsystem/otps"
  option "withgvout-check", "Disable build time checks (not recommended)"
  conflicts_with 'dwcaress/mbsystem/mbsystem-beta', :because => 'mbsystem and mbsystem-beta share the same commands'
  conflicts_with 'dwcaress/mbsystem/mbsystem-betamax', :because => 'mbsystem and mbsystem-betamax share the same commands'

  def install
    args = [
      "--prefix=#{prefix}",
      "--disable-static",
      "--enable-shared",
      "--with-x11-lib=/opt/X11/lib",
      "--with-x11-include=/opt/X11/include",
      "--with-motif-lib=#{Formula["openmotif"].opt_lib}",
      "--with-motif-include=#{Formula["openmotif"].opt_include}",
      "--with-opengl-include=/opt/X11/include",
      "--with-opengl-lib=/opt/X11/lib",
      "--with-otps-dir=#{Formula["dwcaress/mbsystem/otps"].prefix}",
      "--enable-hardening",
    ]

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
