// --- obj_parent_asset: Step Event ---
/// @description Логика обратного отсчета таймера

// Если таймер запущен (больше или равен нулю) и еще не готов к сбору
if (timer_current >= 0 and !is_ready_to_collect) {
    // Уменьшаем таймер. delta_time обеспечивает плавный отсчет
    // независимо от FPS (кадров в секунду).
    timer_current -= delta_time / 1000000;
        
    // Вычисляем смещение по синусоиде. `sin()` возвращает значение от -1 до 1.
	if after_spawn_anim{
	    // Увеличиваем наш личный таймер
	    idle_anim_timer += idle_anim_speed;		
		
	    var _scale_offset = sin(idle_anim_timer + idle_anim_phase_offset) * idle_anim_magnitude;
    
	    // Применяем смещение к базовому масштабу 1.0
	    var _new_scale = 1.0 + _scale_offset;
    
	    // Применяем новый масштаб к объекту
	    image_xscale = _new_scale;
	    image_yscale = _new_scale;	
	}
    // Если таймер истек
    if (timer_current < 0) {
        timer_current = -1; // Останавливаем таймер
        is_ready_to_collect = true; // Готов к сбору
        image_xscale = 1
		image_yscale = 1
        // В будущем здесь можно будет опубликовать событие в шину
        // EventBusBroadcast("AssetReadyForCollection", { instance_id: id });
        show_debug_message("Актив " + string(id) + " готов к сбору!");
		
		var _duration = 0.6
		
        global.Animation.play(id, "image_xscale", 1.0, _duration, ac_bounce);
        global.Animation.play(id, "image_yscale", 1.0, _duration, ac_bounce);
        
        // 2. ЗАПУСКАЕМ ЦИКЛ ПУЛЬСАЦИИ
        // Взводим Alarm 1, который будет отвечать за ритм.
        // Запустится через 1 секунду после созревания.
        alarm[1] = game_get_speed(gamespeed_fps) * _duration;		
		
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