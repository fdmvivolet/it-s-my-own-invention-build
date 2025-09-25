function draw_background(size){
	
	var _gui_w = display_get_gui_width();
	var _gui_h = display_get_gui_height();
	
	draw_set_alpha(0.75)
	draw_set_color(c_black)
	draw_rectangle(0, 0, _gui_w, _gui_h, 0)
	draw_set_color(c_white)
	draw_set_alpha(1)
	
	var _sprite_index = noone
	
	if size == "big" { _sprite_index = spr_big_background } 
	else if  size == "small" { _sprite_index = spr_small_background }
	else { _sprite_index = spr_small_background_lvl_up }

	var _sprite_height = sprite_get_height(_sprite_index)/2
	var _sprite_width = sprite_get_width(_sprite_index)/2

	draw_sprite_ext(_sprite_index, -1, _gui_w/2, _gui_h/2, 1/2*window_scale, 1/2*window_scale, 0, c_white, 1)
		
	var _cancel = quit_button[0];
	var _current_scale = _cancel.current_scale * window_scale
	
	var _w = sprite_get_width(_cancel.sprite_index) / 2
	var _h = sprite_get_height(_cancel.sprite_index) / 2
	
	//draw_sprite_ext(_cancel.sprite_index, -1, _cancel.x_pos, _cancel.y_pos, 1/2 * _current_scale, 1/2 * _current_scale, 0, c_white, 1)
	
	draw_set_color(c_black)
	//draw_rectangle(_cancel.x_pos - _w/2, _cancel.y_pos - _h/2, _cancel.x_pos + _w/2, _cancel.y_pos + _h/2, false)
	
	var _cancel_index = spr_ico_cancel
	
	var _cancel_x = _gui_w / 2 + (_sprite_width / 2 * 0.8 * window_scale)
	var _cancel_y = _gui_h / 2 - (_sprite_height / 2 * 0.85 * window_scale)
	
	//draw_sprite_ext(_cancel_index, -1, _cancel_x, _cancel_y, 1/2*window_scale, 1/2*window_scale, 0, c_white, 1)
	
}

function create_quit_button(size){
	obj_ui_manager.quit_button = []

	var _gui_w = display_get_gui_width();
	var _gui_h = display_get_gui_height();
	
	var _sprite_index = noone
	
	if size == "big" { _sprite_index = spr_big_background } 
	else if  size == "small" { _sprite_index = spr_small_background }
	else { _sprite_index = spr_small_background_lvl_up }

	var _sprite_height = sprite_get_height(_sprite_index) /2 * window_scale
	var _sprite_width = sprite_get_width(_sprite_index)/2 * window_scale
			
	var _cancel_index = spr_ico_cancel
	
	var _cancel_x = _gui_w / 2 + (_sprite_width / 2 * 0.8)
	var _cancel_y = _gui_h / 2 - (_sprite_height / 2 * 0.85)
	
	var _button_scale_idle = 1.0;
	var _button_scale_hover = 1.0; // Сделаем чуть заметнее
	var _button_scale_pressed = 1;
	
	//draw_sprite_ext(_cancel_index, -1, _cancel_x, _cancel_y, 1/2*window_scale, 1/2*window_scale, 0, c_white, 1)

	array_push(obj_ui_manager.quit_button, {
		x_pos: _cancel_x, 
		y_pos: _cancel_y, 
		sprite_index: _cancel_index,
		state: ButtonState.IDLE,
		callback: function() {
			//show_debug_message()
			WINDOW_CLOSE_ANIMATION
		},
		scale_idle: _button_scale_idle,
		scale_hover: _button_scale_hover,
		scale_pressed: _button_scale_pressed,
		current_scale: _button_scale_idle // Начинаем с обычного размера
	});
		
}