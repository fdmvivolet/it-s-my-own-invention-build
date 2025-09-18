event_inherited(); 


button_text = ""; // Текст нам не нужен, у нас иконка

function StartGame() {
    show_debug_message("Анимированная кнопка нажата!");
    //room_goto(rm_level_1);
}
callback_function = StartGame;

animation_speed = 0.2; 

scale_idle = 1.0;     // Обычный размер
scale_hover = 1.05;   // Немного увеличивается при наведении для "сочности"
scale_pressed = 0.9;  // Уменьшается при нажатии

current_scale = scale_idle;
target_scale = scale_idle;

ic_sprite_name = spr_button_icon
bg_sprite_name = spr_button_bg
fg_sprite_name = spr_button_fg