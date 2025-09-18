if (dragged_sprite != noone) {
    var _mx = device_mouse_x_to_gui(0);
    var _my = device_mouse_y_to_gui(0);
    
    // Просто рисуем спрайт, который у нас "в руке"
    draw_sprite(dragged_sprite, 0, _mx, _my);
}