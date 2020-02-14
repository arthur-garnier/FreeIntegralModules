LoadPackage( "freeintegralmodules" );
Q := Rationals;; G := SymmetricGroup( 3 );;


#! First, we test the functor skeletification by defining a chain complex
#! in ZS_3-free and then compute its homology in terms of irreducible
#! Q-modules using Skeletification : 


Ske := Skeletification( Q, G );;

CG := Ske[1];; ZCG := Ske[2];; RowsG := Ske[3];; RepG := Ske[4];; Skel := Ske[5];;

s1 := ( )/CG/ZCG;; sa := (1,2)/CG/ZCG;; sb := (2,3)/CG/ZCG;; s0 := sa*sb*sa;; ze := sa-sa;;

d1 := [ [ s1 - sa, s1 - sb, s1 - s0 ] ]/RowsG;; 

d2 := [ [ sb, s1 - s0, - s1 ], [ s1 - s0, sa, s0 ], [ - s1, s0, s1 - sa ] ]/RowsG;; 

d3 := [ [ s1 - sa ], [ s1 - sb ], [ s1 - s0 ] ]/RowsG;;

K := ChainComplex( [ d3, d2, d1 ], 1 );

Skel_chain := ExtendFunctorToChainComplexCategories( Skel );

KQ := ApplyFunctor( Skel_chain, K );

H_supp := HomologySupport( KQ );

for i in [ Minimum( H_supp )..Maximum( H_supp ) ] do

Display( HomologyAt( KQ, i ) ); od;



#! Then, we can test, using the same chain complex, the forgetfull functor
#! and the function 'PresentationsToHomalgComplex' to compute its
#! integral homology : 


F := ForgetToZ( G );;

CG := F[1];; ZCG := F[2];; RowsG := F[3];; Forget := F[5];;

s1 := ( )/CG/ZCG;; sa := (1,2)/CG/ZCG;; sb := (2,3)/CG/ZCG;; s0 := sa*sb*sa;; ze := sa-sa;;

d1 := [ [ s1 - sa, s1 - sb, s1 - s0 ] ]/RowsG;; 

d2 := [ [ sb, s1 - s0, - s1 ], [ s1 - s0, sa, s0 ], [ - s1, s0, s1 - sa ] ]/RowsG;; 

d3 := [ [ s1 - sa ], [ s1 - sb ], [ s1 - s0 ] ]/RowsG;;

K := ChainComplex( [d3, d2, d1 ], 1 );

Forget_chain := ExtendFunctorToChainComplexCategories( Forget );

KZ := ApplyFunctor( Forget_chain, K );

kZ := PresentationsToHomalgComplex( KZ );

Display( ByASmallerPresentation( Homology( kZ ) ) );
