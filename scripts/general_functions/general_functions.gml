function controlsSetup()
{
	bufferTime = 4;
	
	jumpKeyBuffered = 0;
	jumpKeyBufferTimer = 0;
	slideStartBuffer = 0;
	
}

function getControls()
{
	//direcciones
	rightKey = keyboard_check(vk_right);
		rightKey = clamp(rightKey, 0, 1);
	leftKey = keyboard_check(vk_left);
		leftKey = clamp(leftKey, 0, 1);
	
	//accion
	jumpKeyPressed = keyboard_check_pressed(ord("Z"));
		jumpKeyPressed = clamp(jumpKeyPressed, 0, 1);
		
	jumpKey = keyboard_check(ord("Z"));
		jumpKey = clamp(jumpKey, 0, 1);
		
	dashKey = keyboard_check_pressed(ord("X"))
		
	//jumpKey buffering
	if jumpKeyPressed 
	{
		jumpKeyBufferTimer = bufferTime;
	}
	if jumpKeyBufferTimer > 0
	{
		jumpKeyBuffered = 1;
		jumpKeyBufferTimer--;
	}
	else
	{
		jumpKeyBuffered = 0;
	}
}

function getControlsMenu()
{
	//menú
	downKey = keyboard_check_pressed(vk_down);
	upKey = keyboard_check_pressed(vk_up);
	acceptKey = keyboard_check_pressed(vk_space);	
	
}