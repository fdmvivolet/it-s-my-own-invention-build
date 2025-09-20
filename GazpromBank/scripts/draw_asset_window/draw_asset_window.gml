/// @function draw_asset_window()
/// @description Отрисовывает модальное окно с информацией об активе.
function draw_asset_window() {
    
    // --- 1. ПОЛУЧАЕМ ДАННЫЕ ---
    // current_context_id хранит ID актива, для которого открыто окно.
    var _asset_id = obj_ui_manager.current_context_id;
    
	
    // Проверка на случай, если актив был удален, пока окно открыто
    if (!instance_exists(_asset_id)) {
        // Просто закрываем окно
        obj_ui_manager.current_ui_state = UIState.HIDDEN; //НИХУА НЕ РАБОТЕТ :(
        obj_game_manager.game_state = GameState.GAMEPLAY;
        return;
    }
    
    // Считываем все нужные данные с актива
    var _asset_name = object_get_name(_asset_id.object_index); // Покажет "obj_savings_account"
    var _asset_level = _asset_id.level;
    var _asset_income = _asset_id.base_income;
    var _time_left = ceil(_asset_id.timer_current);
	var _upgrade_cost = _asset_id.upgrade_cost;
	
    // --- 2. ОТРИСОВКА ФОНА И ОКНА ---
    // Получаем размеры UI-холста
    var _gui_w = display_get_gui_width();
    var _gui_h = display_get_gui_height();
    
    // Рисуем полупрозрачный черный фон, чтобы затемнить игру
    draw_set_color(c_black);
    draw_set_alpha(0.7);
    draw_rectangle(0, 0, _gui_w, _gui_h, false);
    draw_set_alpha(1); // Возвращаем полную непрозрачность
    
    // Рисуем сам фон окна (пока что простой серый прямоугольник)
    var _win_width = 800;
    var _win_height = 1000;
    var _win_x = (_gui_w - _win_width) / 2;
    var _win_y = (_gui_h - _win_height) / 2;
    draw_set_color(c_dkgray);
    draw_rectangle(_win_x, _win_y, _win_x + _win_width, _win_y + _win_height, false);
    
    // --- 3. ОТРИСОВКА ТЕКСТА ---
    draw_set_color(c_white);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    
    // Название (убираем "obj_" для красоты)
    draw_text(_win_x + _win_width / 2, _win_y + 100, string_replace(_asset_name, "obj_", ""));
    
    // Информация
    draw_text(_win_x + _win_width / 2, _win_y + 300, "Уровень: " + string(_asset_level));
    draw_text(_win_x + _win_width / 2, _win_y + 400, "Доход: " + string(_asset_income));
    draw_text(_win_x + _win_width / 2, _win_y + 500, "Готов через: " + string(_time_left) + " сек.");
    
    // --- 4. ОТРИСОВКА КНОПОК (ПОКА ЗАГЛУШКИ) ---
    // Кнопка "Улучшить"
    var _btn_upgrade_x = _win_x + _win_width / 2;
    var _btn_upgrade_y = _win_y + 700;
	
	var _can_afford = global.game_data.player_coins >= _upgrade_cost;
	draw_set_color(_can_afford ? c_green : c_gray); // Тернарный оператор для выбора цвета

	draw_rectangle(_btn_upgrade_x - 200, _btn_upgrade_y - 50, _btn_upgrade_x + 200, _btn_upgrade_y + 50, false);
	draw_set_color(c_white);
	draw_text(_btn_upgrade_x, _btn_upgrade_y, "Улучшить (" + string(_upgrade_cost) + ")");
    
    // Кнопка "Закрыть"
    var _btn_close_x = _win_x + _win_width / 2;
    var _btn_close_y = _win_y + 850;
    draw_set_color(c_red);
    draw_rectangle(_btn_close_x - 200, _btn_close_y - 50, _btn_close_x + 200, _btn_close_y + 50, false);
    draw_set_color(c_white);
    draw_text(_btn_close_x, _btn_close_y, "Закрыть");
    
    // Сбрасываем выравнивание
    draw_set_halign(fa_left);
}


function draw_shop_window() {
    // --- 1. ОТРИСОВКА ФОНА И ОКНА ---
    var _gui_w = display_get_gui_width();
    var _gui_h = display_get_gui_height();
    
    // Затемняющий фон
    draw_set_color(c_black);
    draw_set_alpha(0.7);
    draw_rectangle(0, 0, _gui_w, _gui_h, false);
    draw_set_alpha(1);
    
    // Фон окна
    var _win_width = 800;
    var _win_height = 1000;
    var _win_x = (_gui_w - _win_width) / 2;
    var _win_y = (_gui_h - _win_height) / 2;
    draw_set_color(c_dkgray);
    draw_rectangle(_win_x, _win_y, _win_x + _win_width, _win_y + _win_height, false);
    
    // --- 2. ОТРИСОВКА КОНТЕНТА ---
    draw_set_color(c_white);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    
    // Заголовок
    draw_text(_win_x + _win_width / 2, _win_y + 100, "Магазин");
    
    // --- 3. ОТРИСОВКА ТОВАРОВ (пока только один) ---
    var _item_y = _win_y + 300;
    draw_text(_win_x + 200, _item_y, "Накопительный счет");
    
    // Кнопка "Купить"
    var _cost = global.game_config.assets.savings_account.cost;
    draw_set_color(c_green);
    draw_rectangle(_win_x + 550, _item_y - 50, _win_x + 750, _item_y + 50, false);
    draw_set_color(c_white);
    draw_text(_win_x + 650, _item_y, "Купить (" + string(_cost) + ")");
    
    // Кнопка "Закрыть" (временно внизу)
    draw_set_color(c_red);
    draw_rectangle(_win_x + _win_width/2 - 100, _win_y + 850, _win_x + _win_width/2 + 100, _win_y + 950, false);
    draw_set_color(c_white);
    draw_text(_win_x + _win_width/2, _win_y + 900, "Закрыть");
    
    draw_set_halign(fa_left);
}