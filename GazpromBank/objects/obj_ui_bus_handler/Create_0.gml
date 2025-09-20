/// @description Слушает UI-запросы и отложенно передает их UI-менеджеру.

// --- 2. ОБЪЯВЛЕНИЕ функций-обработчиков событий (Callbacks) ---
// Мы должны сначала объявить функции, и только потом их использовать.

//var ui_id = obj_ui_manager.id

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

// --- 3. ПОДПИСКА на события от игрового мира ---
// Теперь, когда функции объявлены, мы можем безопасно на них подписаться.
EventBusSubscribe("RequestShopWindow", id, on_request_shop_window);
EventBusSubscribe("RequestAssetWindow", id, on_request_asset_window);