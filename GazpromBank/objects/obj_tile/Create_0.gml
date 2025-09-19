// --- obj_tile: Create Event ---
/// @description Инициализация ячейки

// Наследуем is_hovered и is_tapped от родителя
event_inherited();

sprite_index = spr_tile_temp;

// --- Состояние ячейки ---
is_empty = true;        // Ячейка изначально пуста
asset_instance_id = noone; // На ней нет актива

tile_id = -1; // -1 означает "неинициализированный"