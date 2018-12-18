class MbsystemBeta < Formula
  desc "MB-System seafloor mapping software (Homebrew formula for test distributions)"
  homepage "http://www.mbari.org/products/research-software/mb-system/"
  url ""
  sha256 "54d060631498e213e95c7040faa5051854cfb4d2bda2ed9e008d26e1bc56f494"

  depends_on :x11
  depends_on "gmt"
  depends_on "gdal"ftp://mbsystemftp@ftp.mbari.org/mbsystem-5.6.20181217.tar.gz
  depends_on "netcdf"
  depends_on "proj"
  depends_on "fftw"
  depends_on "gv"
  depends_on "openmotif"
  depends_on "dwcaress/mbsystem/otps"
  option "without-check", "Disable build time checks (not recommended)"
  conflicts_with 'dwcaress/mbsystem/mbsystem', :because => 'mbsystem and mbsystem-beta share the same commands'

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
          gmtset GMT_CUSTOM_LIBS #{HOMEBREW_PREFIX}/lib/mbsystem.so
      Additionally, if not already done within the gmt
      installation, the directories for DCW and GSHHG (borders,
      coast lines, rivers, etc.) need to be set:
          gmtset DIR_DCW #{HOMEBREW_PREFIX}/share/gmt/dcw
          gmtset DIR_GSHHG #{HOMEBREW_PREFIX}/share/gmt/coast
    EOS
  end
end
