//fullscreen toggle
if keyboard_check_pressed(vk_f11)
{
	window_set_fullscreen( !window_get_fullscreen());
}

//salir si no hay jugador
if !instance_exists(oJugador) exit;

//conseguir tamaño de la camara
var _camWidth = camera_get_view_width(view_camera[0]);
var _camHeight = camera_get_view_height(view_camera[0]);

//conseguir a donde va la camara
var _camX = oJugador.x - _camWidth/2;
var _camY = oJugador.y - _camHeight/2;

//limitar camara a los bordes de la sala
_camX = clamp(_camX, 0, room_width - _camWidth)
_camY = clamp(_camY, 0, room_height - _camHeight)

//set cam coordinate variables
finalCamX = _camX;
finalCamY += (_camY - finalCamY) * camTrailSpd;


//marcar cordenadas de la camara
camera_set_view_pos(view_camera[0], finalCamX, finalCamY);