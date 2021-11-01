with bateau_pack ; use bateau_pack ;
with Ada.Text_IO ; use Ada.Text_IO ;
with Ada.Containers.Indefinite_Doubly_Linked_Lists ;
with Ada.Numerics.Float_Random ; use Ada.Numerics.Float_Random;

package terrain_pack is
	
	nbr_case_max : constant Natural := 17 ;
	
-------------
	type Terrain is tagged private;

	function  new_Terrain(est_Visible : Boolean ; Hasardeux : Boolean:=false) return Terrain;

	function  recherche  (Self : Terrain ; X:CoordonneeX;Y:CoordonneeY) return Boolean ;

	function  getBateau  (Self : Terrain ; X:CoordonneeX;Y:CoordonneeY) return Bateau  ;

	function  perdu      (Self : Terrain )                              return Boolean ;

	procedure tirer      (Self : in out Terrain ; x : Integer ; y : Character) ;

	procedure tirer_au_hasard(Self : in out Terrain ) ;

	procedure toString   (Self : Terrain ) ;

private

	-------------------------
	--liste sans contrainte--
	-------------------------

	package contenant is new Ada.Containers.Indefinite_Doubly_Linked_Lists(Bateau) ;

	use contenant ;

	-------------
	--Attributs--
	-------------

	type Tableau is array (CoordonneeX,CoordonneeY) of Boolean ;

	type Terrain is tagged record
		liste 		    : List 	  ;--liste sans contrainte
		tab_tire 	    : Tableau ;--tableau de la ou le joueur a tire
		estVisible      : Boolean ;
		nbr_case_couler : Natural ;
	end record;

end terrain_pack;