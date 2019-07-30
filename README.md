# homebrew-mbsystem
## Homebrew tap for MB-System

MB-System is an open source software package for the processing and display of bathymetry and backscatter imagery data derived from multibeam, interferometry, and sidescan sonars. This software is documented and distributed at:

http://www.mbari.org/products/research-software/mb-system/

The MB-System project is maintaining this separate homebrew tap because this package is frequently updated and has a dependency, OTPS (tidal prediction software), that is not available through the core homebrew repositories. 

There are two MB-System packages available: mbsystem and mbsystem-beta. The first (mbsystem) installs the most recent major (stable) release from the Github repository. The second (mbsystem-beta) installs the most recent release whether it is major (stable) or beta (unstable). The MB-System development team uses beta releases for testing of new features and bug fixes. We do not recommend installing mbsystem-beta releases unless you are involved in the testing or the release includes bug fixes or new features that are directly relevant to you.

## Install:

To install the mbsystem package with full tide modeling:

`brew update`

`brew tap dwcaress/mbsystem`

`brew install otps --with-tpxo8`

`brew install mbsystem`

To install the mbsystem-beta package with full tide modeling:

`brew update`

`brew tap dwcaress/mbsystem`

`brew install otps --with-tpxo8`

`brew install mbsystem-beta`

To switch between mbsystem and mbsystem-beta installations, first uninstall the current package before installing the one you want, e.g.:

`brew uninstall mbsystem`

`brew install mbsystem-beta`

or:

`brew uninstall mbsystem-beta`

`brew install mbsystem`

If you want to install and use a tide model other than tpxo8, then install MB-System without doing the opts install first. The  otps package will then be installed without a tide model (and you will have to install your own following the instructions at http://volkov.oce.orst.edu/tides/global.html).

## GMT compatibility:

MB-System depends on the GMT package at https://github.com/GenericMappingTools/gmt, which is being actively developed and updated. Although the GMT team keeps the MB-System team apprised of upcoming changes, it has happened that a GMT release broke elements of the then-current MB-System release. In the event that a new GMT release is not backwards compatible with the current mbsystem-gmt-modules, one can prevent homebrew from updating gmt within the 'brew upgrade‘ command by pinning it.

`brew pin gmt`

Once the incompatibility is resolved with a new MB-System release, gmt can then be upgraded by unpinning and upgrading it.

`brew unpin gmt`

`brew upgrade gmt`
