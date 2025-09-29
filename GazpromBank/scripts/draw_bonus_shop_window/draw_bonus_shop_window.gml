function draw_bonus_shop_window(){
	
	var _gui_w = display_get_gui_width();
    var _gui_h = display_get_gui_height();
  
    var _sprite_back_index = spr_big_background
	var _win_width = sprite_get_width(_sprite_back_index)/2 * window_scale;
	var _win_height = sprite_get_height(_sprite_back_index)/2 * window_scale;
	       
    draw_set_color(c_white);
    draw_set_halign(fa_center);
    draw_set_valign(fa_top);
	draw_set_font(fnt_main_bold)
    draw_text(_gui_w/2, _gui_h/2 - (_win_height / 2 * 0.90), "БОНУСЫ");
	draw_set_font(fnt_main_normal)
    
	var _win_x = _gui_w/2
	var _win_y = _gui_h/2

    var _bonuses_ids = variable_struct_get_names(global.game_config.bonuses);
    
	var _sprite_card_index = spr_card_background
	
	var _list_start_y = _win_y - (_win_height/2 * 0.4); 
    var _card_height = sprite_get_height(_sprite_card_index) * window_scale 
    var _card_width = sprite_get_width(_sprite_card_index) * window_scale
	
	for (var i = 0; i < array_length(_bonuses_ids); i++) {
        var _bonus_id = _bonuses_ids[i];
        
        var _config = global.game_config.bonuses[$ _bonus_id];
        
        var _card_y = _list_start_y + (i * _card_height * 0.65);
        
        
		draw_sprite_ext(_sprite_card_index, -1, _win_x, _card_y, 
		1/2*window_scale, 1/2*window_scale, 0, c_white, 1)
		
        draw_set_color(c_white);
        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);
        
        draw_set_font(fnt_main_bold)
        draw_text(_win_x, _card_y - 25, string_upper(_config.name));
      	draw_set_font(fnt_main_normal)
		draw_text(_win_x, _card_y + 35, _config.description);
        
        // --- Кнопка "Получить" (визуальная часть) ---
		var _sprite_button_index = spr_ico_coin
		var _sprite_button_width = sprite_get_width(_sprite_button_index) / 2
		var _sprite_button_height = sprite_get_height(_sprite_button_index) / 2
		
        var _button_x = _win_x + _card_width / 4 - _sprite_button_width/2;
        var _button_y = _card_y;
        
		//draw_sprite_ext(spr_ico_coin, -1, _button_x, _card_y, 1/2, 1/2, 0, c_white, 1)
		draw_set_font(fnt_main_bold)
		draw_set_color(c_black)
		
		draw_set_color(c_white)
		draw_set_font(fnt_main_normal)
		
		if sprite_get_name(_config.icon) == "spr_ico_gaz"{
		draw_sprite_ext(_config.icon, -1, _gui_w/2 - (_win_width / 2 - sprite_get_width(spr_ico_empty_shop)/2 + 33),
		_card_y - 5, 1/2 * 0.9, 1/2 * 0.9, 0, c_white, 1)			
		}else{
		draw_sprite_ext(_config.icon, -1, _gui_w/2 - (_win_width / 2 - sprite_get_width(spr_ico_empty_shop)/2 + 33),
		_card_y - 5, 1/2, 1/2, 0, c_white, 1)				
		}
    }	

	for (var i = 0; i < array_length(quests_window_buttons); i++) {
		
		var _button = quests_window_buttons[i];
		
		var _place_x  = _button.x_pos
		var _place_y = _button.y_pos
		
		var _current_scale = _button.current_scale * window_scale;
		
		draw_sprite_ext(_button.sprite_index, -1, _button.x_pos, _button.y_pos, 
		_button.current_scale * 1/2 * window_scale, _button.current_scale * 1/2 * window_scale, 0, c_white, 1)
		draw_set_color(c_black)
		draw_set_font(fnt_main_bold_cloud)
		draw_text(_button.x_pos, _button.y_pos, _button.cost)
		draw_set_color(c_white)
	}
    // Сброс настроек
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
	
	
	
}

function create_bonuses_buttons(){
	obj_ui_manager.quests_window_buttons = [];
	
	var window_scale = obj_ui_manager.window_scale
	    // --- 1. ОТРИСОВКА ФОНА И ОКНА (без изменений) ---
    var _gui_w = display_get_gui_width();
    var _gui_h = display_get_gui_height();
  
    var _sprite_back_index = spr_big_background
	var _win_width = sprite_get_width(_sprite_back_index)/2 * window_scale;
	var _win_height = sprite_get_height(_sprite_back_index)/2 * window_scale;
	       
	var _win_x = _gui_w/2
	var _win_y = _gui_h/2

    var _bonuses_ids = variable_struct_get_names(global.game_config.bonuses);
    
	var _sprite_card_index = spr_card_background
	
	var _list_start_y = _win_y - (_win_height/2 * 0.4); 
    var _card_height = sprite_get_height(_sprite_card_index) * window_scale //200 * window_scale; 
    var _card_width = sprite_get_width(_sprite_card_index) * window_scale
	
    // --- 3. ОТРИСОВКА КАЖДОГО ЗАДАНИЯ В ЦИКЛЕ ---
    for (var i = 0; i < array_length(_bonuses_ids); i++) {
        var _bonus_id = _bonuses_ids[i];
        
        // Получаем данные из конфига и прогресса
        var _config = global.game_config.bonuses[$ _bonus_id];
        //var _progress = global.game_data.quest_progress[$ _quest_id];
        
        // Рассчитываем позицию текущей карточки
        var _card_y = _list_start_y + (i * _card_height * 0.65);
        
        // --- Кнопка "Получить" (визуальная часть) ---
		var _sprite_button_index = spr_ico_coin//spr_quest_not_done
		
		if sprite_get_name(_config.icon) == "spr_ico_gaz"{
			_sprite_button_index = spr_ico_diamond
		}
		
		
		var _sprite_button_width = sprite_get_width(_sprite_button_index) / 2
		var _sprite_button_height = sprite_get_height(_sprite_button_index) / 2
		
        var _button_x = _win_x + _card_width / 4 - _sprite_button_width/2;
        var _button_y = _card_y;
		
		var _button_scale_idle = 1.0;
		var _button_scale_hover = 1.0; // Сделаем чуть заметнее
		var _button_scale_pressed = 0.95;		
		
		array_push(obj_ui_manager.quests_window_buttons, {
	        x_pos: _gui_w/2 + (_win_width / 2 - sprite_get_width(spr_ico_empty_shop)/2 + 33), 
	        y_pos: _button_y, 
			sprite_index: _sprite_button_index,
	        state: ButtonState.IDLE,
	        callback: method(
				        { config: _config }, 
				        function() {
				            show_debug_message("Попытка получить " + config.name)
				        }
				    ),
			scale_idle: _button_scale_idle,
			scale_hover: _button_scale_hover,
			scale_pressed: _button_scale_pressed,
			current_scale: _button_scale_idle, // Начинаем с обычного размера
			cost: _config.cost,
	    });
		
    }
	
}