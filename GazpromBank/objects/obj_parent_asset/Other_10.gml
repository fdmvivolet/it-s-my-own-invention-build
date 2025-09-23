// --- obj_parent_asset: User Event 0 (OnTap) (НОВАЯ ВЕРСИЯ) ---
/// @description Обработка тапа по активу: сбор дохода ИЛИ подготовка к улучшению.

// --- Если доход готов к сбору ---
if (is_ready_to_collect) {
    // 1. Собираем доход (эта часть остается без изменений)
    //global.game_data.player_coins += 
	add_earnings_and_check_level(base_income)//base_income;
    show_debug_message("СОБРАНО: " + string(base_income) + " монет! Всего: " + string(global.game_data.player_coins));
    
	obj_sound_manager.play_sfx("collect_income");
	
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
    
    var _time_left = ceil(timer_current);
    show_debug_message("Актив в работе. До сбора дохода осталось: " + string(_time_left) + " сек.");
    show_debug_message("Текущий уровень: " + string(level) + ". Доход за цикл: " + string(base_income));
}