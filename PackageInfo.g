#
# FreeIntegralModules: Routine to deal with free ZG-modules and functor to QG
#
# This file contains package meta data. For additional information on
# the meaning and correct usage of these fields, please consult the
# manual of the "Example" package as well as the comments in its
# PackageInfo.g file.
#
SetPackageInfo( rec(

PackageName := "FreeIntegralModules",
Subtitle := "Routine to deal with free ZG-modules and functor to QG",
Version := "0.1",
Date := "08/02/2020", # dd/mm/yyyy format
License := "GPL-2.0-or-later",

Persons := [
  rec(
    IsAuthor := true,
    IsMaintainer := true,
    FirstNames := "Arthur",
    LastName := "Garnier",
    #WWWHome := TODO,
    Email := "arthur.garnier@u-picardie.fr",
    PostalAddress := Concatenation(
    		"LAMFA\n",
    		"Universite de Picardie Jules Verne\n",
    		"33 Rue Saint-Leu\n",
    		"80000 Amiens\n",
    		"France" ),
    Place := "Amiens",
    Institution := "UPJV",
  ),
  rec(
    IsAuthor := true,
    IsMaintainer := true,
    FirstNames := "Sebastian",
    LastName := "Posur",
    WWWHome := "https://sebastianpos.github.io",
    Email := "sebastian.posur@uni-siegen.de",
    PostalAddress := Concatenation(
               "Department Mathematik\n",
               "Universität Siegen\n",
               "Walter-Flex-Straße 3\n",
               "57068 Siegen\n",
               "Germany" ),
    Place := "Siegen",
    Institution := "University of Siegen",
  ),
],

#SourceRepository := rec( Type := "TODO", URL := "URL" ),
#IssueTrackerURL := "TODO",
PackageWWWHome := "https://github.com/arthur-garnier/gap",
PackageInfoURL := Concatenation( ~.PackageWWWHome, "PackageInfo.g" ),
README_URL     := Concatenation( ~.PackageWWWHome, "README.md" ),
ArchiveURL     := Concatenation( ~.PackageWWWHome,
                                 "/", ~.PackageName, "-", ~.Version ),

ArchiveFormats := ".tar.gz",

##  Status information. Currently the following cases are recognized:
##    "accepted"      for successfully refereed packages
##    "submitted"     for packages submitted for the refereeing
##    "deposited"     for packages for which the GAP developers agreed
##                    to distribute them with the core GAP system
##    "dev"           for development versions of packages
##    "other"         for all other packages
##
Status := "dev",

AbstractHTML   :=  "",

PackageDoc := rec(
  BookName  := "FreeIntegralModules",
  ArchiveURLSubset := ["doc"],
  HTMLStart := "doc/chap0.html",
  PDFFile   := "doc/manual.pdf",
  SixFile   := "doc/manual.six",
  LongTitle := "Routine to deal with free ZG-modules and functor to QG",
),

Dependencies := rec(
  GAP := ">= 4.9",
  NeededOtherPackages := [ 
  	[ "CAP", ">= 2020.01.10" ],
  	[ "MatricesForHomalg", ">= 2020.01.02" ],
  	[ "RingsForHomalg", ">= 2019.12.02" ],
  	[ "FreydCategoriesForCAP", ">= 2019.11.02" ],
  	[ "GroupRepresentationsForCAP", ">= 2019.09.02" ],
  	[ "GeneralizedMorphismsForCAP", ">= 2019.01.16" ],
  	[ "ComplexesForCAP", ">= 2019.12.02" ],
  	[ "ModulePresentationsForCAP", ">= 2019.08.07" ],
  	[ "io_forhomalg", ">= 2019.09.02" ]
  	  ],
  SuggestedOtherPackages := [ ],
  ExternalConditions := [ ],
),

AvailabilityTest := ReturnTrue,

TestFile := "tst/testall.g",

#Keywords := [ "TODO" ],

));


