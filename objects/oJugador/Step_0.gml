//inputs
getControls();

	//movimiento horizontal
	
	
	//dirección
	if !dashing
	{
	moveDir =  rightKey - leftKey;
	}
	
	//a donde estoy mirando
	if moveDir != 0 { face = moveDir; };

	//conseguir xspd
	xspd = moveDir * moveSpd;
	
	//dash
	
	if (canDash) and (dashKey) and dashing = false
	{
	dashing = true;
	canDash = false;
	dashDirection = point_direction(0,0,face,0);
	dashSp = dashDistance/dashTime;
	dashEnergy = dashDistance; 
	}
	
	if (dashing) 
	{
		xspd = lengthdir_x(dashSp,dashDirection) jumpKeyBuffered = 0
	}
	
		//terminar el dash
	dashEnergy -= dashSp;
	if (dashEnergy <= 0)
	{
		dashing = false
	}
	
	
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
	
	//colision vertical con rampas en el techo
	if yspd < 0 and place_meeting(x , y + yspd, oTile)
	{
		//saltar hacia rampa en el techo
		var _slopeSlide = false;
		//slide upleft slope
		if moveDir == 0 and !place_meeting(x - abs(yspd)-1, y + yspd, oTile)
		{
			while place_meeting(x, y + yspd, oTile) { x -= 1}
			_slopeSlide = true
		}
		//slide uprighty slope
		if moveDir == 0 and !place_meeting(x + abs(yspd)+1,y + yspd, oTile)
		{
			while place_meeting(x, y + yspd, oTile) { x += 1}
			_slopeSlide = true
		}
		//normal y collision
		if !_slopeSlide
		{
			//forzar hacia la pared
			var _pixelCheck = _subPixel * sign(yspd);
			while !place_meeting (x, y + _pixelCheck, oTile)
			{
				y += _pixelCheck;
			}
			//bonk

			yspd = 0
			if yspd < 0 {jumpHoldTimer = 0 }
		}
	}
	
	
	//downwards y collision
	if yspd >= 0
		{
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
		//marcar si estamos en el suelo
		if place_meeting(x, y + 1, oTile)
		{
			setOnGround(true);
			canDash = true
		}
	}

	//mover
	if (dashing)
	{
	 yspd = 0
	}
	else
	y += yspd
	


//sprites
//caminando


if character = 0
{
	if abs(xspd) > 0 { sprite_index = walkSpr };
	//no moverse
	if xspd == 0 { sprite_index = idleSpr };
	//en el aire
	if !onGround {sprite_index = jumpSpr}
	//cayendo
	if !onGround && yspd > 0 {sprite_index = fallSpr;}; 
	//dash
	if dashing = true { sprite_index = dashSpr }
		//colision
		mask_index = maskSpr
}
if character = 1
{
	
	
}