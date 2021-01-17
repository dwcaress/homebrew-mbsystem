class MbsystemBetamax < Formula
  desc "MB-System seafloor mapping software (Homebrew formula for test distributions)"
  homepage "http://www.mbari.org/products/research-software/mb-system/"
  url "https://github.com/dwcaress/MB-System/archive/5.7.7beta09.tar.gz"
  sha256 "93dfbd33c43f2e711f0502d7a9c87d57014925fd1587157df4b16b7aa55325bc"
  license "GPL3"

  env :std
  
  depends_on "gmt"
  depends_on "proj"
  depends_on "fftw"
  depends_on "mbopenmotif"
  depends_on "opencv"
  depends_on "dwcaress/mbsystem/otps"
  conflicts_with 'dwcaress/mbsystem/mbsystem', :because => 'mbsystem and mbsystem-betamax share the same commands'
  conflicts_with 'dwcaress/mbsystem/mbsystem-beta', :because => 'mbsystem-beta and mbsystem-betamax share the same commands'

  def install
    args = [
      "--prefix=#{prefix}",
      "--disable-static",
      "--enable-shared",
      "--with-motif-lib=#{Formula["openmotif"].opt_lib}",
      "--with-motif-include=#{Formula["openmotif"].opt_include}",
      "--with-opengl-include=/opt/X11/include",
      "--with-opengl-lib=/opt/X11/lib",
      "--with-opencv-include=#{Formula["opencv"].opt_include}/opencv4",
      "--with-opencv-lib=#{Formula["opencv"].opt_lib}",
      "--with-otps-dir=#{Formula["dwcaress/mbsystem/otps"].prefix}",
      "--with-otps-dir=/usr/local/opt/otps",
      "--enable-hardening",
      "--enable-mbtrn",
      "--enable-mbtnav",
      "--enable-opencv"
    ]

    ENV['CFLAGS']="-I/opt/X11/include -L/opt/X11/lib"

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
