// Buscar el primer spawnpoint
var sp = instance_find(oSpawnPoint, 0);

// Si existe al menos uno, mover al jugador ahí
if (global.from_death && global.checkpoint_active) {
    // Volver desde muerte: ir al último checkpoint
    x = global.checkpoint_x;
    y = global.checkpoint_y;
} else {
    // Primer ingreso a la sala: usar spawnpoint
    var sp = instance_find(oSpawnPoint, 0);
    if (sp != noone) {
        x = sp.x;
        y = sp.y;
    }
}

// Resetear la bandera de muerte para la próxima vez
global.from_death = false;


//PARA RESETEAR AL IR A OTRA SALA, PONER ANTES DEL CODIGO DE TRANSICIÓN
//global.checkpoint_active = false;

