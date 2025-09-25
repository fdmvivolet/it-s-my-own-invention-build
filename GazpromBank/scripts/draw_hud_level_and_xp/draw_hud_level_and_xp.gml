/// @function draw_hud_level_and_xp()
/// @description Рисует уровень игрока и полоску опыта в HUD.
function draw_hud_level_and_xp() {
    draw_set_font(fnt_main_bold)
	var _width = display_get_gui_width()
	var _height = display_get_gui_height()
	var _white = make_color_rgb(217, 217, 217)
	draw_set_alpha(0.15)
	var _bar_render_height = 250 + 100;

	//draw_roundrect_color_ext(0, -_bar_render_height, _width, _bar_render_height, 128, 128, _white, _white, false)

	draw_roundrect_color_ext(0, -_bar_render_height, _width, _bar_render_height, 128, 128, c_black, c_black, false)

	draw_set_alpha(0.15)
	draw_set_color(c_black)
	draw_roundrect_ext(0, -_bar_render_height, _width, _bar_render_height, 128, 128, true)
	draw_set_color(c_white)
	//draw_roundrect_ext()
	draw_set_alpha(1)	
	
	
	
	draw_set_alpha(0.5)	
	//draw_roundrect_ext(0, -_bar_render_height, _width, _bar_render_height, 128, 128, true)
	draw_set_alpha(1)	

	var _razmer_orig = sprite_get_width(spr_xp_window) / 1080
	var _razmer_now = sprite_get_width(spr_xp_window) / _width
	
	var _lvl_x = sprite_get_width(spr_ico_settings)/2
	var _lvl_y = _bar_render_height  - sprite_get_height(spr_coin_icon)/2
	
	var _xp_x = _width/2
	var _xp_y = _bar_render_height  - sprite_get_height(spr_coin_icon)/2
	
	draw_sprite_ext(spr_xp_window, -1, _xp_x, _xp_y, _width/1080*0.75, 0.75, 0, c_white, 1)
	
	draw_sprite_ext(spr_ico_empty, -1, _lvl_x , _lvl_y, 0.75, 0.75, 0, c_white, 1)
    
    // --- Получаем данные из глобальных структур ---
    var _level = global.game_data.player_level;
    var _current_xp = global.game_data.total_earnings //global.game_data.player_xp;
	
    var _xp_for_next_level = global.game_config.level_thresholds[_level] //_level * 100; 
    
	var _to_del = global.game_config.level_thresholds[_level-1]

	
	_xp_for_next_level -= _to_del
	_current_xp -= _to_del
    
    // 1. Рисуем текст уровня
    draw_set_halign(fa_left);
    draw_set_valign(fa_middle);
	
	
	_lvl_x = _width*0.305
	
	draw_set_color(c_black)
    draw_text(_lvl_x, _lvl_y, string(_level));
    
	draw_text(_xp_x, _xp_y, string(_current_xp) + "|" + string(_xp_for_next_level))
	draw_set_color(c_white)


	var _button = settings_button[0];
		
	var _place_x  = _button.x_pos
	var _place_y = _button.y_pos
		
	var _current_scale = _button.current_scale;
    
	var sprite_name = "spr_ico_" + _button.id
	var _sprite_index = asset_get_index(sprite_name)
		
	draw_sprite_ext(_sprite_index, -1, _button.x_pos, _button.y_pos, _button.current_scale*0.75, _button.current_scale*0.75, 0, c_white, 1)
		
	draw_counter() //счетчик монет
    // Сброс настроек
    draw_set_color(c_white);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}