// --- obj_ui_manager: Draw GUI Event ---
/// @description Отрисовка всего пользовательского интерфейса
// --- 1. ОТРИСОВКА HUD (ИНФОРМАЦИОННОЙ ПАНЕЛИ) ---
var _coins = global.game_data.player_coins;


draw_set_halign(fa_right);
draw_set_valign(fa_top);
draw_set_color(c_white);

var _display_text = "Монеты: " + string(_coins);
draw_text(display_get_gui_width() - 20, 20, _display_text);

draw_set_halign(fa_left);

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