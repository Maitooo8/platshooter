//custom functions for player
function setOnGround(_val = true)
{
	if _val == true
	{
		onGround = true;
		coyoteHangTimer = coyoteHangFrames
	}
	else
	{
		onGround = false;
		coyoteHangTimer = 0;
	}
}

//control setup
controlsSetup()

//movimiento
moveDir = 0;
moveSpd = 5;
xspd = 0;
yspd = 0;

//salto
	grav = 0.5;
	termVel = 7.5;
	jumpMax = 1;
	jumpCount = 0;
	jumpHoldTimer = 0;
	onGround = true;
		//valores de salto para cada salto sucesivo
		jumpHoldFrames[0] = 10;
		jumpHoldFrames[1] = 2;
		jspd[0] = -5.5;
		jspd[1] = -5.5;

	//coyote time
	coyoteHangFrames = 3;
	coyoteHangTimer = 0;
	//jump buffer time
	coyoteJumpFrames = 3;
	coyoteJumpTimer = 0;