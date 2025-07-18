//salir si no hay jugador
if !instance_exists(oJugador) exit;

//conseguir tamaño de la camara
var _camWidth = camera_get_view_width(view_camera[0]);

var _camHeight = camera_get_view_height(view_camera[0]);

//conseguir a donde va la camara
var _camX = oJugador.x - _camWidth/2
var _camY = oJugador.y - _camHeight/2

//marcar cordenadas de la camara
camera_set_view_pos(view_camera[0], _camX, _camY);