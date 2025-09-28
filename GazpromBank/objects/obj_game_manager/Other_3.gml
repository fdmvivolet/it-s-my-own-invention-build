/// @description Insert description here
// You can write your code in this editor
if (surface_exists(global.primitive_surface)) {
    surface_free(global.primitive_surface);
    show_debug_message("Game Manager: Поверхность 'primitive_surface' освобождена.");
}