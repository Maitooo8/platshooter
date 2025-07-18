//inputs
rightKey = keyboard_check(vk_right);
leftKey = keyboard_check(vk_left);
jumpKeyPressed = keyboard_check_pressed(vk_space);

//movimiento horizontal
	//dirección
	moveDir =  rightKey - leftKey;

	//conseguir xspd
	xspd = moveDir * moveSpd;

	//colision horizontal
	var _subPixel = .5;
	if place_meeting( x + xspd, y, oTile)
	{
		//forzar hacia la pared
		var _pixelCheck = _subPixel * sign(xspd);
		while !place_meeting( x + _pixelCheck, y, oTile)
		{
			x += _pixelCheck;
		}
	
		//velocidad a 0 en caso de colision
		xspd = 0;	
	}

//mover
x += xspd;

//movimiento vertical
	//gravedad
	yspd += grav;
	
		//cap velocidad de caída
		if yspd > termVel { yspd = termVel; }
	
	//saltar
	if jumpKeyPressed and place_meeting(x, y + 1, oTile)
	{
		yspd = jspd;
		
	}
	//colisión vertical
	var _subPixel = .5
	if place_meeting(x, y + yspd, oTile)
	{
		//forzar hacia la pared
		var _pixelCheck = _subPixel * sign(yspd);
		while !place_meeting (x, y + _pixelCheck, oTile)
		{
			y += _pixelCheck;
		}
		//velocidad a 0 en caso de colision
		yspd = 0
	}
	//mover
	y += yspd;