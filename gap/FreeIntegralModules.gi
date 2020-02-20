#
# FreeIntegralModules: Routine to deal with free ZG-modules and functor to QG
#
# Implementations
#
InstallGlobalFunction( FreeIntegralModules_Example,
function()
	Print( "This is a placeholder function, replace it with your own code.\n" );
end );

InstallMethod( FreeIntMods,
		[ IsGroup ],
	function( G )
	local CG, compare_func, ZCG, RowsG;
	CG := GroupAsCategory( G );;
	compare_func := function( g , h ) return UnderlyingGroupElement( g )<UnderlyingGroupElement( h ); end;;
	ZCG := LinearClosure( HomalgRingOfIntegers( ), CG, compare_func );; RowsG := AdditiveClosure( ZCG );;
	return( [ CG, ZCG, RowsG ] );
end );


InstallMethod( LeftQGMods,
		[ IsField, IsGroup ],
	function( Q, G )
	local QG, g1, B, M;
	QG := GroupRing( Q, G );; g1 := One( QG );; B := Basis( QG, List( Elements( G ), g -> g1 * g ) );;
	M := List( B, b -> List( B, c -> Coefficients( B, c * b ) ) );; M := Basis( VectorSpace( Q, M ), M);;
	return( [ QG, B, M ] );
end );


InstallGlobalFunction( Reps, 
		[IsField, IsGroup],
	function( Q, G )
	local RepG, reg, Irrs, c, Mchi;
	RepG := RepresentationCategory( G );
	reg := [];; Irrs := [];;
	for c in Irr( G ) do
	Add( Irrs, GIrreducibleObject( c ) ); Add( reg, [ Degree( c ), GIrreducibleObject( c ) ] ); od;
	reg := SemisimpleCategoryObject( reg, RepG );;
	Mchi := List( Irr( G ) , chi -> IrreducibleRepresentationsDixon( G , chi ) );;
	Mchi := List( Mchi , rho -> List( Elements( G ) , g -> TransposedMat( Image( rho , g^-1 ) ) ) );;
	return( [ RepG, Irrs, reg, Mchi ] );
end );


InstallGlobalFunction( AsGAPMatrix,
		[IsField, IsHomalgMatrix],
	function( Q, MH )
	local m, n, i, j, Mat;
	m := DimensionsMat( MH )[ 1 ];; n := DimensionsMat( MH )[ 2 ];; Mat:=NullMat( m, n, Q );;
	for i in [1..m] do
	for j in [1..n] do
	Mat[ i, j ]:=MH[ i, j ]; od; od;
	return( Mat );
end );


InstallGlobalFunction( AsQGMatrix,
		[IsList, IsList, IsList],
	function( F, L, f )
	local RowsG, u, QG, B, M, sG, Mat , m , n , MatG , i , j , C , c;
	RowsG := F[3]; 
	u := AsAdditiveClosureObject( LinearClosureObject( F[2], GroupAsCategoryUniqueObject( F[1] ) ) ); 
	QG := L[1]; B := L[2]; M := L[3]; sG := Size( UnderlyingGroup( F[1] ) );
	Mat := AsGAPMatrix( LeftActingDomain( QG ), UnderlyingMatrix( HomStructure( u , f/RowsG ) ) );; m := DimensionsMat( Mat )[ 1 ]/sG;; n := DimensionsMat( Mat )[ 2 ]/sG;;
	MatG := NullMat( m , n , QG );;
	for i in [1..m] do
	for j in [1..n] do
	C := Coefficients( M , Mat{[1 + sG * ( i - 1 )..sG * i]}{[1 + sG * ( j - 1 )..sG * j]} );
	for c in [1..sG] do
	MatG[ i ,j ] := MatG[ i ,j ] + C[ c ] * B[ c ]; od; od; od;
	return( MatG );
end );


InstallGlobalFunction( Skeletification,
		[IsField, IsGroup],
	function( Q, G )
	local Skeletification, F, R, L, RowsG, reg, B, Mchi, Qrep, Irrs, RepG, sG, CG, ZCG;
	F := FreeIntMods( G ); L := LeftQGMods( Q, G ); R := Reps( Q, G );
	CG := F[1]; ZCG := F[2]; RowsG := CapCategory( Source( [ [ One( G )/F[1]/F[2] ] ]/F[3] ) ); B := L[2]; 
	RepG := R[1]; Irrs := R[2]; reg := R[3]; Mchi := R[4]; Qrep := UnderlyingFieldForHomalgForSemisimpleCategory( R[1] ); sG := Size( UnderlyingGroup( F[1] ) );
	
	Skeletification := CapFunctor( "Skeletification" , RowsG , RepG );

	AddObjectFunction( Skeletification ,
	function( obj )
	local D;
	if Size( ObjectList( obj ) ) = 0 then D := ZeroObject( RepG );
	else D := DirectSum( ListWithIdenticalEntries( Size( ObjectList( obj ) ) , reg ) ); fi;
	return( D );
	end );

	AddMorphismFunction( Skeletification ,
	function( new_source , mor , new_range )
	local f, Mat , m , n , Mats , i , j , C , c , k , mat;
	if IsZero( new_source ) then f := MorphismFromZeroObject( new_range );
	elif IsZero( new_range ) then f := MorphismIntoZeroObject( new_source );
	else
	Mat := AsQGMatrix( F, L, MorphismMatrix( mor ) ); m := DimensionsMat( Mat )[ 1 ]; n := DimensionsMat( Mat )[ 2 ];
	Mats := List( Irr( G ) , chi -> [ chi[ 1 ] , NullMat( chi[ 1 ] * m , chi[ 1 ] * n , Q ) ] );
	for i in [1..m] do
	for j in [1..n] do
	C := Coefficients( B , Mat[ i , j ] );
	for c in [1..sG] do
	for k in [1..Size( Irr( G ) )] do
	mat := Mats[ k ]; 
	mat[2]{[( i - 1 ) * mat[ 1 ] + 1..mat[ 1 ] * i]}{[( j - 1 ) * mat[ 1 ] + 1..mat[ 1 ] * j]} := mat[ 2 ]{[( i - 1 ) * mat[ 1 ] + 1..mat[ 1 ] * i]}{[( j - 1 ) * mat[ 1 ] + 1..mat[ 1 ] * j]} + C[ c ] * Mchi[ k ][ c ]; od; od; od; od;
	Mats := List( Mats , mat -> HomalgMatrix( mat[ 2 ] , DimensionsMat( mat[ 2 ] )[ 1 ] , DimensionsMat( mat[ 2 ] )[ 2 ] , Qrep ) );
	Mats := List( Mats , mat -> VectorSpaceMorphism( VectorSpaceObject( DimensionsMat( mat )[ 1 ] , Qrep ) , mat , VectorSpaceObject( DimensionsMat( mat )[ 2 ] , Qrep ) ) );
	Mats := List( [1..Size( Irr( G ) )] , n -> [ Mats[ n ] , Irrs[ n ] ] ); f := SemisimpleCategoryMorphism( new_source, Mats, new_range ); fi;
	return( f );
	end );
	
	return Skeletification;
end );


InstallMethod( ForgetToZ, 
		[ IsGroup ],
	function( G )
	local F, CG, ZCG, RowsG, u, R, R1, Z_mod, Forget, sG;
	F := FreeIntMods( G ); CG := F[1]; ZCG := F[2]; RowsG := F[3]; u := AsAdditiveClosureObject( LinearClosureObject( F[2], GroupAsCategoryUniqueObject( F[1] ) ) ); 
	R := HomalgRing( UnderlyingMatrix( HomStructure( u,[ [ One(G)/CG/ZCG ] ]/RowsG ) ) ) ; 
	R1 := FreeLeftPresentation( 1, R ) ; R1 := AsLeftPresentation( HomalgMatrix( "[[ 1 ]]", R ) ) ;
	Z_mod := LeftPresentations( R ) ; sG := Size( UnderlyingGroup( CG ) );

	Forget := CapFunctor( "Forget", CapCategory( [ [ One(G)/CG/ZCG ] ]/RowsG ), Z_mod );

	AddObjectFunction( Forget,
	function( obj )
	return( FreeLeftPresentation( sG*Size( ObjectList( obj ) ), R ) );
	end );

	AddMorphismFunction( Forget,
	function( new_source, mor, new_range )
	return( AsMorphismBetweenFreeLeftPresentations( UnderlyingMatrix( HomStructure( u, mor ) ) ) );
	end );
	return Forget;
end );


InstallMethod( PresentationsToHomalgComplex,
		[ IsChainComplex ],
	function( C )
	local R, m, M, Objs, Mors, CC, n;
	R := HomalgRing( UnderlyingMatrix( Differentials( C )[0] ) );
	m := ActiveLowerBound( C ) + 1; M := ActiveUpperBound( C ) - 1;
	Objs := List( [ m..M ], n -> Sum( DimensionsMat( UnderlyingMatrix( Objects( C )[n] ) ) )*R );
	Mors := List( [ m + 1..M ], n -> TransposedMatrix( HomalgMatrix( AsGAPMatrix( Integers, UnderlyingMatrix( Differentials( C )[n] ) ), R ) ) );
	Mors := List( [ 0..Size( Mors ) - 1 ], n -> HomalgMap( Mors[ Size( Mors ) - n ], Objs[ Size( Objs ) - n - 1 ], Objs[ Size( Objs ) - n ] ) );
	CC := HomalgComplex( Mors[1], m + 1 ); 
	if Size( Mors ) > 1 then 
	for n in [ 2..Size( Mors ) ] do
	Add( CC, Mors[n] ); od; fi;
	return( CC );
end );


#InstallGlobalFunction( ForgetToZ, 
#		[IsGroup],
#	function( G )
#	local F, CG, ZCG, RowsG, u, R, R1, Z_mod, Ch_Z, Forget;
#	F := FreeIntMods( G ); CG := F[1]; ZCG := F[2]; RowsG := F[3]; u := AsAdditiveClosureObject( LinearClosureObject( F[2], GroupAsCategoryUniqueObject( F[1] ) ) ); 
#	R := HomalgRing( UnderlyingMatrix( HomStructure( u,[ [ One(G)/CG/ZCG ] ]/RowsG ) ) ) ; 
#	R1 := FreeLeftPresentation( 1, R ) ; R1 := AsLeftPresentation( HomalgMatrix( "[[ 1 ]]", R ) ) ;
#	Z_mod := LeftPresentations( R ) ;
#	Ch_Z := ChainComplexCategory( Z_mod ) ;
#
#	Forget := CapFunctor( "Forget", CapCategory( ChainComplex( [ [ [ One(G)/CG/ZCG ] ]/RowsW ], 0 ) ), Ch_Z );
#
#	AddObjectFunction( Forget,
#	function( obj )
#	local D;
#	D := List( Differentials( obj ), d -> HomStructure( u, d ) );
#	D := List( [ ActiveLowerBound( obj ) + 2..ActiveUpperBound( obj ) - 1 ], n-> AsMorphismBetweenFreeLeftPresentations( UnderlyingMatrix( D[n] ) ) );
#	return( ChainComplex( D, ActiveLowerBound( obj ) + 2 ) );
#	end );
#
#	AddMorphismFunction( Forget,
#	function(new_source,mor,new_range)
#	local Mor;
#	Mor := List( Morphisms( mor ), f -> HomStructure( u, f ) );
#	Mor := List( [ ActiveLowerBound( mor ) + 2..ActiveUpperBound( mor ) - 1 ], n -> AsMorphismBetweenFreeLeftPresentations( UnderlyingMatrix( Mor[n] ) ) );
#	return( ChainMorphism( new_source, new_range, Mor, ActiveLowerBound( new_source ) + 1 ) );
#	end );
#	
#	return( RowsG, Ch_Z, Forget ] );
#end );
