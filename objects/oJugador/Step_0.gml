//inputs
getControls();

//movimiento horizontal
	//dirección
	moveDir =  rightKey - leftKey;
	
	//get my face
	if moveDir != 0 { face = moveDir; };

	//conseguir xspd
	xspd = moveDir * moveSpd;

	//colision horizontal
	var _subPixel = .5;
	if place_meeting( x + xspd, y, oTile)
	{
		//revisar si hay una rampa para subir
		if !place_meeting(x + xspd, y - abs(xspd)-1, oTile)
		{
			while place_meeting(x + xspd, y, oTile) { y-= _subPixel }	
		}
		//siguiente, revisar si no hay rampas en el techo, si no hay, colision normal
		else
		{
			//rampas en el techo
			if !place_meeting(x + xspd, y + abs(xspd)+1, oTile)
			{
				while place_meeting(x + xspd, y, oTile) { y += _subPixel; }
			}
			else
			//colision normal
			{
			//forzar hacia la pared
			var _pixelCheck = _subPixel * sign(xspd);
			while !place_meeting( x + _pixelCheck, y, oTile){x += _pixelCheck;}
		
			//velocidad a 0 en caso de colision
			xspd = 0;	
			}
		}
	}
	//bajar rampas
	if yspd >= 0 and !place_meeting(x + xspd, y + 1, oTile) and place_meeting (x + xspd, y + abs(xspd)+1, oTile)
	{
		while !place_meeting(x + xspd, y + _subPixel, oTile) { y += _subPixel }	
	}



//mover
x += xspd;

//movimiento vertical
	//gravedad

	if coyoteHangTimer > 0
	{
		//bajar el timer
		coyoteHangTimer --;
	}
	else
	{
		//aplicar gravedad a
		yspd += grav;
		//ya no estamos en el suelo
		setOnGround(false);
	}

	//resetear variables de salto
	if onGround
	{
		jumpCount = 0;
		jumpHoldTimer = 0;
		coyoteJumpTimer = coyoteJumpFrames;
	}
	else
	{
		//si estas en el aire, no poder saltar extra
		coyoteJumpTimer--;
		if jumpCount == 0 and coyoteJumpTimer <= 0
		{
			jumpCount = 1;
		}
	}
	//iniciar el salto
	if jumpKeyBuffered and jumpCount < jumpMax
	{
		//reset buffer
		jumpKeyBuffered = false;
		jumpKeyBufferTimer = 0;
		
		//incrementar numero de saltos hechos
		jumpCount++;
		
		//marcar el jump hold timer
		jumpHoldTimer = jumpHoldFrames[jumpCount-1]
		//decir que ya no estamos en el suelo
		setOnGround(false);
	}
	//saltar basado en el timer/mantener el botón
	if jumpHoldTimer > 0
	{
		//constantemente convertir ysp en velocidad de salto
		yspd = jspd[jumpCount-1];
		//bajar el timer
		jumpHoldTimer--;
	}
	//cortar el salto soltando el boton de salto
	if !jumpKey
	{
		jumpHoldTimer = 0;
	}
	
	//colision vertical y movimiento
	//cap velocidad de caída
	if yspd > termVel { yspd = termVel; }

	//colision
	var _subPixel = .5
	if place_meeting(x, y + yspd, oTile)
	{
		//forzar hacia la pared
		var _pixelCheck = _subPixel * sign(yspd);
		while !place_meeting (x, y + _pixelCheck, oTile)
		{
			y += _pixelCheck;
		}
		//bonk
		if yspd < 0
		{
			jumpHoldTimer = 0;
		}
		
		//velocidad a 0 en caso de colision
		yspd = 0
	}
	//marcar si estamos en el suelo
	if yspd >= 0 and place_meeting(x, y + 1, oTile)
	{
		setOnGround(true);
	}

	//mover
	y += yspd;
	




//sprites
//caminando
if abs(xspd) > 0 { sprite_index = walkSpr };
//no moverse
if xspd == 0 { sprite_index = idleSpr };
//en el aire
if !onGround {sprite_index = jumpSpr}
//cayendo
if !onGround && yspd < 0 {sprite_index = fallSpr;}; 
	//colision
	mask_index = maskSpr