// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function draw_settings_window(){
    var _gui_w = display_get_gui_width();
    var _gui_h = display_get_gui_height();
    
    var _sprite_back_index = spr_small_background
	var _win_width = sprite_get_width(_sprite_back_index)/2 * window_scale;
	var _win_height = sprite_get_height(_sprite_back_index)/2 * window_scale;
	
	var _win_x = _gui_w/2
	var _win_y = _gui_h/2
	
	draw_set_font(fnt_main_bold)
	draw_set_valign(fa_middle)
	draw_set_halign(fa_center)
	draw_set_color(c_white)
    draw_text(_win_x, _win_y - _win_height / 2 * 0.8, string_upper("Настройки"));
    draw_text(_win_x, _win_y + _win_height / 2 * 0.8, string_upper("Ваш уголок благополучия"));
    draw_set_font(fnt_main_normal_big)	
	
	var buttons = obj_ui_manager.settings_buttons
	
	var is_music = spr_button_nosound
	if audio_group_get_gain(audiogroup_default) != 0{
		is_music = spr_button_sound
	}
	
	var is_sfx = spr_button_nosound
	if audio_group_get_gain(sfx_group) != 0{
		is_sfx = spr_button_sound
	}	
	

		
	var _scale = buttons[0].current_scale
	draw_sprite_ext(is_music, -1, buttons[0].x_pos, buttons[0].y_pos, 1/2 * _scale, 1/2 * _scale, 0, c_white, 1)
	draw_sprite_ext(spr_ico_music, -1, buttons[0].x_pos, buttons[0].y_pos, 1/2 * _scale, 1/2 * _scale, 0, c_white, 1)
	if is_music == spr_button_nosound
	draw_sprite_ext(spr_ico_no, -1, buttons[0].x_pos, buttons[0].y_pos, 1/2 * _scale, 1/2 * _scale, 0, c_white, 1)
	
	
	_scale = buttons[1].current_scale
	draw_sprite_ext(is_sfx, -1, buttons[1].x_pos, buttons[1].y_pos, 1/2 * _scale, 1/2 * _scale, 0, c_white, 1)
	draw_sprite_ext(spr_ico_sfx, -1, buttons[1].x_pos, buttons[1].y_pos, 1/2 * _scale, 1/2 * _scale, 0, c_white, 1)
	if is_sfx == spr_button_nosound
	draw_sprite_ext(spr_ico_no, -1, buttons[1].x_pos, buttons[1].y_pos, 1/2 * _scale, 1/2 * _scale, 0, c_white, 1)	
	
}

function create_settings_buttons(){
	obj_ui_manager.settings_buttons = []
	
    var _gui_w = display_get_gui_width();
    var _gui_h = display_get_gui_height();
    
    var _sprite_back_index = spr_small_background
	var _win_width = sprite_get_width(_sprite_back_index)/2 * obj_ui_manager.window_scale;
	var _win_height = sprite_get_height(_sprite_back_index)/2 * obj_ui_manager.window_scale;
	
	var _win_x = _gui_w/2
	var _win_y = _gui_h/2
	
	
	
	
	var _button_scale_idle = 1.0;
	var _button_scale_hover = 1.0; // Сделаем чуть заметнее
	var _button_scale_pressed = 0.95;	
	
	array_push(obj_ui_manager.settings_buttons, {
	    x_pos: _win_x - _win_width / 2 * 0.5, 
	    y_pos: _win_y, 
		sprite_index: spr_button_nosound,
	    state: ButtonState.IDLE,
	    callback: function() {if audio_group_get_gain(audiogroup_default) != 0 {audio_group_set_gain(audiogroup_default, 0, 250)} else {audio_group_set_gain(audiogroup_default, 1, 250)};},
		scale_idle: _button_scale_idle,
		scale_hover: _button_scale_hover,
		scale_pressed: _button_scale_pressed,
		current_scale: _button_scale_idle // Начинаем с обычного размера
	});	
	
	array_push(obj_ui_manager.settings_buttons, {
	    x_pos: _win_x + _win_width / 2 * 0.5, 
	    y_pos: _win_y, 
		sprite_index: spr_button_nosound,
	    state: ButtonState.IDLE,
	    callback: function() {if audio_group_get_gain(sfx_group) != 0 {audio_group_set_gain(sfx_group, 0, 250)} else {audio_group_set_gain(sfx_group, 1, 250)};},
		scale_idle: _button_scale_idle,
		scale_hover: _button_scale_hover,
		scale_pressed: _button_scale_pressed,
		current_scale: _button_scale_idle // Начинаем с обычного размера
	});		
	
	
}