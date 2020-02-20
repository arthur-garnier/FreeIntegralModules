#! @Chapter Examples and Tests

#! @Section Functors


LoadPackage( "freeintegralmodules" );


#! First, we test the functor skeletification by defining a chain complex
#! in ZS_3-free and then compute its homology in terms of irreducible
#! Q-modules using Skeletification : 

#! @Example
Q := Rationals;; G := SymmetricGroup( 3 );;
Skel := Skeletification( Q, G );;
RepG := AsCapCategory( Range( Skel ) );;
RowsG := AsCapCategory( Source( Skel ) );;
ZCG := UnderlyingCategory( RowsG );;
CG := UnderlyingCategory( ZCG );;

s1 := ( )/CG/ZCG;; sa := (1,2)/CG/ZCG;; sb := (2,3)/CG/ZCG;; s0 := sa*sb*sa;; ze := sa-sa;;

d1 := [ [ s1 - sa, s1 - sb, s1 - s0 ] ]/RowsG;; 

d2 := [ [ sb, s1 - s0, - s1 ], [ s1 - s0, sa, s0 ], [ - s1, s0, s1 - sa ] ]/RowsG;; 

d3 := [ [ s1 - sa ], [ s1 - sb ], [ s1 - s0 ] ]/RowsG;;

K := ChainComplex( [ d3, d2, d1 ], 1 );
#! <A bounded object in Chain complexes category over Additive closure( LinearClosure( Group as category( SymmetricGroup( [ 1 .. 3 ] ) ) ) ) with active lower bound -1 and active upper bound 4>
Skel_chain := ExtendFunctorToChainComplexCategories( Skel );;
KQ := ApplyFunctor( Skel_chain, K );
#! <A bounded object in Chain complexes category over The representation category of SymmetricGroup( [ 1 .. 3 ] ) with active lower bound -1 and active upper bound 4>
H_supp := HomologySupport( KQ );
#! [ 0, 3 ]
for i in [ Minimum( H_supp )..Maximum( H_supp ) ] do
Display( HomologyAt( KQ, i ) ); od;
#! 1*(x_3)
#! 0
#! 0
#! 1*(x_3)
# @EndExample


#! Then, we can test, using the same chain complex, the forgetfull functor
#! and the function 'PresentationsToHomalgComplex' to compute its
#! integral homology : 

#! @Example
Forget := ForgetToZ( G );;
RowsG := AsCapCategory( Source( Forget ) );;
ZCG := UnderlyingCategory( RowsG );;
CG := UnderlyingCategory ( ZCG );;

s1 := ( )/CG/ZCG;; sa := (1,2)/CG/ZCG;; sb := (2,3)/CG/ZCG;; s0 := sa*sb*sa;; ze := sa-sa;;

d1 := [ [ s1 - sa, s1 - sb, s1 - s0 ] ]/RowsG;; 

d2 := [ [ sb, s1 - s0, - s1 ], [ s1 - s0, sa, s0 ], [ - s1, s0, s1 - sa ] ]/RowsG;; 

d3 := [ [ s1 - sa ], [ s1 - sb ], [ s1 - s0 ] ]/RowsG;;

K := ChainComplex( [d3, d2, d1 ], 1 );
#! <A bounded object in Chain complexes category over Additive closure( LinearClosure( Group as category( SymmetricGroup( [ 1 .. 3 ] ) ) ) ) with active lower bound -1 and active upper bound 4>
Forget_chain := ExtendFunctorToChainComplexCategories( Forget );;
KZ := ApplyFunctor( Forget_chain, K );
#! <A bounded object in Chain complexes category over Category of left presentations of Z with active lower bound -1 and active upper bound 4>
kZ := PresentationsToHomalgComplex( KZ );
#! <A sequence containing 3 morphisms of left modules at degrees [ 0 .. 3 ]>
Display( ByASmallerPresentation( Homology( kZ ) ) );
#! -------------------------
#! at homology degree: 3
#! Z^(1 x 1)
#! -------------------------
#! at homology degree: 2
#! 0
#! -------------------------
#! at homology degree: 1
#! Z/< 2 > + Z/< 2 > 
#! -------------------------
#! at homology degree: 0
#! Z^(1 x 1)
#! -------------------------
# @EndExample
