#
# FreeIntegralModules: Routine to deal with free ZG-modules and functor to QG
#
# This file runs package tests. It is also referenced in the package
# metadata in PackageInfo.g.
#
LoadPackage( "FreeIntegralModules" );
HOMALG_IO.show_banners := false;
HOMALG_IO.suppress_PID := true;
HOMALG_IO.use_common_stream := true;

options := rec(
    exitGAP := true,
    testOptions := rec(
        compareFunction := "uptowhitespace"
    ),
);

TestDirectory(DirectoriesPackageLibrary( "FreeIntegralModules", "tst" ), options );

FORCE_QUIT_GAP(1); # if we ever get here, there was an error
