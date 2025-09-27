// --- obj_ui_manager: Draw GUI Event ---
/// @description Отрисовка всего пользовательского интерфейса
// --- 1. ОТРИСОВКА HUD (ИНФОРМАЦИОННОЙ ПАНЕЛИ) ---





//draw_sprite_ext(spr_rounded_rectangle, -1, _width/2, _bar_render_height/2, 1, 1, 0, c_white, 1)
//draw_rectangle_color(0, _height-256, _width, _height, c_black, c_black, c_black, c_black, false)



draw_hud_level_and_xp() 
draw_tab_bar()
//draw_background("big")

// --- 2. ОТРИСОВКА ОКОН ---
switch (current_ui_state) {
    case UIState.SHOP_WINDOW:
		draw_background("big")
		var _cancel = quit_button[0];
		var _current_scale = _cancel.current_scale * window_scale		
		draw_sprite_ext(_cancel.sprite_index, -1, _cancel.x_pos, _cancel.y_pos, 1/2 * _current_scale, 1/2 * _current_scale, 0, c_white, 1)		
		draw_shop_window();
        break;

    case UIState.ASSET_WINDOW:
		draw_background("")
		var _cancel = quit_button[0];
		var _current_scale = _cancel.current_scale * window_scale		
		draw_sprite_ext(_cancel.sprite_index, -1, _cancel.x_pos - 10, _cancel.y_pos + 10, 1/2 * _current_scale, 1/2 * _current_scale, 0, c_white, 1)			
        draw_asset_window(); 
        break;
		
	case UIState.QUESTS_WINDOW:
		draw_background("big")
		
		var _cancel = quit_button[0];
		var _current_scale = _cancel.current_scale * window_scale		
		draw_sprite_ext(_cancel.sprite_index, -1, _cancel.x_pos, _cancel.y_pos, 1/2 * _current_scale, 1/2 * _current_scale, 0, c_white, 1)
		draw_quests_window();
		break;
	case UIState.TUTORIAL_CLOUD:
	
		var _gui_w = display_get_gui_width();
		var _gui_h = display_get_gui_height();
	
		draw_set_alpha(0.75)
		draw_set_color(c_black)
		draw_rectangle(0, 0, _gui_w, _gui_h, 0)
		draw_set_color(c_white)
		draw_set_alpha(1)	
	
		//show_message("asdasdas")
		//draw_npc_tooltip(tooltip_message_to_show);
		//draw_set_alpha(window_alpha)
		draw_npc_tooltip()
		//draw_set_alpha(1)
		break;
    
	case UIState.LEVEL_UP_WINDOW:
		draw_background("")
        draw_level_up_window();
        break;	
	
	case UIState.CTA_WINDOW:
		draw_background("small")
		draw_cta_window()
		break;
		
	case UIState.SETTINGS:
		draw_background("small")
		var _cancel = quit_button[0];
		var _current_scale = _cancel.current_scale * window_scale		
		draw_sprite_ext(_cancel.sprite_index, -1, _cancel.x_pos - 10, _cancel.y_pos + 10, 1/2 * _current_scale, 1/2 * _current_scale, 0, c_white, 1)
		draw_settings_window()
		
		break;
		
}

/*
if (current_ui_state == UIState.TUTORIAL_CLOUD) {

        var radius = 80
        var _npc_x = 150;
        var _npc_y = display_get_gui_height() - 350;
	    var _tooltip_x1 = _npc_x + 100;
	    var _tooltip_y1 = _npc_y - (radius + 20); // Верхний край
	    var _tooltip_x2 = display_get_gui_width() - 100;
	    var _tooltip_y2 = _npc_y + radius; // Нижний край, теперь облако центрировано по Y
        
		draw_set_alpha(0.5)
		draw_rectangle_color(_tooltip_x1, _tooltip_y1, _tooltip_x2, _tooltip_y2,
		c_red,c_red,c_red,c_red, false)
		draw_set_alpha(1)

}

// В будущем здесь будет отрисовка окон, кнопок и т.д.