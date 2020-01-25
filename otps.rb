class Otps < Formula
  desc "OTPS: OSU Tidal Prediction Software"
  homepage "https://www.tpxo.net/otps"
  url "ftp://mbsystemftp@ftp.mbari.org/OTPS_2018.tar.gz"
  sha256 "6f4f84306977df72f9d659fcadad37c7bdc92db6e33eeec8614566fa390c8fdf"

  # option "with-tpxo8", "Install TPXO8-atlas-compact tide model"

  depends_on "gcc"

  # resource "tpxo8" do
  #   url "ftp://anonymous:anonymous%40homebrew.com@ftp.oce.orst.edu/dist/tides/TPXO8_compact/tpxo8_atlas_compact_v1.tar.Z"
  #   sha256 "80f0517b2df5ec8b2fbb811f818fd6c2e38c0909313efe1b05a30728dec45491"
  # end

  def install
    system "make", "extract_HC"
    system "make", "predict_tide"
    system "make", "extract_local_model"

    prefix.install Dir["*"]

    # if build.with? "tpxo8"
    #   (prefix/"DATA").install resource("tpxo8")

    #   link = open("#{prefix}/DATA/Model_atlas_v1", "w")
    #   link.write <<~EOS
    #     #{prefix}/DATA/hf.tpxo8_atlas_30_v1
    #     #{prefix}/DATA/uv.tpxo8_atlas_30_v1
    #     #{prefix}/DATA/grid_tpxo8atlas_30_v1
    #   EOS
    #   link.close
    # end
  end

  def caveats
    <<~EOS
      This formula should have built the OTPS2 software in the directory /usr/local/Cellar/otps/2/
      and made a link named /usr/local/opt/otps to this directory. In the past, the TPXO8_atlas_v1
      tidal model was also installed in this location. However, the OSU tide group no longer makes 
      their TPXO tidal models openly available for download. Consequently, this formula now installs 
      the OTPS2 software required for the MB-System program mbotps to work, but not the associated 
      tidal model. 
      Academic users can register and request access to the TPXO8-atlas or TPXO9-atlas models
      used by mbotps at this website:
        https://www.tpxo.net
      If, for instance, you obtain the TPXO8_atlas_v1 model, it will come in the form of three
      files:
        hf.tpxo8_atlas_30_v1
        uv.tpxo8_atlas_30_v1
        grid_tpxo8_atlas_30_v1
      Place those three files into a directory /usr/local/Cellar/otps/2/DATA/ and create in that
      directory a file named Model_atlas_v1 with three lines:
        /usr/local/Cellar/otps/2/DATA/hf.tpxo8_atlas_30_v1
        /usr/local/Cellar/otps/2/DATA/uv.tpxo8_atlas_30_v1
        /usr/local/Cellar/otps/2/DATA/grid_tpxo8_atlas_30_v1
      If you obtain the newer TPXO9_atlas model, put the files in the same place and make an
      appropriately named model file specifying the full path to each model file.
    EOS
  end

  # test do
  #   system "#{prefix}/extract_HC<setup.inp"
  #   assert File.exist? "#{prefix}/sample.out"
  # end
end
