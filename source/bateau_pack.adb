package body bateau_pack is
	

	function hasard( fin : Integer ; debut : Integer:=0) return Integer is
		G : Generator ;
		--X : Uniformly_Distributed;
	begin
		Reset (G);
		--      Min + (int)(Math.random() * ((Max - Min  ) + 1   ));
	    return debut + Integer( Random (G) * (Float(fin) - Float(Debut)));

	end hasard ;

	-----------
	--Methode--
	-----------
	function new_Bateau(cat:Categorie;X1:CoordonneeX;Y1:CoordonneeY;dir:Direction) return Bateau is
		
		function choix_taille return Integer is
			Taille : Integer :=1;
		begin -- choix_taille
			case cat is
				when Porte_Avions 		=>Taille :=5 ;
				when Croiseur 			=>Taille :=4 ;
				when Contre_Torpilleur	=>Taille :=3 ;
				when Torpilleur 		=>Taille :=2 ;
				when others 			=>Taille :=1 ;
			end case;

			return Taille ;
		end choix_taille;

		bato : Bateau(choix_taille);

		cpt : Integer := 0;

	begin

		bato.categorie_Bateau := cat ;

		if dir = Horizontal then
			bato.coordY := (others => Y1);

			for x of bato.coordX loop
				x  := coordonneeX'Value(Integer'Image(Integer(X1)+cpt));
				cpt:= cpt+1 ;
			end loop;	
		else
			bato.coordX := (others => X1);

			for y of bato.coordY loop
				y  := coordonneeY'Value(			 --TRANSFORMÉ EN COORDY
						Character'Image(			 --TRANSFORMER EN CHAINE
							Character'Val(           --RETRANSFORMER EN CHAR
								Character'Pos(Y1)+cpt--CODE ASCII ADDITIONNER
							)
						)
					);
				cpt:= cpt+1  ;
			end loop;
		end if;

		cpt :=0 ;

		return bato;

	exception
		when Constraint_Error => 
		raise bateau_en_dehors_des_ligne_error with("/!\ un bateau est certainement en dehors du terrain");
	end new_Bateau;



	function new_Bateau_Aleatoire(cat:Categorie) return Bateau is
	begin

		return new_Bateau(	cat ,
							                hasard(9,1)   ,
							CoordonneeY'Val((Character'Pos('A')-1)+hasard(9,1))  ,
							Direction  'Val(hasard(1  ))   ) ;

	end new_Bateau_Aleatoire;

	function isTouching (Self : Bateau ; X1 : CoordonneeX ; Y1 : CoordonneeY) return Boolean is
	begin
		for x of Self.coordX loop
		for y of Self.coordY loop
			if x=X1 and y=Y1 then
				return TRUE ;
			end if;
		end loop;
		end loop;

		return FALSE ;

	end isTouching;

	function toString (Self : Bateau) return Character is
		chaine : String := (Self.categorie_Bateau'Image);
	begin
		return chaine(1);
	end toString ;

end bateau_pack ;