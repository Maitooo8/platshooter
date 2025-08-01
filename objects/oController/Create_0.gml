//fuente
global.font_main = font_add_sprite(sFont,32,true, 1);

// Inicializar variables globales de checkpoint
global.checkpoint_active = false;
global.checkpoint_x = 0;
global.checkpoint_y = 0;

global.from_death = false; // Por defecto, no viene de una muerte