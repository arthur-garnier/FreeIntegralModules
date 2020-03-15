#
# FreeIntegralModules: Routine to deal with free ZG-modules and functor to QG
#
#! @Chapter Introduction
#!
#! FreeIntegralModules is a package which does some
#! interesting and cool things
#!
#! @Chapter Functionality
#!
#!
#! @Section Example Methods
#!
#! This section will describe the example
#! methods of FreeIntegralModules

#! @Description
#!   Insert documentation for your function here
DeclareGlobalFunction( "FreeIntegralModules_Example" );


#! @Description 
#! The input is a finite group $G$.
#! The output is a list $[CG,ZCG,RowsG]$ with $CG$ the group $G$
#! as a category with one object, $ZCG$ is the integral linear closure
#! of $CG$. It is the ring $\mathbb{Z}[G]$ considered as a linear category with 
#! one object. Finally, $RowsG$ is the additive closure of $ZCG$. It is
#! the category of free $\mathbb{Z}[G]$-modules of finite rank.
#! These constructions are due to Sebastian Posur.
#! @Arguments G
#! @Returns a list
DeclareAttribute( "FREE_INT_MODS" , IsGroup );

#! @Description
#! The input is a field $k$ and a finite group $G$.
#! The output is a list $[kG,B,M]$ with $kG$ the group algebra
#! of $G$ over $k$, $B$ the standard basis of $kG$ and $M$ the
#! basis of the endomorphisms of the regular left module over
#! $kG$, given by right multiplication by elements of $kG$.
#! This is represented by the permutation matrices of right 
#! multiplications by elements of $G$ on the standard basis of $kG$.
#! @Arguments k,G
#! @Returns a list 
DeclareOperation( "LEFT_KG_MODS" , [ IsField, IsGroup ] );

#! @Description
#! The input is a field $k$ of characteristic zero 
#! (which, for now, is forced to be equal to $\mathbb{Q}$),
#! and a finite group $G$.
#! The output is a list $[RepG,Irrs,reg,Mchi]$, with $RepG$ the skeletal
#! category of $k$-representations of $G$, $Irrs$ the list of
#! (absolutely) irreducible $k[G]$-modules and $reg$ the regular $k[G]$-module. 
#! These constructions are due to Sebastian Posur.
#! Next, $Mchi$ is a list of lists, one for each irreducible character $\chi$ os $G$,
#! each one containing the matrices of the dual representation associated to $\chi$.
#! The later representation is computed using Dixon's algorithm. This represents the
#! action of right multiplication by an element of $G$ on the $\chi$-isotypic component
#! of the left regular $k[G]$-module in terms of a (left) $k[G]$-basis of the
#! isotypic component.
#! @Arguments k,G
#! @Returns a list
DeclareOperation( "IMAGES_OF_GROUP_ELEMENTS_FOR_SCALAR_EXT_FUNCTOR" , [ IsField, IsGroup ] );

#! @Description
#! The input is a morphism $f$ in $RowsG$.
#! The output is the corresponding matrix of $\mathbb{Z}[G]$.
#! This function is used in $Skeletification$.
#! @Arguments a list of three lists
#! @Returns a matrix in $\mathbb{Z}[G]$.
DeclareOperation( "AsQGMatrix" , [ IsList, IsList, IsList ] );

#! @Description
#! The input is a field $k$ of characteristic zero 
#! (which, for now, is forced to be equal to $\mathbb{Q}$)
#! and a finite group $G$.
#! The output is the scalar extension functor 
#! $-\otimes_{\mathbb{Z}} \mathbb{Q} : \mathbb{Z}[G]-free \to \mathbb{Q}[G]-Mod$.
#! Given a free $\mathbb{Z}[G]$-module $\mathbb{Z}[G]^n$, it returns $reg^n$,
#! where $reg$ is the regular representation constructed by $Reps(k,G)[3]$.
#! Given a morphism in $\mathbb{Z}[G]-free$, represented by right multiplication
#! by a matrix with entries in $\mathbb{Z}[G]$ (here, such a matrix is represented
#! by a morphism in $RowsG$), it returns the corresponding matrix of right
#! multiplication on $reg^n$, expressed in terms of its isotypic components.
#! This is represented by a matrix with entries in $k$.
#! Please note that it is preferable, in order to use the functor $S$,
#! to work in the categories provided by this function and not the ones given
#! by an above one.
#! @Arguments k,G
#! @Returns a cap functor
DeclareOperation( "Skeletification" , [ IsField, IsGroup ] );

#! @Description
#! The input is a finite group $G$.
#! The output is the forgetful functor $\mathbb{Z}[G]-free \to \mathbb{Z}-Mod$.
#! @Arguments G
#! @Returns a cap functor
DeclareAttribute( "ForgetToZ" , IsGroup );

#! @Description
#! The input is a complex in the category of left presentations of $\mathbb{Z}$
#! The output is the corresponding chain complex, expressed in homalg (not in CAP).
#! @Arguments C
#! @Returns a homalg complex
DeclareAttribute( "PresentationsToHomalgComplex" , IsChainComplex );
