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

//fijar donde está la camara al iniciar la sala
finalCamX = _camX
finalCamY = _camY