// --- obj_tile: User Event 0 (OnTap) ---
/// @description Обработка тапа: отправляем запрос в UI-систему

if (is_empty) {
    // Я ПРОШУ открыть окно магазина для СЕБЯ
    var _event_data = { tile_id: id };
	//show_message("nu")
    EventBusBroadcast("RequestShopWindow", _event_data);
} else {
    // Если на мне есть актив, я ПРОШУ открыть окно для НЕГО
    if (instance_exists(asset_instance_id)) {
        
        // --- Логика "быстрого сбора" ---
        // Если актив готов, мы не открываем окно, а сразу собираем доход.
        // Это улучшает UX (пользовательский опыт).
        if (asset_instance_id.is_ready_to_collect) {
            with (asset_instance_id) {
                event_user(0); // Вызываем OnTap самого актива
            }
        } else {
            // Если актив НЕ готов, вот тогда мы просим открыть его окно
            var _event_data = { asset_id: asset_instance_id };
            EventBusBroadcast("RequestAssetWindow", _event_data);
        }
    }
}