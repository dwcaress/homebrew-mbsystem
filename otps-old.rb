class OtpsOld < Formula
  desc "OTPS: OSU Tidal Prediction Software"
  homepage "http://volkov.oce.orst.edu/tides/otps.html"
  url "ftp://mbsystemftp@ftp.mbari.org/OTPS2.tar.Z"
  sha256 "c3e15679515e6e358d173eb9b46276c51ceb5bcd80ecb50822030e1d2900c361"

  option "with-tpxo8", "Install TPXO8-atlas-compact tide model"

  depends_on "gcc"

  resource "tpxo8" do
    url "ftp://mbsystemftp@ftp.mbari.org/tpxo8_atlas_compact_v1.tar.Z"
    sha256 "80f0517b2df5ec8b2fbb811f818fd6c2e38c0909313efe1b05a30728dec45491"
  end

  def install
    system "make", "extract_HC"
    system "make", "predict_tide"
    system "make", "extract_local_model"

    prefix.install Dir["*"]

    if build.with? "tpxo8"
      (prefix/"DATA").install resource("tpxo8")

      link = open("#{prefix}/DATA/Model_atlas_v1", "w")
      link.write <<~EOS
        #{prefix}/DATA/hf.tpxo8_atlas_30_v1
        #{prefix}/DATA/uv.tpxo8_atlas_30_v1
        #{prefix}/DATA/grid_tpxo8atlas_30_v1
      EOS
      link.close
    end
  end

  def caveats
    <<~EOS
      Please install a tide model.
      E.g. use '--with-tpxo8' to install
      the TPXO8-atlas-compact model.
      Each tide model needs to be linked into:
        #{prefix}/DATA/Model_<model_name>
    EOS
  end

  test do
    system "#{prefix}/extract_HC<setup.inp"
    assert File.exist? "#{prefix}/sample.out"
  end
end
