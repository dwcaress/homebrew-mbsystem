# homebrew-mbsystem
## Homebrew tap for MB-System

MB-System is an open source software package for the processing and display of bathymetry and backscatter imagery data derived from multibeam, interferometry, and sidescan sonars. This software is documented and distributed at:

http://www.mbari.org/products/research-software/mb-system/

The MB-System project is maintaining this separate homebrew tap because this package is frequently updated and has a dependency, OTPS (tidal prediction software), that is not available through the core homebrew repositories. 

## Install:

`brew update`

`brew tap dwcaress/mbsystem`

`brew install otps --with-tpxo8`

`brew install mbsystem`

You can also install MB-System directly, but this will install OTPS without a tide model and you need to add your own.

## GMT compatibility:

MB-System depends on the GMT package at https://github.com/GenericMappingTools/gmt, which is being actively developed and updated. Although the GMT team keeps the MB-System team apprised of upcoming changes, it has happened that a GMT release broke elements of the then-current MB-System release. In the event that a new GMT release is not backwards compatible with the current mbsystem-gmt-modules, one can prevent homebrew from updating gmt within the 'brew upgrade‘ command by pinning it.

`brew pin gmt`

Once the incompatibility is resolved with a new MB-System release, gmt can then be upgraded by unpinning and upgrading it.

`brew unpin gmt`

`brew upgrade gmt`
