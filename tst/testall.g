#
# FreeIntegralModules: Routine to deal with free ZG-modules and functor to QG
#
# This file runs package tests. It is also referenced in the package
# metadata in PackageInfo.g.
#
LoadPackage( "FreeIntegralModules" );

TestDirectory(DirectoriesPackageLibrary( "FreeIntegralModules", "tst" ),
  rec(exitGAP := true));

FORCE_QUIT_GAP(1); # if we ever get here, there was an error
