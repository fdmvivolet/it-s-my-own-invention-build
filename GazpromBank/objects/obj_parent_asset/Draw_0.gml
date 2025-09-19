// --- obj_parent_asset: Draw Event (ИСПРАВЛЕННАЯ ВЕРСИЯ) ---
/// @description Отрисовка актива, прогресс-бара и индикатора готовности

// 1. Рисуем основной спрайт объекта
draw_self();

// 2. ОТРИСОВКА ПРОГРЕСС-БАРА
if (timer_current > 0 && !is_ready_to_collect) {
    
    var _time_elapsed = base_timer_seconds - timer_current;
    var _progress_percent = (_time_elapsed / base_timer_seconds) * 100;
    
    var _bar_width = sprite_get_width(sprite_index);
    var _bar_height = 16;
    
    var _bar_x1 = x - _bar_width / 2;
    var _bar_y1 = bbox_bottom + 8;
    
    var _bar_x2 = x + _bar_width / 2;
    var _bar_y2 = _bar_y1 + _bar_height;
    
    // --- ИЗМЕНЕНИЕ ЗДЕСЬ ---
    // Теперь min и max цвета одинаковые. Градиента не будет.
    draw_healthbar(
        _bar_x1, _bar_y1,
        _bar_x2, _bar_y2,
        _progress_percent,
        c_black,  // Цвет фона
        c_lime,   // Цвет бара на 0%
        c_lime,   // Цвет бара на 100% (ТЕПЕРЬ ТАКОЙ ЖЕ!)
        0,
        true,
        true
    );
}

// 3. ОТРИСОВКА ИНДИКАТОРА ГОТОВНОСТИ
if (is_ready_to_collect) {
    draw_set_color(c_yellow);
    draw_circle(x, y, sprite_width/2+2, false);
    draw_set_color(c_white);
}

//draw_text(x+25, y-150, is_ready_to_collect)
//draw_text(x-25, y-50, timer_current)