// --- obj_tile: Draw Event ---
/// @description Отрисовка ячейки и подсветки при наведении

// is_hovered наследуется от obj_parent_clickable и управляется нашей системой ввода
if (is_hovered) {
    // Рисуем спрайт с небольшой альфой (полупрозрачностью) 
	//draw_set_alpha(0.7)
	draw_sprite_ext(sprite_index, -1, x, y, 1, 1, 0, c_white, 0.7)
} else {
    // Рисуем спрайт как обычно
    //draw_set_alpha(1)
	draw_self();
}
draw_set_font(Font1)
draw_text(x, y, tile_id)