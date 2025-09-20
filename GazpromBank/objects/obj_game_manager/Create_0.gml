if (instance_number(object_index) > 1) {
    instance_destroy();
    exit;
}

init_game_config(); 

// Инициализируем машину состояний
game_state = GameState.LOADING;

show_debug_message("obj_game_manager: Инициализирован. Начальное состояние: LOADING.");

//загрузка
load_game(); 

calculate_offline_progress();

// Переходим в основную игровую комнату и меняем состояние
room_goto(rm_main_game);




show_debug_message("obj_game_manager: Переход в rm_game. Состояние изменено на GAMEPLAY.");

global.last_hovered_instance = noone;

show_debug_message("obj_game_manager: Система ввода инициализирована.");

//----------------------------------------------------------------------
// Определяем функцию, которая будет реагировать на тап по пустой ячейке
function on_empty_tile_tapped(_event_data) {
    var _tile_id = _event_data.tile_instance_id;
    
    // Проверяем, что ячейка все еще существует и она пуста
    if (instance_exists(_tile_id) and _tile_id.is_empty) {
        
        // В будущем здесь будет открываться Магазин.
        // Сейчас, для теста, мы сразу покупаем "Накопительный счет", если есть деньги.
        var _cost = global.game_config.assets.savings_account.cost;
        
        if (global.game_data.player_coins >= _cost) {
            // Списываем деньги
            global.game_data.player_coins -= _cost;
            show_debug_message("КУПЛЕНО: 'Накопительный счет' за " + string(_cost) + ". Остаток: " + string(global.game_data.player_coins));
            
            // Создаем актив на месте ячейки
            var _new_asset = instance_create_layer(_tile_id.x, _tile_id.y, "Instances", obj_savings_account);
            
            // Обновляем состояние ячейки
            _tile_id.is_empty = false;
            _tile_id.asset_instance_id = _new_asset;
            
            // Сохраняем игру после покупки
            save_game();
            
        } else {
            show_debug_message("НЕДОСТАТОЧНО СРЕДСТВ для покупки. Нужно: " + string(_cost));
            // В будущем можно показать уведомление игроку
        }
    }
}
////////////
function on_purchase_asset_requested(_event_data) {
    var _asset_key = _event_data.asset_type;
    var _tile_id = _event_data.tile_id;
    var _config = global.game_config.assets[$ _asset_key];
    var _cost = _config.cost;

    if (instance_exists(_tile_id) && _tile_id.is_empty && global.game_data.player_coins >= _cost) {
        global.game_data.player_coins -= _cost;

        var _asset_obj_index = asset_get_index("obj_" + _asset_key);
        var _new_asset = instance_create_layer(_tile_id.x, _tile_id.y, "Instances", _asset_obj_index);
        
        _tile_id.is_empty = false;
        _tile_id.asset_instance_id = _new_asset;
        
        save_game();
    }
}
EventBusSubscribe("PurchaseAssetRequested", id, on_purchase_asset_requested);
//////////////////
// Подписываем нашего менеджера на прослушивание события от ячеек
//EventBusSubscribe("EmptyTileTapped", id, on_empty_tile_tapped);

///show_debug_message("obj_game_manager: Подписан на событие 'EmptyTileTapped'.");

was_focused = true;