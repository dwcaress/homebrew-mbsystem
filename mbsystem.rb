class Mbsystem < Formula
  desc "MB-System seafloor mapping data processing software"
  homepage "https://www.mbari.org/technology/mb-system/"
  url "https://github.com/dwcaress/MB-System/archive/refs/tags/MB-System-5.8.3beta12.tar.gz"
  sha256 "aa3f7c7f79a933d22ff7410284c3c7de9ba9416c14f271bec231b2307101abad"

  sha256 "da102e4ffe0b4eb535717171c3ca315295c5dd03ec584b06aa2fd748fada22a8"
  license "GPL-3.0-or-later"
  head "https://github.com/dwcaress/MB-System.git", branch: "master"

  depends_on "cmake" => :build
  depends_on "pkg-config" => :build

  depends_on "fftw"
  depends_on "gdal"
  depends_on "gmt"
  depends_on "libx11"
  depends_on "libxt"
  depends_on "netcdf"
  depends_on "openmotif"
  depends_on "proj"
  depends_on "qt@6"
  depends_on "vtk"

  def install
    # Set up build directory
    mkdir "build" do
      args = %W[
        -DCMAKE_INSTALL_PREFIX=#{prefix}
        -DCMAKE_BUILD_TYPE=Release
      ]

      # Configure Qt6 paths
      args << "-DQt6_DIR=#{Formula["qt@6"].opt_lib}/cmake/Qt6"

      # Configure VTK paths
      args << "-DVTK_DIR=#{Formula["vtk"].opt_lib}/cmake/vtk"

      # Enable VTK modules with Qt GUI support
      args << "-DVTK_QT_VERSION=6"
      args << "-DVTK_GROUP_ENABLE_Qt=YES"
      args << "-DVTK_MODULE_ENABLE_VTK_GUISupportQt=YES"
      args << "-DVTK_MODULE_ENABLE_VTK_ViewsQt=YES"
      args << "-DVTK_MODULE_ENABLE_VTK_GUISupportQtQuick=YES"

      # Configure GMT paths
      args << "-DGMT_DIR=#{Formula["gmt"].opt_prefix}"

      # Configure PROJ paths
      args << "-DPROJ_DIR=#{Formula["proj"].opt_prefix}"

      # Configure GDAL paths
      args << "-DGDAL_DIR=#{Formula["gdal"].opt_prefix}"

      # Configure NetCDF paths
      args << "-DNETCDF_DIR=#{Formula["netcdf"].opt_prefix}"

      # Configure FFTW paths
      args << "-DFFTW_DIR=#{Formula["fftw"].opt_prefix}"

      # Configure Motif paths
      args << "-DMOTIF_DIR=#{Formula["openmotif"].opt_prefix}"

      # Configure X11 paths
      args << "-DX11_INCLUDE_DIR=#{Formula["libx11"].opt_include}"
      args << "-DX11_LIBRARIES=#{Formula["libx11"].opt_lib}/libX11.dylib"
      args << "-DXt_INCLUDE_DIR=#{Formula["libxt"].opt_include}"
      args << "-DXt_LIBRARIES=#{Formula["libxt"].opt_lib}/libXt.dylib"

      system "gmt" "gmtset GMT_CUSTOM_LIBS #{HOMEBREW_PREFIX}/lib/mbsystem.so"
      system "gmt" "gmtset DIR_DCW #{HOMEBREW_PREFIX}/share/gmt/dcw"
      system "gmt" "gmtset DIR_GSHHG #{HOMEBREW_PREFIX}/share/gmt/coast"


      system "cmake", "..", *args, *std_cmake_args
      system "make"
      system "make", "install"
      system "make", "test"
    end
  end

  def caveats
    <<~EOS
      MB-System has been installed with XQuartz for X11 support.

      The graphical tools (MBedit, MBnavedit, MBvelocitytool, MBgrdviz,
      MBeditviz) require X11, which has been installed via XQuartz.

      You may need to log out and back in for XQuartz to be fully configured.

      For more information and documentation, visit:
        https://www.mbari.org/technology/mb-system/

      To get help or report issues, use the MB-System discussion lists:
        http://listserver.mbari.org/sympa/info/mbsystem
    EOS
  end

  test do
    # Test that the main utilities are installed and can display version info
    system "#{bin}/mbformat", "-V"
    system "#{bin}/mbinfo", "--version"
    system "#{bin}/mbsystem", "-V"
  end
end




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
