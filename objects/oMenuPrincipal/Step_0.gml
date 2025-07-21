//inputs
up_key = keyboard_check_pressed(vk_up);
down_key = keyboard_check_pressed(vk_down);
accept_key = keyboard_check_pressed(vk_space);

//navegar en el menu
pos += down_key - up_key;
if pos >= op_length {pos = 0}
if pos < 0 {pos = op_length - 1}

//usar las opciones
if accept_key
{
	switch(pos)
	{
		//iniciar juego
		case 0:
		room_goto_next()
	
			break;
		//opciones
		case 1:
	
			break;

		//salir del juego
		case 2:
		game_end();
	
			break;
	
	}
}