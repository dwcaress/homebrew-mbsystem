class MbsystemM1trial < Formula
  desc "MB-System seafloor mapping software (Homebrew formula for test distributions)"
  homepage "http://www.mbari.org/products/research-software/mb-system/"
  url "https://github.com/dwcaress/MB-System/archive/5.7.9beta11.tar.gz"
  sha256 "14f6cec26c45b68c6ad3d2ad67ce5a83741d677be678c26c41176f29aa284623"
  license "GPL3"
  
  depends_on "gmt"
  depends_on "proj"
  depends_on "gdal"
  depends_on "fftw"
  depends_on "ghostscript"
  depends_on "ffmpeg"
  depends_on "graphicsmagick"
  depends_on "openmotif"
  depends_on "opencv"
  depends_on "dwcaress/mbsystem/otps"
  conflicts_with 'dwcaress/mbsystem/mbsystem', :because => 'mbsystem and mbsystem-betamax-m1 share the same commands'
  conflicts_with 'dwcaress/mbsystem/mbsystem-beta', :because => 'mbsystem-beta and mbsystem-betamax-m1 share the same commands'
  conflicts_with 'dwcaress/mbsystem/mbsystem-betamax', :because => 'mbsystem-beta and mbsystem-betamax-m1 share the same commands'
  
  env :std

  def install
    args = [
      "--prefix=#{prefix}",
      "--disable-static",
      "--enable-shared",
      "--with-x11-lib=/opt/X11/lib",
      "--with-x11-include=/opt/X11/include",
      "--with-motif-lib=#{Formula["mbopenmotif"].opt_lib}",
      "--with-motif-include=#{Formula["mbopenmotif"].opt_include}",
      "--with-opengl-include=/opt/X11/include",
      "--with-opengl-lib=/opt/X11/lib",
      "--with-opencv-include=#{Formula["opencv"].opt_include}/opencv4",
      "--with-opencv-lib=#{Formula["opencv"].opt_lib}",
      "--with-otps-dir=#{Formula["dwcaress/mbsystem/otps"].prefix}",
      "--enable-hardening",
      "--enable-mbtrn",
      "--enable-mbtnav",
      "--enable-opencv"
    ]

    system "./configure", *args
    system "make", "check"
    system "make", "install"
  end

  def caveats
    <<~EOS
      The GMT_CUSTOM_LIBS needs to be set for all users
      on this computer that want to use mbsystem. Run the
      following command within the home directory:
          gmt gmtset GMT_CUSTOM_LIBS #{HOMEBREW_PREFIX}/lib/mbsystem.so
      Additionally, if not already done within the gmt
      installation, the directories for DCW and GSHHG (borders,
      coast lines, rivers, etc.) need to be set:
          gmt gmtset DIR_DCW #{HOMEBREW_PREFIX}/share/gmt/dcw
          gmt gmtset DIR_GSHHG #{HOMEBREW_PREFIX}/share/gmt/coast
    EOS
  end
end
