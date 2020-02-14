# The GAP package FreeIntegralModules

This package allows one, given a finite group G, to create miscelaneous 
categories related to it, namely, itself as a category, its linear completion 
as well as the additive completion of the latest, which is equivalent to the category 
of left free integral G-modules and the skeletal category of QG-modules. It also 
provides a functor from ZG-free to QG-mod that converts a morphism in ZG-free, 
which is represented as the right multiplication by a matrix with entries in ZG, 
to a matrix with entries in Q, which represents the action of the right multiplication 
on the isotypic components of the corresponding power of the regular QG-module. 
This allows for instance, given a complex K of free left ZG-modules (e.g. coming from 
an equivariant G-CW-structure on a space), to compute the homology of Q \otimes_Z K 
in terms of irreducible Q-representations of G. Finally, one also can construct the 
forgetful functor from ZG-free to Z-mod. This allows one to retrieve the integral
homology of the complex K, without the action of G though.



## Installation

To install this package, just download the entire folder containing this 
README file and unpack it in the 'pkg' subdirectory of your GAP 4 installation. 
This creates a subdirectory called 'FreeIntegralModules' and completes the 
installation of the package. You can now load it in a GAP terminal. 

Please note that this requires the installation of the following packages 


"CAP" with version >= 2020.01.10 

"MatricesForHomalg" with version >= 2020.01.02 

"RingsForHomalg" with version >= 2019.12.02 

"FreydCategoriesForCAP" with version >= 2019.11.02 

"GroupRepresentationsForCAP" with version >= 2019.09.02 

"GeneralizedMorphismsForCAP" with version >= 2019.01.16

"ComplexesForCAP" with version >= 2019.12.02

"ModulePresentationsForCAP" with version >= 2019.08.07

"io_forhomalg" with version >= 2019.09.02



## Contact

For any question, suggestion, commentary, please contact me at 
arthur.garnier@u-picardie.fr



## TODO

- create a documentation and a manual
- extend the construction to a number field
