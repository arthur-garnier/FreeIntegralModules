#
# FreeIntegralModules: Routine to deal with free ZG-modules and functor to QG
#
# This file is a script which compiles the package manual.
#
if fail = LoadPackage("AutoDoc", "2018.02.14") then
    Error("AutoDoc version 2018.02.14 or newer is required.");
fi;

AutoDoc(rec(
    gapdoc := rec(
        LaTeXOptions := rec(
            LateExtraPreamble := """
                \usepackage{amsmath}
                \usepackage[T1]{fontenc}
                \usepackage{tikz}
                \usetikzlibrary{shapes,arrows,matrix}
                """
        ),
    ),
    scaffold := rec(
        entities := [ "GAP4", "CAP" ],
    ),
    autodoc := rec( files := [ "doc/Intros.autodoc" ] ),
    extract_examples := rec( units := "Single" )
));

QUIT;

