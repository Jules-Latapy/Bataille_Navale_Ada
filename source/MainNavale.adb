with terrain_pack ; use terrain_pack ;
with Ada.Text_IO ; use Ada.Text_IO ;

procedure MainNavale is

	t1 : Terrain := new_Terrain(true ,true);
	t2 : Terrain := new_Terrain(false,true);--terrain caché de l'adversaire

	input : String (1..2) ;
begin

	while (not t2.perdu or not t1.perdu) loop
		put_line("+-----------------------------------+");
		put_line("|          Terrain adverse          |");
		put_line("+-----------------------------------+");

		t2.toString;

		put_line("+-----------------------------------+");
		put_line("|           votre Terrain           |");
		put_line("+-----------------------------------+");

		t1.toString;

		put("ou voulez vous tirer [A..I , 1..9] ? ");
		get(input);

		--le joueur tire sur t2
		t2.tirer(Integer'Value ((1 => input(2))),input(1));
		--l'IA tire sur t1
		t1.tirer_au_hasard ;
			
	end loop;

		if t2.perdu then
			put_line("+-----------------------------------+");
			put_line("|               GAGNER!             |");
			put_line("+-----------------------------------+");
		else
			put_line("+-----------------------------------+");
			put_line("|               PERDU!              |");
			put_line("+-----------------------------------+");	
		end if;


end MainNavale;
