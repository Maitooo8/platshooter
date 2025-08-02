//si no está activo
if (!active) {
    //activar al chocar y marcar nuevo donde aparecemos
	active = true;
    global.checkpoint_x = x;
    global.checkpoint_y = y;
    global.checkpoint_active = true;
    image_index = 1;
	
//desactivar otros checkpoints
with (oCheckpoint) 
{
	if (id != other.id) 
		{
		active = false;
		image_index = 0;
		}
	}
}