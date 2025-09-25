// --- obj_ui_manager: Create Event (или отдельный скрипт) ---

/// @function draw_npc_tooltip()
/// @description Рисует окно подсказки от NPC, если он активен.
function draw_npc_tooltip(message_to_draw) {
    // --- Рисуем заглушку для персонажа ---
    // (Простой синий круг в левом нижнем углу)
	var radius = 80 * window_scale
    var _npc_x = 150;
    var _npc_y = display_get_gui_height() - 350;
    draw_set_color(c_blue);
    draw_circle(_npc_x, _npc_y, radius, false);
    
    // --- Рисуем заглушку для облачка с текстом ---
    // Теперь оно будет справа от NPC, а не над ним
    var _tooltip_x1 = _npc_x + 100;
    var _tooltip_y1 = _npc_y - (radius + 20) * window_scale; // Верхний край
    var _tooltip_x2 = display_get_gui_width() - 100;
    var _tooltip_y2 = _npc_y + radius; // Нижний край, теперь облако центрировано по Y
	
    draw_set_color(c_white);
    draw_rectangle(_tooltip_x1, _tooltip_y1, _tooltip_x2, _tooltip_y2, false);
    
    // --- Рисуем текст подсказки ---
    draw_set_color(c_black);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    // `string_wrap` автоматически переносит длинный текст на новые строки
    var _text_to_draw = string_wrap(message_to_draw, (_tooltip_x2 - _tooltip_x1) * 0.95);

	draw_set_font(fnt_main_normal)
    draw_text(_tooltip_x1 + 20, _tooltip_y1 + 20, _text_to_draw);
    
    // Сброс настроек
    draw_set_color(c_white);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}