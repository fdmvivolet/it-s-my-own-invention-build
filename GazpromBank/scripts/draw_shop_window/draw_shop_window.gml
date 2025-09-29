function draw_shop_window() {   
    // Фон окна
    var _gui_w = display_get_gui_width();
    var _gui_h = display_get_gui_height();
    
	
	var _win_width = sprite_get_width(spr_big_background)/2 * window_scale;
    var _win_height = sprite_get_height(spr_big_background)/2 * window_scale;
	
    // --- 2. ОТРИСОВКА КОНТЕНТА ---
    draw_set_color(c_white);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_font(fnt_main_bold)
    draw_text(_gui_w/2, _gui_h/2 - (_win_height / 2 * 0.85), "МАГАЗИН")
	draw_set_font(fnt_main_normal)
    var _asset_ids = variable_struct_get_names(global.game_config.assets);
	
	var _win_x = _gui_w/2
	var _win_y = _gui_h/2	
	
	var _sprite_card_index = spr_card_background
	var _list_start_y = _win_y - (_win_height/2 * 0.4); 
    var _card_height = sprite_get_height(_sprite_card_index) * window_scale
    var _card_width = sprite_get_width(_sprite_card_index) * window_scale    
	
    for (var i = 0; i < array_length(_asset_ids); i++) {
        var _asset_id = _asset_ids[i];
        var _asset_config = global.game_config.assets[$ _asset_id];
        
		var _card_y = _list_start_y + (i * _card_height * 0.65);
		
        // --- Рисуем название товара ---
        draw_set_halign(fa_left);
        draw_set_valign(fa_middle);
        draw_set_color(c_white);
        //draw_text(_win_x, _card_y, _asset_config.name);
        
        // --- Проверяем, доступен ли товар по уровню ---
        var _is_unlocked = (global.game_data.player_level >= _asset_config.required_level) && global.game_data.player_coins >= _asset_config.cost;
        
		var empty_icon = spr_ico_empty_shop
		
		
		draw_sprite_ext(_sprite_card_index, -1, _win_x, _card_y, 
		1/2*window_scale, 1/2*window_scale, 0, c_white, 1)		
		
		var _button = obj_ui_manager.shop_buttons
        // --- Рисуем кнопку "Купить" / "Заблокировано" ---
        var _btn_x = _gui_w/2+ _win_width / 2 - sprite_get_width(empty_icon)/2 + 40;
        var _btn_y = _card_y;
        
		var _is_savings_acc = _asset_config.name == "Накопительный счет"
		var _is_deposit = _asset_config.name == "Вклад"
		var _is_bond = _asset_config.name == "Облигация"
		
        if (_is_unlocked) {
            // Товар доступен
			draw_sprite_ext(empty_icon, -1, _btn_x, _btn_y - 2, 1/2, 1/2, 0, c_green, 1)						 			
			
			if _is_savings_acc && !instance_exists(obj_savings_account) {draw_sprite_ext(spr_ico_empty_shop_white, -1, _btn_x - 4, _btn_y - 4, 1/2 * white_scale, 1/2 * white_scale, 0, c_white, 0.25)}
			if _is_deposit && !instance_exists(obj_deposit) {draw_sprite_ext(spr_ico_empty_shop_white, -1, _btn_x - 4, _btn_y - 4, 1/2 * white_scale, 1/2 * white_scale, 0, c_white, 0.25)}
			if _is_bond && !instance_exists(obj_bond) {draw_sprite_ext(spr_ico_empty_shop_white, -1, _btn_x - 4, _btn_y - 4, 1/2 * white_scale, 1/2 * white_scale, 0, c_white, 0.25)}
			
			draw_set_halign(fa_center);
            draw_text(_btn_x, _btn_y, string(_asset_config.cost));
        } else if global.game_data.player_level <= _asset_config.required_level{
            // Товар заблокирован
			draw_sprite_ext(empty_icon, -1, _btn_x, _btn_y - 2, 1/2, 1/2, 0, c_red, 1)
            draw_set_halign(fa_center);
            draw_text(_btn_x, _btn_y, "Ур. " + string(_asset_config.required_level));
        } else {
			draw_sprite_ext(empty_icon, -1, _btn_x, _btn_y - 2, 1/2, 1/2, 0, c_red, 1)
            draw_set_halign(fa_center);			
			draw_text(_btn_x, _btn_y, string(_asset_config.cost));
		}
		
		draw_sprite_ext(_asset_config.sprite, -1, _gui_w/2 - (_win_width / 2 - sprite_get_width(empty_icon)/2 + 33),
		_btn_y - 5, 1/2, 1/2, 0, c_white, 1)
		
        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);		
		var coin_per_hour = 60 / _asset_config.timer_seconds * _asset_config.base_income * 60
		draw_set_font(fnt_main_normal)
		draw_text(_win_x, _card_y - 25, _asset_config.name);
		draw_text(_win_x, _card_y + 35, coin_per_hour);
        
    }	
	/////////////////////////////////////////////////////////////////////////
	
	for (var i = 0; i < array_length(shop_buttons); i++) {
		
		var _button = shop_buttons[i];
		
		var _place_x  = _button.x_pos
		var _place_y = _button.y_pos
		
		var _current_scale = _button.current_scale * window_scale;
		
		draw_sprite_ext(_button.sprite_index, -1, _button.x_pos, _button.y_pos, 
		_button.current_scale * 1/2 * window_scale, _button.current_scale * 1/2 * window_scale, 0, c_white, 1)
	}	
	
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);	
	
	
}

function create_shop_buttons(){
	obj_ui_manager.shop_buttons = [];
	var window_scale = obj_ui_manager.window_scale
	
    var _gui_w = display_get_gui_width();
    var _gui_h = display_get_gui_height();  
	
	var _win_width = sprite_get_width(spr_big_background)/2 * window_scale;
    var _win_height = sprite_get_height(spr_big_background)/2 * window_scale;

    var _asset_ids = variable_struct_get_names(global.game_config.assets);
	
	var _win_x = _gui_w/2
	var _win_y = _gui_h/2	
	
	var _sprite_card_index = spr_card_background
	var _list_start_y = _win_y - (_win_height/2 * 0.4); 
    var _card_height = sprite_get_height(_sprite_card_index) * window_scale
    var _card_width = sprite_get_width(_sprite_card_index) * window_scale    
	
    for (var i = 0; i < array_length(_asset_ids); i++) {
        var _asset_id = _asset_ids[i];
        var _asset_config = global.game_config.assets[$ _asset_id];
        
		var _card_y = _list_start_y + (i * _card_height * 0.65);

        var _is_unlocked = (global.game_data.player_level >= _asset_config.required_level);
        
		var empty_icon = spr_ico_empty_shop
		
		draw_sprite_ext(_sprite_card_index, -1, _win_x, _card_y, 
		1/2*window_scale, 1/2*window_scale, 0, c_white, 1)		
		
        // --- Рисуем кнопку "Купить" / "Заблокировано" ---
        var _btn_x = _gui_w/2+ _win_width / 2 - sprite_get_width(empty_icon)/2 + 35;
        var _btn_y = _card_y - 5;
        
        if (_is_unlocked) {
            // Товар доступен
			draw_sprite_ext(empty_icon, -1, _btn_x, _btn_y - 2, 1/2, 1/2, 0, c_green, 1)
            draw_set_halign(fa_center);
            draw_text(_btn_x, _btn_y, string(_asset_config.cost));
        } else {
            // Товар заблокирован
			draw_sprite_ext(empty_icon, -1, _btn_x, _btn_y - 2, 1/2, 1/2, 0, c_red, 1)
            draw_set_halign(fa_center);
            draw_text(_btn_x, _btn_y, "Ур. " + string(_asset_config.required_level));
        }
        
        var _purchase_data = {
            asset_type: _asset_id, // Используем динамический ID
            tile_id: obj_ui_manager.current_context_id
        };
		
		var _button_scale_idle = 1.0;
		var _button_scale_hover = 1.0; // Сделаем чуть заметнее
		var _button_scale_pressed = 0.95;			
	
		array_push(obj_ui_manager.shop_buttons, {
	        x_pos: _btn_x, 
	        y_pos: _btn_y, 
			sprite_index: spr_ico_empty_shop,
	        state: ButtonState.IDLE,
	        callback: method(
				        // 1. Контекст: создаем новую структуру с одним полем 'quest_id'.
				        // Это "заморозит" текущее значение _quest_id.
				        { purchase_data: _purchase_data,
							is_unlocked : _is_unlocked
							}, 
        
				        // 2. Функция: эта функция будет выполнена в контексте структуры выше.
				        // 'self' будет указывать на эту структуру.
				        function() {
							if is_unlocked{
								current_ui_state = UIState.HIDDEN;
								obj_game_manager.game_state = GameState.GAMEPLAY;
					            EventBusBroadcast("PurchaseAssetRequested", self.purchase_data);
								//WINDOW_CLOSE_ANIMATION
							}
				        }
				    ),
			scale_idle: _button_scale_idle,
			scale_hover: _button_scale_hover,
			scale_pressed: _button_scale_pressed,
			current_scale: _button_scale_idle // Начинаем с обычного размера
	    });		
		
    }			
}