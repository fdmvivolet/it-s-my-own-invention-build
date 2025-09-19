/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

// --- obj_tile: User Event 0 (OnTap) ---
/// @description Обработка тапа по ячейке

// --- Если ячейка пуста ---
if (is_empty) {
    // Ячейка не должна знать о магазине. Она просто сообщает всей игре,
    // что ее тапнули и ей нужна помощь. Для этого мы используем Шину Событий.
    show_debug_message("ПУСТАЯ ЯЧЕЙКА " + string(id) + ": Публикую событие 'EmptyTileTapped'");
    
    var _event_data = { tile_instance_id: id };
    EventBusBroadcast("EmptyTileTapped", _event_data);
    
}
// --- Если на ячейке есть актив ---
else {
    // Ячейка не должна решать, что делать с активом (собирать или улучшать).
    // Она просто "передает" тап самому активу, чтобы он решил сам.
    
    // Проверка на случай ошибки, чтобы игра не вылетела
    if (instance_exists(asset_instance_id)) {
        show_debug_message("ЯЧЕЙКА " + string(id) + ": Передаю тап активу " + string(asset_instance_id));
        
        // Вызываем событие OnTap (User Event 0) у нашего актива
        with (asset_instance_id) {
            event_perform(ev_other, ev_user0);
        }
    }
}