//revisar si hay un spawnpoint
var sp = instance_find(oSpawnPoint, 0);

//si existe un spawnpoint, mover al jugador ahí
if (global.from_death && global.checkpoint_active) 
{
	//al morir, spawnear en un checkpoint
	x = global.checkpoint_x;
	y = global.checkpoint_y;
} 
else 
{
	//si es la primera vez que se entra a la sala, usar el spawnpoint
	var sp = instance_find(oSpawnPoint, 0);
	if (sp != noone) 
	{
		x = sp.x;
		y = sp.y;
	}
}

//resetear si morimos para el proximo uso
global.from_death = false;

//PARA RESETEAR AL IR A OTRA SALA, PONER ANTES DEL CODIGO DE TRANSICIÓN
//global.checkpoint_active = false;

