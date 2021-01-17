class MbsystemBetamax < Formula
  desc "MB-System seafloor mapping software (Homebrew formula for test distributions)"
  homepage "http://www.mbari.org/products/research-software/mb-system/"
  url "https://github.com/dwcaress/MB-System/archive/5.7.7.tar.gz"
  sha256 "171cb30ef525f463787e66036106399bb4d1873b5dd1267f18111bc804a02e08"
  license "GPL3"
  
  depends_on "gmt"
  depends_on "proj"
  depends_on "fftw"
  depends_on "mbopenmotif"
  depends_on "opencv"
  depends_on "dwcaress/mbsystem/otps"
  conflicts_with 'dwcaress/mbsystem/mbsystem', :because => 'mbsystem and mbsystem-betamax share the same commands'
  conflicts_with 'dwcaress/mbsystem/mbsystem-beta', :because => 'mbsystem-beta and mbsystem-betamax share the same commands'
  
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
