// --- obj_ui_manager: Draw GUI Event ---
/// @description Отрисовка всего пользовательского интерфейса
// --- 1. ОТРИСОВКА HUD (ИНФОРМАЦИОННОЙ ПАНЕЛИ) ---


var _width = display_get_gui_width()
var _height = display_get_gui_height()

draw_set_alpha(0.6)
draw_roundrect_color_ext(0, -32, _width, 200, 128, 32, c_black, c_black, false)
draw_set_alpha(1)

draw_rectangle_color(0, _height-256, _width, _height, c_black, c_black, c_black, c_black, false)

draw_set_font(Font1)
draw_counter() //счетчик монет
draw_hud_level_and_xp() 
draw_tab_bar()


// --- 2. ОТРИСОВКА ОКОН ---
switch (current_ui_state) {
    case UIState.SHOP_WINDOW:
		draw_shop_window();
        break;
        
    case UIState.ASSET_WINDOW:
        draw_asset_window(); 
        break;
}

// В будущем здесь будет отрисовка окон, кнопок и т.д.