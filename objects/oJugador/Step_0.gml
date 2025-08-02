//inputs
getControls();

//colisión sprite
mask_index = maskSpr

//movimiento horizontal
//dirección. limitado si estamos haciendo un dash
if !dashing and !sliding { moveDir =  rightKey - leftKey; }

//a donde estoy mirando
if moveDir != 0 { face = moveDir; };

//conseguir xspd
xspd = moveDir * moveSpd;
	
///////////////////////////////////////////////////////////////////

//dash/slide
//si el jugador es Dash
if character = 0
{
	//si podemos dashear y presionamos la tecla, entramos en estado de dash
	if (canDash) and (dashKey) and !dashing
	{	
		//preparar estado
		dashing = true;
		canDash = false;
		dashDirection = point_direction(0,0,face,0);
		dashSp = dashDistance/dashTime;
		dashEnergy = dashDistance; 
	}
	
	//si estamos en estado de dash
	if (dashing) 
	{
		xspd = lengthdir_x(dashSp,dashDirection) jumpKeyBuffered = 0
	}
	
	//terminar el dash
	dashEnergy -= dashSp;
	if (dashEnergy <= 0) { dashing = false}
}

//resetear buffer de slide
if (slideStartBuffer > 0) { slideStartBuffer--; }

//si el jugador es Slide
if character = 1
{
	//preparar variables
	dashDistance = 192
	dashTime = 24	
	
	//si podemos deslizar y presionamos la tecla, entramos en estado de slide
	if (canDash) and (dashKey) and onGround and !sliding
	{
		//preparar estado
		sliding = true;
		slideStartBuffer = 3;
		canDash = false;
		dashDirection = point_direction(0,0,face,0);
		dashSp = dashDistance/dashTime;
		dashEnergy = dashDistance;
		maskSpr = sSlideDash
	}
	
	//si estamos en estado de slide
	if (sliding) 
	{
		xspd = lengthdir_x(dashSp,dashDirection) jumpKeyBuffered = 0;
		dashEnergy -= dashSp;	
		
		//en caso de haber colisión en el siguiente frame y arriba del jugador, continuar deslizando
		if (dashEnergy <= 0 and !place_meeting(x+xspd, y - 22, oTile))
		{
			sliding = false;
			maskSpr = sSlideIdle
		}
	}
}

///////////////////////////////////////////////////////////////////

//colisión horizontal
var _subPixel = .5;
if place_meeting( x + xspd, y, oTile)
{
	//revisar si hay una rampa para subir
	if !place_meeting(x + xspd, y - abs(xspd)-1, oTile)
	{
		while place_meeting(x + xspd, y, oTile) { y-= _subPixel }	
	}
	
	//siguiente, revisar si no hay rampas en el techo, si no hay, colisión normal
	else
	{
		//rampas en el techo
		if !place_meeting(x + xspd, y + abs(xspd)+1, oTile)
		{
			while place_meeting(x + xspd, y, oTile) { y += _subPixel; }
		}
		else
		//colisión normal
		{
			
		//forzar hacia la pared
		var _pixelCheck = _subPixel * sign(xspd);
		while !place_meeting( x + _pixelCheck, y, oTile){x += _pixelCheck;}
		
		//en caso de chocar frenamos el estado de dash teniendo en cuenta el buffer y tengamos espacio arriba
		if (slideStartBuffer <= 0) and !place_meeting(x, y - 22, oTile)
		{
			sliding = false;
			maskSpr = sSlideIdle
		}
		
		//velocidad a 0 en caso de colisión
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

///////////////////////////////////////////////////////////////////

//movimiento vertical
//gravedad
if coyoteHangTimer > 0
{
	//bajar el timer
	coyoteHangTimer --;
}
else
{
	//aplicar gravedad
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
	//si estamos en el aire, no poder saltar extra
	coyoteJumpTimer--;
	if jumpCount == 0 and coyoteJumpTimer <= 0 { jumpCount = 1; }
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

///////////////////////////////////////////////////////////////////

//colisión vertical y movimiento
//cap velocidad de caída
if yspd > termVel { yspd = termVel; }

//colisión
var _subPixel = .5

//colisión vertical con rampas en el techo
if yspd < 0 and place_meeting(x , y + yspd, oTile)
{
	//saltar hacia rampa en el techo
	var _slopeSlide = false;
	//deslizar con rampa izquierda
	if moveDir == 0 and !place_meeting(x - abs(yspd)-1, y + yspd, oTile)
	{
		while place_meeting(x, y + yspd, oTile) { x -= 1}
		_slopeSlide = true
	}
	//deslizar con rampa derecha
	if moveDir == 0 and !place_meeting(x + abs(yspd)+1,y + yspd, oTile)
	{
		while place_meeting(x, y + yspd, oTile) { x += 1}
		_slopeSlide = true
	}
	
	//colisión vertical normal
	if !_slopeSlide
	{
		//forzar hacia la pared
		var _pixelCheck = _subPixel * sign(yspd);
		while !place_meeting (x, y + _pixelCheck, oTile) { y += _pixelCheck; }
		
		//bonk
		yspd = 0
		if yspd < 0 { jumpHoldTimer = 0 }
	}
}
	
///////////////////////////////////////////////////////////////////
	
//colisión vertical hacia abajo
if yspd >= 0
{
	if place_meeting(x, y + yspd, oTile)
	{
		//forzar hacia la pared
		var _pixelCheck = _subPixel * sign(yspd);
		while !place_meeting (x, y + _pixelCheck, oTile)
		{ y += _pixelCheck; }
		
		//velocidad a 0 en caso de colision
		yspd = 0
	}
	
	//marcar si estamos en el suelo y reseteamos variables
	if place_meeting(x, y + 1, oTile)
	{
		setOnGround(true);
		canDash = true
	}
}

//mover
//si estamos haciendo un dash, no nos movemos verticalmente, si no funcionamiento normal
if (dashing) { yspd = 0 }
else
y += yspd
	
///////////////////////////////////////////////////////////////////

//sprites
//si el jugador es Dash
if character = 0
{
	maskSpr = sDashIdle
	idleSpr = sDashIdle
	walkSpr = sDashCaminar
	jumpSpr = sDashSalto
	fallSpr = sDashCaida
	dashSpr = sDashDash
	
	if abs(xspd) > 0 { sprite_index = walkSpr };
	//no moverse
	if xspd == 0 { sprite_index = idleSpr };
	//en el aire
	if !onGround {sprite_index = jumpSpr}
	//cayendo
	if !onGround && yspd > 0 {sprite_index = fallSpr;}; 
	//dash
	if dashing = true { sprite_index = dashSpr }
	maskSpr = sDashIdle
}
//si el jugador es Slide
if character = 1
{
	idleSpr = sSlideIdle
	walkSpr = sSlideCaminar
	jumpSpr = sSlideSalto
	fallSpr = sSlideCaida
	dashSpr = sSlideDash
	
	if abs(xspd) > 0 { sprite_index = walkSpr };
	//no moverse
	if xspd == 0 { sprite_index = idleSpr };
	//en el aire
	if !onGround {sprite_index = jumpSpr}
	//cayendo
	if !onGround && yspd > 0 {sprite_index = fallSpr;}; 
	//slide
	if sliding = true { sprite_index = dashSpr }
}

//"Morir" (resetear la sala)
if place_meeting(x,y,oTriggerDeath)
{
	global.from_death = true;
	room_restart();
}