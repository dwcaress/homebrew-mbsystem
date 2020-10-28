class MbsystemBeta < Formula
  desc "MB-System seafloor mapping software (Homebrew formula for test distributions)"
  homepage "http://www.mbari.org/products/research-software/mb-system/"
  url "https://github.com/dwcaress/MB-System/archive/5.7.7beta03.tar.gz"
  sha256 "dfe674a76e10b42c4d82053b7ee4ce0c36f03374d065ebd4aba98c89e8f1b82b"

  depends_on :x11
  depends_on "gmt"
  depends_on "gdal"
  depends_on "netcdf"
  depends_on "proj"
  depends_on "fftw"
  depends_on "openmotif"
  depends_on "dwcaress/mbsystem/otps"
  option "without-check", "Disable build time checks (not recommended)"
  conflicts_with 'dwcaress/mbsystem/mbsystem', :because => 'mbsystem and mbsystem-beta share the same commands'
  conflicts_with 'dwcaress/mbsystem/mbsystem-betamax', :because => 'mbsystem-betamax and mbsystem-beta share the same commands'

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

    ENV['CFLAGS']="-I/opt/X11/include -L/opt/X11/lib"

    system "./configure", *args
    system "make", "check" if build.with? "check"
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
