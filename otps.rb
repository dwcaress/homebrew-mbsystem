class Otps < Formula
  desc "OTPS: Oregon State University Tidal Prediction Software"
  homepage "https://www.tpxo.net/otps"
  url "ftp://mbsystemftp@ftp.mbari.org/OTPS_202007.tar.gz"
  sha256 "2650975626494ae11fe04fcb239ea874b965b0825289f51a6a9f83eeaee9ce64"

  depends_on "gcc"

  def install
    system "make", "extract_HC"
    system "make", "predict_tide"
    system "make", "extract_local_model"
    prefix.install Dir["*"]
  end

  def caveats
    <<~EOS
    This formula has built the 2018 version of OTPS software from the Oregon
    State University Tide Group in the directory 
        /usr/local/Cellar/otps/2018/
    and made a link named /usr/local/opt/otps to this directory. This software
    is described at:
        https://www.tpxo.net/otps
    In the past, this private Homebrew formula installed the TPXO8_atlas_v1
    tidal model along with the software. However, as of mid-2019 the Oregon 
    State University tide group no longer makes their TPXO tidal models openly 
    available for download. Consequently, this formula now installs  the OTPS 
    software required for the MB-System program mbotps to work, but not the 
    associated tidal model. The program mbotps is currently set up to work 
    with the TPXO9-atlas global tide model,which is their latest 1/30 degree 
    resolution fully global solution, obtained by combining  a 1/6 degree base 
    global solution (TPXO9.v1) with thirty 1/30 degree resolution local solutions 
    covering all coastal areas, including the Arctic and the Antarctic. 
    Academic users can register and request access to the TPXO9-atlas model 
    files at this website:
        https://www.tpxo.net
    There are 25 model files:
        grid_tpxo9_atlas_30
        h_2n2_tpxo9_atlas_30
        h_k1_tpxo9_atlas_30
        h_k2_tpxo9_atlas_30
        h_m2_tpxo9_atlas_30
        h_m4_tpxo9_atlas_30
        h_mn4_tpxo9_atlas_30
        h_ms4_tpxo9_atlas_30
        h_n2_tpxo9_atlas_30
        h_o1_tpxo9_atlas_30
        h_p1_tpxo9_atlas_30
        h_q1_tpxo9_atlas_30
        h_s2_tpxo9_atlas_30
        u_2n2_tpxo9_atlas_30
        u_k1_tpxo9_atlas_30
        u_k2_tpxo9_atlas_30
        u_m2_tpxo9_atlas_30
        u_m4_tpxo9_atlas_30
        u_mn4_tpxo9_atlas_30
        u_ms4_tpxo9_atlas_30
        u_n2_tpxo9_atlas_30
        u_o1_tpxo9_atlas_30
        u_p1_tpxo9_atlas_30
        u_q1_tpxo9_atlas_30
        u_s2_tpxo9_atlas_30
    The h_*_tpxo9_atlas_30 and grid_tpxo9_atlas_30 files are 47 MB each, and 
    the u_*_tpxo9_atlas_30 files are 93 MB each. These files should all be 
    placed into the directory /usr/local/opt/otps/DATA/ - once these files 
    are present, the combination of mbotps and opts/predict_tide should work. 
    See the mbotps manual page for details.
    EOS
  end

  # test do
  #   system "#{prefix}/extract_HC<setup.inp"
  #   assert File.exist? "#{prefix}/sample.out"
  # end
end
