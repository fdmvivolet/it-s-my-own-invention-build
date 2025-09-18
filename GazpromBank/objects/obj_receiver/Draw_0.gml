// Сначала рисуем сам слот (его собственный спрайт)
draw_self();

// Если в слоте что-то лежит, рисуем это поверх
if (held_sprite != noone) {
    draw_sprite(held_sprite, 0, x, y);
}