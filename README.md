# homebrew-mbsystem
## Homebrew tap for MB-System

MB-System is an open source software package for the processing and display of bathymetry and backscatter imagery data derived from multibeam, interferometry, and sidescan sonars. This software is documented and distributed at:

http://www.mbari.org/products/research-software/mb-system/

The MB-System project is maintaining this separate homebrew tap because this package is frequently updated and has a dependency, OTPS (tidal prediction software), that is not available through the core homebrew repositories. 

There are two MB-System packages available: mbsystem and mbsystem-beta. The first (mbsystem) installs the most recent major (stable) release from the Github repository. The second (mbsystem-beta) installs the most recent release whether it is major (stable) or beta (unstable). The MB-System development team uses beta releases for testing of new features and bug fixes. We do not recommend installing mbsystem-beta releases unless you are involved in the testing or the release includes bug fixes or new features that are directly relevant to you.

## Install:

To install the mbsystem package:

`brew update`

`brew tap dwcaress/mbsystem`

`brew install mbsystem`

To install the mbsystem-beta package:

`brew update`

`brew tap dwcaress/mbsystem`

`brew install mbsystem-beta`

To switch between mbsystem and mbsystem-beta installations, first uninstall the current package before installing the one you want, e.g.:

`brew uninstall mbsystem`

`brew install mbsystem-beta`

or:

`brew uninstall mbsystem-beta`

`brew install mbsystem`

## OTPS Tide Models:

The MB-System tide modeling program mbotps will only function if the tidal 
prediction software package called OTPS is also installed, along with files 
comprising a global tide model. OTPS and the global tide models it uses to 
predict tides are products of the Oregon State University Tide Group.
We provide a homebrew formula for OTPS in the MB-System tap. 

`brew update`

`brew tap dwcaress/mbsystem`

`brew install otps`

In the past, this private Homebrew formula installed the TPXO8_atlas_v1
tidal model along with the software. However, as of mid-2019 the Oregon 
State University tide group no longer makes their TPXO tidal models openly 
available for download. Consequently, this formula now installs  the OTPS 
software required for the MB-System program mbotps to work, but not the 
associated tidal model. 

The program mbotps is currently set up to work 
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

The h__tpxo9_atlas_30 and grid_tpxo9_atlas_30 files are 47 MB each, and 
the u__tpxo9_atlas_30 files are 93 MB each. These files should all be 
placed into the directory /usr/local/opt/otps/DATA/ - once these files 
are present, the combination of mbotps and opts/predict_tide should work. 
See the mbotps manual page for details.

## GMT compatibility:

MB-System depends on the GMT package at https://github.com/GenericMappingTools/gmt, which is being actively developed and updated. Although the GMT team keeps the MB-System team apprised of upcoming changes, it has happened that a GMT release broke elements of the then-current MB-System release. In the event that a new GMT release is not backwards compatible with the current mbsystem-gmt-modules, one can prevent homebrew from updating gmt within the 'brew upgrade‘ command by pinning it.

`brew pin gmt`

Once the incompatibility is resolved with a new MB-System release, gmt can then be upgraded by unpinning and upgrading it.

`brew unpin gmt`

`brew upgrade gmt`
