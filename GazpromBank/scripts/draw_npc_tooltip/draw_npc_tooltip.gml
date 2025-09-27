// --- obj_ui_manager: Create Event (или отдельный скрипт) ---

/// @function draw_npc_tooltip()
/// @description Рисует окно подсказки от NPC, если он активен.
function draw_npc_tooltip() {
    // --- Рисуем заглушку для персонажа ---
    // (Простой синий круг в левом нижнем углу)
    var _gui_w = display_get_gui_width() ;
    var _gui_h = display_get_gui_height();	
	
	draw_sprite_ext(spr_ico_helper, -1, 115, _gui_h  - 150 * window_scale, 1/2, 1/2, 0, c_white, 1)
	draw_sprite_ext(spr_text_background, -1, 600, _gui_h - 300 * window_scale, 1/2, 1/2, 0, c_white, 1)

    
    // 1. Устанавливаем общие параметры текста
    draw_set_color(c_black);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_set_font(fnt_main_normal);
    
    var _text_x = 600 - sprite_get_width(spr_text_background)/4 + 100;
    var _text_y = _gui_h - 300 - sprite_get_height(spr_text_background)/4 + 20;
    
	
	
	var _text_string = string_join_ext("", tooltip_array_to_show, 0, tooltip_array_size)
	//var _text_string = string_split(_text_string, " ")
	
	
    // 2. Рисуем основную, уже видимую часть текста
    //draw_text(_text_x, _text_y, _text_string);
	draw_text_ext(_text_x + 15, _text_y + 10, _text_string, 60, sprite_get_width(spr_text_background)/2 - 40)
    
    // --- Сброс настроек (не меняется) ---
    draw_set_color(c_white);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    
}

/*
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

	draw_set_font(fnt_main_normal_big)
    draw_text(_tooltip_x1 + 20, _tooltip_y1 + 20, _text_to_draw);
    
    // Сброс настроек
    draw_set_color(c_white);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}