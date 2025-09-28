// --- obj_tile: Create Event ---
/// @description Инициализация ячейки

// Наследуем is_hovered и is_tapped от родителя
event_inherited();

//sprite_index = spr_tile_temp;

// --- Состояние ячейки ---
is_empty = true;        // Ячейка изначально пуста
asset_instance_id = noone; // На ней нет актива

tile_id = -1; // -1 означает "неинициализированный"

is_locked = true;

/// @function update_lock_status()
/// @description Проверяет, должна ли ячейка быть заблокирована,
//               и обновляет ее состояние и спрайт.
function update_lock_status() {
    
    // 1. Главная логика: сравниваем ID ячейки с количеством разблокированных.
    // ID начинается с 0, а счетчик - с 1.
    // Поэтому ячейка с ID 0 должна быть открыта, когда счетчик >= 1.
    // Ячейка с ID 1 должна быть открыта, когда счетчик >= 2.
    // И так далее. Условие: tile_id < unlocked_tile_count
    
    var _should_be_locked = (tile_id >= global.game_data.unlocked_tile_count);
    
    //show_debug_message(tile_id)
    // 2. Если состояние изменилось, применяем эффекты.
    if (is_locked != _should_be_locked) {
        
        is_locked = _should_be_locked;
        show_debug_message("Tile " + string(tile_id) + ": Lock status changed to -> " + string(is_locked));
        
        if (is_locked) {
            // Ячейка заблокирована
            sprite_index = spr_tile_locked//spr_tile_temp_locked; // Меняем спрайт на "замок"
            // Можно добавить другие эффекты, например, image_alpha = 0.5
        } else {
            // Ячейка разблокирована
            sprite_index = spr_tile; // Меняем на обычный спрайт
            // Можно добавить эффект "появления", анимацию и т.д.
			alarm[1] = 1
        }
    }
}

// Метод - это функция, "привязанная" к конкретному экземпляру.
var on_level_up_callback = method(id, function(_data) {
    // Внутри этого метода `self` всегда будет правильно указывать
    // на тот экземпляр, который создал этот метод.
    
    // Вызываем метод обновления статуса для этого конкретного экземпляра
    self.update_lock_status();
});

show_debug_message("Tile " + string(id) + ": Подписка на 'PlayerLeveledUp'");
EventBusSubscribe("PlayerLeveledUp", id, on_level_up_callback);

alarm[0] = 1

white_scale = 0