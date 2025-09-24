/// @function draw_level_up_window()
/// @description Рисует окно с поздравлением о новом уровне и списком наград.
function draw_level_up_window() {
    
    // --- 1. Получаем данные из контекста, который сохранил bus_handler ---
    var _context = current_context_id;
    var _new_level = _context.new_level;
    var _unlocks = _context.unlocks;
    
    // --- 2. Рисуем фон и плашку окна (стандартная процедура) ---
    var _gui_w = display_get_gui_width();
    var _gui_h = display_get_gui_height();
    
    draw_set_color(c_black);
    draw_set_alpha(0.7);
    draw_rectangle(0, 0, _gui_w, _gui_h, false);
    draw_set_alpha(1.0);
    
    var _win_width = 800 * window_scale;
    var _win_height = 600 * window_scale; // Окно может быть не таким высоким, как магазин
    var _win_x = (_gui_w - _win_width) / 2;
    var _win_y = (_gui_h - _win_height) / 2;
    draw_set_color(c_dkgray);
    draw_rectangle(_win_x, _win_y, _win_x + _win_width, _win_y + _win_height, false);
    
    // --- 3. Рисуем контент ---
    draw_set_color(c_white);
    draw_set_halign(fa_center);
    draw_set_valign(fa_top); // Выравниваем по верху для удобства работы со списком
    
    // Заголовок
    draw_text(_win_x + _win_width / 2, _win_y + 50 * window_scale, "Поздравляем!");
    draw_text(_win_x + _win_width / 2, _win_y + 100 * window_scale, "Вы достигли " + string(_new_level) + " уровня!");
    
    // Список наград (рисуем в цикле)
    if (array_length(_unlocks) > 0) {
        draw_set_halign(fa_left); // Для списка лучше выравнивание по левому краю
        var _list_y_start = _win_y + 200;
        
        for (var i = 0; i < array_length(_unlocks); i++) {
            var _unlock_text = "- " + _unlocks[i];
            draw_text(_win_x + 80, _list_y_start + (i * 50), _unlock_text);
        }
    }
    
    // --- 4. Рисуем кнопку "Продолжить" ---
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    
    var _btn_x = _win_x + _win_width / 2;
    var _btn_y = _win_y + _win_height - 80 * window_scale;
    draw_set_color(c_green);
    draw_rectangle(_btn_x - 150, _btn_y - 40, _btn_x + 150, _btn_y + 40, false);
    draw_set_color(c_white);
    draw_text(_btn_x, _btn_y, "Продолжить");
    
    // Сброс настроек
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}