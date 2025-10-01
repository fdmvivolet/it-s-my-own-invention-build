// --- obj_ui_manager: Create Event (или отдельный скрипт) ---

/// @function draw_npc_tooltip()
/// @description Рисует окно подсказки от NPC, если он активен.
function draw_npc_tooltip() {
    // --- Рисуем заглушку для персонажа ---
    // (Простой синий круг в левом нижнем углу)
    var _gui_w = display_get_gui_width() ;
    var _gui_h = display_get_gui_height();	
	

    
    // 1. Устанавливаем общие параметры текста
    draw_set_color(c_black);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_set_font(fnt_main_normal);
    
    var _text_x = 600 - sprite_get_width(spr_text_background)/4 + 100;
    var _text_y = _gui_h - 300 * window_scale - sprite_get_height(spr_text_background)/4 + 20;
    
	
	
	var _text_string = string_join_ext("", tooltip_array_to_show, 0, tooltip_array_size)
	//var _text_string = string_split(_text_string, " ")
	
	
    // 2. Рисуем основную, уже видимую часть текста
    //draw_text(_text_x, _text_y, _text_string);
	if string_pos(ZWSP, _text_string){ _text_string = string_replace(_text_string, ZWSP, "") }
	
	//draw_text_ext(_text_x + 15, _text_y + 10, _text_string, 60, sprite_get_width(spr_text_background)/2 - 40)

	// --- Сброс настроек (не меняется) ---
    draw_set_color(c_white);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    
	draw_set_halign(fa_center)
	draw_set_valign(fa_middle)
	var _title_x = 640
	var _title_y = _gui_h - 430 * window_scale
	draw_set_font(fnt_main_bold)
	if !string_pos(ZWSP, tooltip_message_to_show) {
		draw_sprite_ext(spr_ico_helper, -1, 115, _gui_h  - 150 * window_scale, 1/2, 1/2, 0, c_white, 1)
		draw_sprite_ext(spr_call_window, -1, 600, _gui_h - 300 * window_scale, 1/2, 1/2, 0, c_white, 1)	
		draw_text(_title_x, _title_y, "Финансовый помощник")
	}else{
		draw_sprite_ext(spr_ico_scamer, -1, 115, _gui_h  - 150 * window_scale, 1/2, 1/2, 0, c_white, 1)
		draw_sprite_ext(spr_call_window, -1, 600, _gui_h - 300 * window_scale, 1/2, 1/2, 0, c_white, 1)		
		draw_text(_title_x, _title_y, "Служба Безопасности Банка")
	}//_text_string
	

	//draw_sprite_ext(spr_text_background, -1, 600, _gui_h - 300 * window_scale, 1/2, 1/2, 0, c_white, 1)
    draw_set_color(c_black);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);

	draw_set_font(fnt_main_bold_cloud)
    draw_text(_text_x + 15, _text_y + 35, _text_string)
	draw_set_font(fnt_main_normal)

}

function draw_choices_buttons(){
	var window_scale = obj_ui_manager.window_scale
	//obj_ui_manager.window_scale = 1
	
	show_debug_message(window_scale)
    var _gui_w = display_get_gui_width() ;
    var _gui_h = display_get_gui_height();	
	
	var _call_w_x = 600
	var _call_w_y = _gui_h - 350// * window_scale
	
	draw_sprite_ext(spr_ico_scamer, -1, 115, _gui_h  - 150 * window_scale, 1/2, 1/2, 0, c_white, 1)
	//draw_sprite_ext(spr_call_window, -1, _call_w_x, _call_w_y, 1/2, 1/2, 0, c_white, 1)
	draw_sprite_ext(spr_call_window, -1, 600, _gui_h - 300 * window_scale, 1/2, 1/2, 0, c_white, 1)
	
	var _choices = choices_buttons 

	draw_set_halign(fa_center)
	draw_set_valign(fa_middle)
	var _title_x = 640
	var _title_y = _gui_h - 430 //* window_scale
	draw_text(_title_x, _title_y - 300 * window_scale + 300, current_context_data.title)

	//show_debug_message(_choices)
	//show_debug_message(typeof(_choices))
	
	for (var i = 0; i < 2; i++){
		
		draw_sprite_ext(_choices[i].sprite_index, -1, _choices[i].x_pos, _choices[i].y_pos - 300 * window_scale + 300 , 
		_choices[i].current_scale * window_scale * 1/2,
		_choices[i].current_scale * window_scale * 1/2, 0, c_white, 1)
		//show_message("draw xy " + string(_choices[i].x_pos) + " " + string(_choices[i].y_pos))

		
		var _choices_text = current_context_data.options[i].text
		draw_set_font(fnt_main_bold)
		draw_text(_choices[i].x_pos, _choices[i].y_pos - 300 * window_scale + 300, _choices_text)
		//draw_set_font(fnt_main_normal)

	}
	draw_set_halign(fa_left)
	draw_set_valign(fa_top)
}

function create_choices_buttons(){
	//obj_ui_manager.choices_buttons = 
	array_delete(obj_ui_manager.choices_buttons, 0, 2);
	//obj_ui_manager.window_scale = 0.8
	var window_scale = obj_ui_manager.window_scale
	
    var _gui_w = display_get_gui_width() ;
    var _gui_h = display_get_gui_height();	
	
	var _call_w_x = 640
	var _call_w_y = _gui_h - 270 //* window_scale// * window_scale
	
	//draw_sprite_ext(spr_ico_helper, -1, 115, _gui_h  - 150 * window_scale, 1/2, 1/2, 0, c_white, 1)
	//draw_sprite_ext(spr_call_window, -1, _call_w_x, _call_w_y, 1/2, 1/2, 0, c_white, 1)
	
	//var _choice_ids = variable_struct_get_names(global.game_config.choices);
	
	var _current_choice_id = obj_ui_manager.current_context_data
	
	var _buttons_num = array_length(_current_choice_id.options)
	
	//show_debug_message(_current_choice_id)
	
	var spr_ind_one = spr_call_next
	var spr_ind_two = spr_call_next
	
	
	if _current_choice_id.type == "GREEN_RED_CHOICE"
	{
		spr_ind_one = spr_call_decline
		spr_ind_two = spr_call_accept
	}
	
	var _callback = [-1, -1]//function() {TUTORIAL_CLOSE_ANIMATION}
	
	for (var i = 0; i < 2; i++)
	{
		if _current_choice_id.options[i].action != "CONTINUE"
		{
			var _name = _current_choice_id.options[i].action
			_callback[i] = method({ name: _name,}, function() { 
				//
				trigger_one_time_event(name, {tutorial_id: name})
				audio_stop_sound(global.fraud_audio_id)
				audio_stop_sound(global.heartbeat_id)
				audio_group_set_gain(audiogroup_default, 1, 300)
				if name == "FraudCallAftermathSuccess" {
					add_earnings_and_check_level(150)
					audio_stop_sound(global.heartbeat_id)
					audio_group_set_gain(audiogroup_default, 1, 300)
					
				}else if name == "FraudCallAftermathFail" {
					global.game_data.player_coins = 600
					audio_stop_sound(global.heartbeat_id)
					audio_group_set_gain(audiogroup_default, 1, 300)
					}
				
				})		
		}
		else
		_callback[i] = function() {TUTORIAL_CLOSE_ANIMATION; audio_stop_sound(global.fraud_audio_id)}
	}
	
	var _button_scale_idle = 1.0;
	var _button_scale_hover = 1.0; 
	var _button_scale_pressed = 0.9;	
	
	array_push(obj_ui_manager.choices_buttons, {
		x_pos: _call_w_x, 
		y_pos: _call_w_y - 50, 
		sprite_index: spr_ind_one,
		state: ButtonState.IDLE,
		callback: _callback[0],
		scale_idle: _button_scale_idle,
		scale_hover: _button_scale_hover,
		scale_pressed: _button_scale_pressed,
		current_scale: _button_scale_idle 
	});	
	
	array_push(obj_ui_manager.choices_buttons, {
		x_pos: _call_w_x, 
		y_pos: _call_w_y + 50, 
		sprite_index: spr_ind_two,
		state: ButtonState.IDLE,
		callback: _callback[1],
		scale_idle: _button_scale_idle,
		scale_hover: _button_scale_hover,
		scale_pressed: _button_scale_pressed,
		current_scale: _button_scale_idle 
	});		
	
	//show_message("create xy " + string(_call_w_x) +  " " + string(_call_w_y))	

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