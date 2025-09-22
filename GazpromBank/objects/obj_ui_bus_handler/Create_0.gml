/// @description Слушает UI-запросы и отложенно передает их UI-менеджеру.

// --- 2. ОБЪЯВЛЕНИЕ функций-обработчиков событий (Callbacks) ---
// Мы должны сначала объявить функции, и только потом их использовать.

//var ui_id = obj_ui_manager.id

message_queue = [];

function on_request_shop_window(_event_data) {
    show_debug_message("UI Manager: Получен запрос на открытие Магазина для ячейки " + string(_event_data.tile_id));
	obj_ui_manager.current_ui_state = UIState.SHOP_WINDOW;
    obj_ui_manager.current_context_id = _event_data.tile_id;
    obj_game_manager.game_state = GameState.SHOP_OPEN;
}

function on_request_asset_window(_event_data) {
    show_debug_message("UI Manager: Получен запрос на открытие Окна Актива для " + string(_event_data.asset_id));
    obj_ui_manager.current_ui_state = UIState.ASSET_WINDOW;
    obj_ui_manager.current_context_id = _event_data.asset_id;
    obj_game_manager.game_state = GameState.SHOP_OPEN;
}

// В obj_ui_manager, где объявлены другие методы-обработчики

function on_request_quests_window(_event_data) {
    show_debug_message("UI Manager: Получен запрос на открытие Окна Заданий");

    // Переключаем состояния, как и для других окон
    obj_ui_manager.current_ui_state = UIState.QUESTS_WINDOW;
    obj_ui_manager.current_context_id = noone; // Контекст не нужен
    obj_game_manager.game_state = GameState.SHOP_OPEN; // Или SHOP_OPEN, как вам удобнее
}


/*
// 1. Главный метод, который решает, показывать подсказку или ставить в очередь.
function show_tooltip(data) {
    // Проверяем, что UI свободен
    if (obj_ui_manager.current_ui_state == UIState.HIDDEN) {
        // UI свободен, можно показывать.
        show_debug_message("UI Bus Handler: Показ подсказки.");
        
        // Переключаем состояния и сохраняем текст
        obj_ui_manager.current_ui_state = UIState.TUTORIAL_CLOUD;
        obj_ui_manager.tooltip_message_to_show = data.message;
        obj_game_manager.game_state = GameState.SHOP_OPEN; // Блокируем мир
        
    } else {
        // UI занят, ставим сообщение в очередь.
        show_debug_message("UI Bus Handler: UI занят. Подсказка добавлена в очередь.");
        array_push(obj_ui_bus_handler.message_queue, data.message);
    }
}

// 2. Метод-триггер, который вызывается игровыми событиями (например, FirstAssetPurchased).
function on_tutorial_trigger(data) {
    show_debug_message("UI Bus Handler: Получен триггер обучения.");
    // Его единственная задача - передать данные в наш главный метод.
    obj_ui_bus_handler.show_tooltip(data);
}

// 3. Метод, который проверяет очередь, когда любое окно закрывается.
function on_ui_window_closed(data) {
    // Если UI освободился и в очереди что-то есть...
    if (array_length(obj_ui_bus_handler.message_queue) > 0) {
        show_debug_message("UI Bus Handler: UI освободился. Показ подсказки из очереди.");
        
        // ...берем самое старое сообщение...
        var _next_message = obj_ui_bus_handler.message_queue[0];
        array_delete(obj_ui_bus_handler.message_queue, 0, 1);
        
        // ...и пытаемся его показать через наш главный метод.
        obj_ui_bus_handler.show_tooltip({ message: _next_message });
    }
}
*/

tutorial_queue = [];

// МЕТОД №1: Главный метод, который ПОКАЗЫВАЕТ СЛЕДУЮЩИЙ ШАГ
function show_next_tutorial_step() {
	var bus_id = obj_ui_bus_handler.id
    // Проверяем два условия: есть ли что-то в очереди И свободен ли UI
    if (array_length(bus_id.tutorial_queue) > 0 && obj_ui_manager.current_ui_state == UIState.HIDDEN) {
        
        // Берем следующий шаг (самую первую реплику) из очереди
        var _next_step_message = bus_id.tutorial_queue[0];
        array_delete(bus_id.tutorial_queue, 0, 1); // И сразу удаляем ее из очереди
        
        show_debug_message("UI Bus Handler: Показ шага обучения: '" + _next_step_message + "'");
        
        // Отдаем команду UI Manager'у
        obj_ui_manager.current_ui_state = UIState.TUTORIAL_CLOUD;
        obj_ui_manager.tooltip_message_to_show = _next_step_message;
        obj_game_manager.game_state = GameState.SHOP_OPEN; // Блокируем мир
    }
}

// МЕТОД №2: Метод-триггер, который ЗАПУСКАЕТ целый сценарий
function on_tutorial_triggered(data) {
    var _tutorial_id = data.tutorial_id;
    
	var bus_id = obj_ui_bus_handler.id
	
    // Проверяем, есть ли такой сценарий в конфиге
    if (variable_struct_exists(global.game_config.tutorials, _tutorial_id)) {
        
        // Копируем ВЕСЬ массив реплик из конфига в нашу внутреннюю очередь

        //bus_id.tutorial_queue = array_clone(global.game_config.tutorials[$ _tutorial_id]);
		var _source_array = global.game_config.tutorials[$ _tutorial_id];
		//bus_id.tutorial_queue = _source_array
		array_copy(bus_id.tutorial_queue, 0, _source_array, 0, array_length(_source_array));
		show_debug_message("UI Bus Handler: Загружен сценарий '" + _tutorial_id + "' с " + string(array_length(bus_id.tutorial_queue)) + " шагами.");
        
        // Сразу же пытаемся показать ПЕРВЫЙ шаг
        bus_id.show_next_tutorial_step();
    }
}

// МЕТОД №3: Метод, который срабатывает, когда игрок закрывает одно облачко
function on_tooltip_acknowledged(data) {
    show_debug_message("UI Bus Handler: Шаг обучения подтвержден. Попытка показать следующий.");
    // Просто пытаемся показать СЛЕДУЮЩИЙ шаг из очереди
    obj_ui_bus_handler.show_next_tutorial_step();
}


// Подписываемся на универсальный триггер обучения от game_manager
EventBusSubscribe("TutorialTriggered", id, on_tutorial_triggered);

// Подписываемся на событие, которое ui_manager отправит при клике на облачко
EventBusSubscribe("TooltipAcknowledged", id, on_tooltip_acknowledged);

//////////////////////!!!!!!!!!!!!!!!!!!!!!!!!!!!!!new up

// --- 3. ПОДПИСКА на события от игрового мира ---
// Теперь, когда функции объявлены, мы можем безопасно на них подписаться.
EventBusSubscribe("RequestShopWindow", id, on_request_shop_window);
EventBusSubscribe("RequestAssetWindow", id, on_request_asset_window);
EventBusSubscribe("RequestQuestsWindow", id, on_request_quests_window);

// --- НОВЫЙ БЛОК: ПОДПИСКИ ДЛЯ СИСТЕМЫ ПОДСКАЗОК ---

show_debug_message("UI Bus Handler: Подписка на триггеры обучения...");

// Подписываемся на игровой триггер, который запускает обучение.
// Метод on_tutorial_trigger мы создадим на следующем шаге.
//EventBusSubscribe("FirstAssetPurchased", id, on_tutorial_trigger);

// Подписываемся на служебное событие, которое сообщает, что UI освободился.
// Метод on_ui_window_closed мы тоже создадим.
//EventBusSubscribe("UIWindowClosed", id, on_ui_window_closed);