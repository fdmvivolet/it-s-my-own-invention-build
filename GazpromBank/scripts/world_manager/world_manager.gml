// --- Script: world_manager.gml ---

/// @function world_init_tiles()
/// @description Находит все ячейки и присваивает им уникальный,
///              отсортированный по положению ID.
function world_init_tiles() {
    
    // 1. Получаем массив ВСЕХ элементов на слое
    var _all_elements = []//layer_get_all_elements("Tiles_Layer");
	
	var tile_num = instance_number(obj_tile)
	for (var i = 0; i < tile_num; i++){
		array_push(_all_elements, instance_find(obj_tile, i))	
	}

	show_debug_message(_all_elements)
    // 2. ФИЛЬТРАЦИЯ: Создаем НОВЫЙ массив, куда сложим только объекты
    /*var _tile_instances = [];
    for (var i = 0; i < array_length(_all_elements); i++) {
        var _element_id = _all_elements[i];
        // Проверяем, является ли текущий элемент настоящим объектом (instance)
        if (layer_get_element_type(_element_id) == layerelementtype_instance) {
            // Если да - добавляем его в наш "чистый" массив
            array_push(_tile_instances, instance_find(obj_tile, _element_id-1));
        }
    }
    */
    // 3. Сортируем "чистый" массив. Теперь здесь гарантированно только объекты.
    array_sort(_all_elements, function(inst1, inst2) {
        if (inst1.y != inst2.y) return inst1.y - inst2.y;
        return inst1.x - inst2.x;
    });
    
    // 4. Проходимся по отсортированному массиву и присваиваем ID
    for (var i = 0; i < array_length(_all_elements); i++) {
        var _tile_id = _all_elements[i];
        _tile_id.tile_id = i;
    }
    
    show_debug_message("Инициализация ячеек завершена. Найдено объектов: " + string(array_length(_all_elements)));
}



/// @function save_world_to_data()
/// @description Собирает данные со всех ячеек и активов в global.game_data.
function save_world_to_data() {
    // Очищаем старый массив данных об активах
    global.game_data.assets_on_tiles = array_create(10, noone);
    
    with (obj_tile) {
        if (!is_empty && instance_exists(asset_instance_id)) {
            var _asset = asset_instance_id;
            var _asset_data = {
                asset_type: object_get_name(_asset.object_index),
                level: _asset.level,
                timer_current: _asset.timer_current
            };
            global.game_data.assets_on_tiles[tile_id] = _asset_data;
        }
    }
}


/// @function load_world_from_data()
/// @description Воссоздает активы в комнате на основе global.game_data.
function load_world_from_data() {
    for (var i = 0; i < array_length(global.game_data.assets_on_tiles); i++) {
        var _asset_data = global.game_data.assets_on_tiles[i];
        
        if (_asset_data != noone) {
            var _tile = noone;
            with (obj_tile) {
                if (tile_id == i) {
                    _tile = id;
                    break;
                }
            }
            
            if (instance_exists(_tile)) {
                var _asset_type = asset_get_index(_asset_data.asset_type);
                var _new_asset = instance_create_layer(_tile.x, _tile.y, "Instances", _asset_type);
                
                _new_asset.level = _asset_data.level;
                _new_asset.timer_current = _asset_data.timer_current;
				
				if (_new_asset.timer_current < 0) {
                    _new_asset.is_ready_to_collect = true;
                }
                
                _tile.is_empty = false;
                _tile.asset_instance_id = _new_asset;
            }
        }
    }
    show_debug_message("Мир воссоздан из структуры данных.");
}