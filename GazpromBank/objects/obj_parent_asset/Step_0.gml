// --- obj_parent_asset: Step Event ---
/// @description Логика обратного отсчета таймера

// Если таймер запущен (больше или равен нулю) и еще не готов к сбору
if (timer_current >= 0 and !is_ready_to_collect) {
    // Уменьшаем таймер. delta_time обеспечивает плавный отсчет
    // независимо от FPS (кадров в секунду).
    timer_current -= delta_time / 1000000;
    
    // Если таймер истек
    if (timer_current < 0) {
        timer_current = -1; // Останавливаем таймер
        is_ready_to_collect = true; // Готов к сбору
        
        // В будущем здесь можно будет опубликовать событие в шину
        // EventBusBroadcast("AssetReadyForCollection", { instance_id: id });
        show_debug_message("Актив " + string(id) + " готов к сбору!");
    }
}
/*
if (timer_current < 0) {
    timer_current = -1; // Останавливаем таймер
    is_ready_to_collect = true; // Готов к сбору
        
    // В будущем здесь можно будет опубликовать событие в шину
    // EventBusBroadcast("AssetReadyForCollection", { instance_id: id });
    show_debug_message("Актив " + string(id) + " готов к сбору!");
}