package body terrain_pack is

	function new_Terrain(est_Visible : Boolean ; Hasardeux : Boolean:=false) return Terrain is
		t : Terrain ;
		Bateau_Superposer_Error : exception ;

		function Verif_Position return Boolean is
		begin

			for x in CoordonneeX loop
			for y in CoordonneeY loop
				for b0 of t.liste loop
				for b1 of t.liste loop
					if b0.isTouching(x,y) and b1.isTouching(x,y) and b0/=b1 then
						return true ;
					end if;
				end loop;
				end loop;
			end loop;
			end loop;

			return false ;

		end Verif_Position;


		--methode pas vraiment optimisé
		procedure remplissage_hasard is
		begin -- remplissage_hasard

			t.liste.Delete_First;
			t.liste.Delete_First;
			t.liste.Delete_First;
			t.liste.Delete_First;
			t.liste.Delete_First;

			t.liste.Append(new_Bateau_Aleatoire(Torpilleur));
			t.liste.Append(new_Bateau_Aleatoire(contre_Torpilleur));
			t.liste.Append(new_Bateau_Aleatoire(contre_Torpilleur));
			t.liste.Append(new_Bateau_Aleatoire(Croiseur));
			t.liste.Append(new_Bateau_Aleatoire(Porte_Avions));	

			--si on l'a mal fait on recommence
			if Verif_Position 
			then
				remplissage_hasard ;
			end if;

		--si on l'a mal fait on recommence
		exception 
			when bateau_en_dehors_des_ligne_error => remplissage_hasard ;
					
		end remplissage_hasard;


	begin
		if (not Hasardeux) then
			t.liste.Append( new_Bateau(Torpilleur       ,1,'B',Horizontal));
			t.liste.Append( new_Bateau(contre_Torpilleur,6,'D',Vertical  ));
			t.liste.Append( new_Bateau(contre_Torpilleur,2,'D',Vertical  ));
			t.liste.Append( new_Bateau(Croiseur         ,5,'A',Horizontal));
			t.liste.Append( new_Bateau(Porte_Avions     ,3,'H',Horizontal));
		else
			remplissage_hasard ;
		end if ;


		--si malgré tout on n'est pas bon
		if Verif_Position then
			raise Bateau_Superposer_Error ;
		end if;

		t.estVisible := est_Visible ;

		--initialisation du tableau par defaut (de base il ne le fesait pas)
		for x in CoordonneeX loop
		for y in CoordonneeY loop
			t.tab_tire(x,y) := false ;
		end loop;
		end loop;

		return t ;

	end new_Terrain;



	function recherche(Self : Terrain ; X:CoordonneeX;Y:CoordonneeY) return Boolean is
	begin
		for b of Self.liste loop
			if b.isTouching(X,Y) then
				return true ;
			end if;
		end loop;

		return false ;

	end recherche;



	function getBateau(Self : Terrain ; X:CoordonneeX;Y:CoordonneeY) return Bateau is
		bato : Bateau(1) ;
	begin
		for b of Self.liste loop
			if b.isTouching(X,Y) then
				return b ;
			end if;
		end loop;

		Put_Line("/!\ Aucun bateau a cette endroit !");
		return bato ;

	end getBateau;



	procedure tirer(Self : in out Terrain ; x : Integer ; y : Character)is
		procedure verification is
			cpt : Integer := 0 ;
		begin -- verification

			for y in CoordonneeY loop
			for x in CoordonneeX loop

				if Self.recherche(x,y) then
					--si le joueur a tiré ici
					if Self.tab_tire(x,y) then
						cpt:=cpt+1 ;
					end if;
				end if;

			end loop;
			end loop;
			
			Self.nbr_case_couler := cpt ;

		end verification;
	begin
		Self.tab_tire(x,y) := true ;
		verification ;
	end tirer;

	procedure tirer_au_hasard(Self : in out Terrain ) is
		x : CoordonneeX := hasard(CoordonneeX'Last,1);
		y : CoordonneeY := CoordonneeY'Val((Character'Pos('A')-1)+hasard(CoordonneeX'Last,1));
	begin -- tirer_au_hasard
		--si on a deja tirer ici
		if Self.tab_tire(x,y) then
			tirer_au_hasard(Self);
		else
			tirer(Self,x,y);
		end if ;
		
	end tirer_au_hasard;



	function perdu(Self : Terrain) return Boolean is
	begin
		return Self.nbr_case_couler = nbr_case_max ;
	end perdu;



	procedure toString(Self : Terrain) is

		procedure affiche_ligne is
		begin -- affiche_ligne
			put("╋");

			for x in CoordonneeX loop
				put("━━━╋");
			end loop;
		end affiche_ligne;

	begin

		for x in CoordonneeX loop
			put(" " & x'Image & " ");
		end loop;

		new_line ;
		affiche_ligne ;
		new_line ;
		for y in CoordonneeY loop
			put("┃");
			for x in CoordonneeX loop

				--si il y a un bateau ici
				if Self.recherche(x,y) then

					--si il est visible
					if Self.estVisible then
						put(Character'Image(Self.getBateau(x,y).toString) & "┃");
					else
						--si le joueur a tiré ici
						if Self.tab_tire(x,y) then
							put(" O ┃");
						else
							put("   ┃");							
						end if;
					end if;
				else
					--si le joueur a tiré ici
					if Self.tab_tire(x,y) then
						put(" X ┃");
					else
						put("   ┃");			
					end if;
				end if;
			end loop;
			Put_Line(y'Image);
			affiche_ligne;
			new_line;
		end loop;

	end toString;



end terrain_pack;