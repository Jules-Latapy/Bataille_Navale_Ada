with Ada.Text_IO ; use Ada.Text_IO ;
with Ada.Numerics.Float_Random ; use Ada.Numerics.Float_Random;

package bateau_pack is
	
	bateau_en_dehors_des_ligne_error : exception ;

	subtype coordonneeX is Natural   range 1..9 ;
	subtype coordonneeY is Character range 'A'..'I';
	type Categorie is (Porte_Avions,Croiseur,contre_Torpilleur,Torpilleur);
	type Direction is (Horizontal,Vertical);

	function hasard( fin : Integer ; debut : Integer:=0) return Integer ;

--Objet-----------------------------

	------------
	--Attribut--
	------------
	type Bateau( size : Integer ) is tagged private ;

	-----------
	--Methode--
	-----------
	function new_Bateau(cat:Categorie;X1:CoordonneeX;Y1:CoordonneeY;dir:Direction) return Bateau ;

	function new_Bateau_Aleatoire(cat:Categorie) return Bateau ;

	function isTouching (Self : Bateau;X1:CoordonneeX;Y1:CoordonneeY) return Boolean ;

	function toString (Self : Bateau) return Character ;

private 

	type PointsX is array (Integer range <>) of CoordonneeX;
	type PointsY is array (Integer range <>) of CoordonneeY;


	------------
	--Attribut--
	------------

	type Bateau( size : Integer ) is tagged record
		categorie_Bateau : Categorie          ;
		Detruit 		 : Boolean := false   ;
		Taille  		 : Integer            ;
		coordX 			 : PointsX(1..size)	  ;
		coordY 			 : PointsY(1..size)	  ;
	end record ;

end bateau_pack ;
