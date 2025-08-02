//inputs
getControlsMenu()

//navegar en el menu
pos += downKey - upKey;
if pos >= op_length {pos = 0}
if pos < 0 {pos = op_length - 1}

//usar las opciones
if acceptKey 
{

	var _sml = menu_level;

	switch(menu_level) 
	{
		//menu principal
		case 0:
			switch(pos) 
			{
				//ir a seleccionar personaje
				case 0: menu_level = 2; break;
				//opciones
				case 1: menu_level = 1; break;
				//cerrar juego
				case 2: game_end(); break;
			}
			break;
	
		//opciones
		case 1:
			switch(pos)
			{
				//Fullscreen
				case 0: 	
				if acceptKey
					{
					    if window_get_fullscreen()
					    {
					        window_set_fullscreen(false);
							option[1,0] = "FULLSCREEN = OFF"
					    }
					    else
					    {
					        window_set_fullscreen(true);
							option[1,0] = "FULLSCREEN = ON"
					    }
					}
				break;
		
				//retroceder	
				case 1:	
				if acceptKey
					{
						menu_level = 0;	
					}
				break;
			}
			break;
		//character select
		case 2:
			switch(pos)
			{
				//seleccionar a Dash
				case 0:
				if acceptKey
				{
					oJugador.character = 0
					room_goto_next()
				}
				break;
		
				//seleccionar a Slide
				case 1:
				if acceptKey
				{
					oJugador.character = 1
					room_goto_next()
				}
				break;
		
				//retroceder
				case 2:
				if acceptKey
				{
					menu_level = 0	
				}
				break;
			}
			break;
	}
	//marcar posicion arriba
	if _sml != menu_level { pos = 0; }
}

//guardar numero de opciones en el menu actual
op_length = array_length(option[menu_level]);