// --- obj_tile: Draw Event ---
/// @description Отрисовка ячейки и подсветки при наведении

// is_hovered наследуется от obj_parent_clickable и управляется нашей системой ввода
if (is_hovered) {
    // Рисуем спрайт с небольшой альфой (полупрозрачностью) 
	draw_self()
	draw_set_alpha(0.7)
} else {
    // Рисуем спрайт как обычно
    draw_self();
	draw_set_alpha(1)
}