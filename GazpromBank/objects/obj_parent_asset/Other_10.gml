// --- obj_parent_asset: User Event 0 (OnTap) (НОВАЯ ВЕРСИЯ) ---
/// @description Обработка тапа по активу: сбор дохода ИЛИ подготовка к улучшению.

// --- Если доход готов к сбору ---
if (is_ready_to_collect) {
    // 1. Собираем доход (эта часть остается без изменений)
    //global.game_data.player_coins += 
	add_earnings_and_check_level(base_income)//base_income;
    show_debug_message("СОБРАНО: " + string(base_income) + " монет! Всего: " + string(global.game_data.player_coins));
    
	obj_sound_manager.play_sfx("collect_income");
	
    var _vfx_count = 5; // Количество монеток
    
    var _target_gui_x = obj_ui_manager.hud_coins_target_x;
    var _target_gui_y = obj_ui_manager.hud_coins_target_y;	
	
	var _camera = view_camera[0];
	// Конвертируем X
	var _target_world_x = camera_get_view_x(_camera) + _target_gui_x;
	// Конвертируем Y
	var _target_world_y = camera_get_view_y(_camera) + _target_gui_y;			
	
    for (var i = 0; i < _vfx_count; i++) {
        
        // Создаем экземпляр "снаряда" в текущей позиции актива
        var _vfx_coin = instance_create_layer(x, y, "Instances", obj_vfx_coin);
		
        _vfx_coin.target_x = _target_world_x;
        _vfx_coin.target_y = _target_world_y;
       
        // --- ЗАПУСК АНИМАЦИИ ---
        // Анимируем X и Y до цели за случайное время, чтобы монетки летели не синхронно
        var _duration = random_range(0.5, 1); // от 0.4 до 0.7 секунд
        
        global.Animation.play(_vfx_coin, "x", _vfx_coin.target_x, _duration, ac_ease_out);
        global.Animation.play(_vfx_coin, "y", _vfx_coin.target_y, _duration, ac_ease_out);
        
        // Дополнительная "сочность": монетки могут исчезать по пути
        global.Animation.play(_vfx_coin, "image_alpha", 0, _duration + 0.1, ac_ease_out);
    }	
	alarm[1] = -1; 
	ease_out_click()
	EventBusBroadcast("IncomeCollected", {event_name: "IncomeCollected"});
	
    // 2. КЛЮЧЕВОЕ ИЗМЕНЕНИЕ: Сбрасываем состояние и АВТОМАТИЧЕСКИ перезапускаем таймер.
    // Мы больше НЕ УДАЛЯЕМ актив. Он продолжает работать.
    is_ready_to_collect = false;
    timer_current = base_timer_seconds;
    
    // 3. Сохраняем игру после важного действия
    save_game();
}
// --- Если доход НЕ готов ---
else {
    // В этом состоянии игрок может захотеть улучшить актив.
    // Сейчас мы просто выводим информацию. В будущем здесь будет
    // вызов Шины Событий для открытия окна улучшения.
    // EventBusBroadcast("UpgradeWindowRequested", { asset_id: id });
    ease_out_click()
    var _time_left = ceil(timer_current);
    show_debug_message("Актив в работе. До сбора дохода осталось: " + string(_time_left) + " сек.");
    show_debug_message("Текущий уровень: " + string(level) + ". Доход за цикл: " + string(base_income));
}