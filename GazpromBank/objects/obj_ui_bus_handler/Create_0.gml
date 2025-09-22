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

// --- НОВЫЕ МЕТОДЫ ДЛЯ СИСТЕМЫ ПОДСКАЗОК ---

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



// --- 3. ПОДПИСКА на события от игрового мира ---
// Теперь, когда функции объявлены, мы можем безопасно на них подписаться.
EventBusSubscribe("RequestShopWindow", id, on_request_shop_window);
EventBusSubscribe("RequestAssetWindow", id, on_request_asset_window);
EventBusSubscribe("RequestQuestsWindow", id, on_request_quests_window);

// --- НОВЫЙ БЛОК: ПОДПИСКИ ДЛЯ СИСТЕМЫ ПОДСКАЗОК ---

show_debug_message("UI Bus Handler: Подписка на триггеры обучения...");

// Подписываемся на игровой триггер, который запускает обучение.
// Метод on_tutorial_trigger мы создадим на следующем шаге.
EventBusSubscribe("FirstAssetPurchased", id, on_tutorial_trigger);

// Подписываемся на служебное событие, которое сообщает, что UI освободился.
// Метод on_ui_window_closed мы тоже создадим.
EventBusSubscribe("UIWindowClosed", id, on_ui_window_closed);