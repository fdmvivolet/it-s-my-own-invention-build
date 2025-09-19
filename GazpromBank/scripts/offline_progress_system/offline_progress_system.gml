// --- Script: offline_progress_system.gml (С РЕАЛЬНЫМ ВРЕМЕНЕМ) ---

#macro SECONDS_IN_MINUTE 60
#macro MINIMUM_OFFLINE_SECONDS 5

function calculate_offline_progress() {
    if (!variable_struct_exists(global.game_data, "last_save_timestamp") || global.game_data.last_save_timestamp == 0) {
        return;
    }
    
    // --- ИЗМЕНЕНИЕ ЗДЕСЬ ---
    // 1. Получаем текущую системную дату и время
    var _current_datetime = date_current_datetime();
	
    // 2. Вычисляем разницу в секундах между двумя датами.
    // Это самый надежный способ.
    var _time_offline = date_second_span(global.game_data.last_save_timestamp, _current_datetime);
    
	show_debug_message("ориг время: " + string(global.game_data.last_save_timestamp) + "\nновое: " 
	+ string(_current_datetime) + "\nразница: " + string(_time_offline))
	
    if (_time_offline < MINIMUM_OFFLINE_SECONDS) {
        // ... (код для "промотки" таймеров, если прошло мало времени, остается тем же) ...
		//show_message("123")
        return;
    }
    
    var _saved_assets = global.game_data.assets_on_tiles;
    for (var i = 0; i < array_length(_saved_assets); i++) {
        var _asset_data = _saved_assets[i];
        
        if (_asset_data != noone) {
            _asset_data.timer_current -= _time_offline;
            
            if (_asset_data.timer_current < 0) {
                _asset_data.timer_current = -1;
            }
        }
    }
    
    show_debug_message("Добро пожаловать обратно!");
}