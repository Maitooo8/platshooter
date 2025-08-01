//dibujar jugador
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale*face, image_yscale, image_angle, image_blend, image_alpha);

/// @description Draw Collision Mask
    draw_set_color(c_red); // Set the drawing color (e.g., red for visibility)
    draw_set_alpha(0.5); // Set transparency for better visibility of the sprite underneath

    // Draw the bounding box of the collision mask
    draw_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, false);

    draw_set_alpha(1); // Reset alpha to default
    draw_set_color(c_white); // Reset color to default