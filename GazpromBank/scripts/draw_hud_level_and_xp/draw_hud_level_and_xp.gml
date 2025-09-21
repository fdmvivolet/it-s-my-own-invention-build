/// @function draw_hud_level_and_xp()
/// @description Рисует уровень игрока и полоску опыта в HUD.
function draw_hud_level_and_xp() {
    
    // --- Константы для настройки ---
    var _hud_padding_top = 120; // Отступ сверху, чтобы было ниже монет
    var _hud_padding_left = 48; // Такой же отступ слева, как у монет
    var _bar_width = 300;       // Общая ширина полоски опыта
    var _bar_height = 28;       // Высота полоски опыта
    var _text_offset_y = -32;   // Смещение текста "Уровень" над полоской
    
    // --- Получаем данные из глобальных структур ---
    var _level = global.game_data.player_level;
    var _current_xp = global.game_data.player_xp;
    
    // --- Логика расчета опыта (согласно нашему обсуждению) ---
    // Простая формула-заглушка: 100 XP для 1->2, 200 XP для 2->3 и т.д.
    // В будущем это будет вынесено в game_config или специальную функцию.
    var _xp_for_next_level = _level * 100; 
    
    // Рассчитываем прогресс в диапазоне от 0 до 1.
    // `max(0, ...)` и `min(1, ...)` нужны для защиты от некорректных данных (например, XP > необходимого).
    var _progress = clamp(_current_xp / _xp_for_next_level, 0, 1);
    
    // --- Позиционирование ---
    var _bar_x = _hud_padding_left;
    var _bar_y = _hud_padding_top;
    var _text_x = _bar_x;
    var _text_y = _bar_y + _text_offset_y;
    
    // --- Отрисовка ---
    
    // 1. Рисуем текст уровня
    draw_set_halign(fa_left);
    draw_set_valign(fa_middle);
    draw_text(_text_x, _text_y, "Уровень: " + string(_level));
    
    // 2. Рисуем фон полоски опыта (заглушка - темно-серый прямоугольник)
    draw_set_color(c_dkgray);
    draw_rectangle(_bar_x, _bar_y, _bar_x + _bar_width, _bar_y + _bar_height, false);
    
    // 3. Рисуем заполнение полоски опыта (заглушка - фиолетовый прямоугольник)
    // Ширина заполнения зависит от нашего прогресса
    if (_progress > 0) { // Рисуем только если есть хоть какой-то прогресс
        draw_set_color(#6a0dad); // Фиолетовый цвет
        draw_rectangle(_bar_x, _bar_y, _bar_x + (_bar_width * _progress), _bar_y + _bar_height, false);
    }
    
    // Сброс настроек
    draw_set_color(c_white);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}