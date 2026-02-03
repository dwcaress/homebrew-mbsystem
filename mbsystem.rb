class Mbsystem < Formula
  desc "MB-System seafloor mapping data processing software"
  homepage "https://www.mbari.org/technology/mb-system/"
  url "https://github.com/dwcaress/MB-System/archive/refs/tags/5.8.3beta12.tar.gz"
  sha256 "9c5dc18384eeaab084a81df3a4ffc4218fd2ff4630fb09985afcd92451a2a267"
  license "GPL-3.0-or-later"
  head "https://github.com/dwcaress/MB-System.git", branch: "master"

  depends_on "cmake" => :build
  depends_on "pkg-config" => :build

  depends_on "fftw"
  depends_on "gdal"
  depends_on "netcdf"
  depends_on "gmt"
  depends_on "libx11"
  depends_on "libxt"
  depends_on "openmotif"
  depends_on "mesa"
  depends_on "mesa-glu"
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

      # Enable Qt/VTK tools
      # args << "-DbuildQt=ON"

      # Configure Qt6 paths
      # args << "-DQt6_DIR=#{Formula["qt@6"].opt_lib}/cmake/Qt6"

      # Configure VTK paths
      # args << "-DVTK_DIR=#{Formula["vtk"].opt_lib}/cmake/vtk"

      # Enable VTK modules with Qt GUI support
      # args << "-DVTK_QT_VERSION=6"
      # args << "-DVTK_GROUP_ENABLE_Qt=YES"
      # args << "-DVTK_MODULE_ENABLE_VTK_GUISupportQt=YES"
      # args << "-DVTK_MODULE_ENABLE_VTK_ViewsQt=YES"
      # args << "-DVTK_MODULE_ENABLE_VTK_GUISupportQtQuick=YES"

      system "cmake", "..", *args, *std_cmake_args
      system "make"
      system "make", "install"
    end
  end

  def caveats
    <<~EOS
      The MB-System graphical tools (MBedit, MBnavedit, MBvelocitytool, MBgrdviz,
      MBeditviz) require X11, which must have been installed via XQuartz.

      To use the GMT modules included in MB-System (mbswath, mbcontour, mbgrdtiff)
      one must set the location of the MB-System library including those modules 
      in a gmt.conf file in each user's home directory. Execute:
        pushd ~ ; gmt set GMT_CUSTOM_LIBS "/opt/homebrew/lib/mbsystem.dylib" ; popd
      
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
