switch (state) {
    case BUTTON_STATE.IDLE:
        target_scale = scale_idle;
        break;
    case BUTTON_STATE.HOVER:
        target_scale = scale_hover;
        break;
    case BUTTON_STATE.PRESSED:
        target_scale = scale_pressed;
        break;
}

if target_scale == scale_pressed{
	animation_speed = 0.8; 
}else
{
	animation_speed = 0.2; 
}

current_scale = lerp(current_scale, target_scale, animation_speed);

draw_sprite(bg_sprite_name, 0, x, y);

draw_sprite_ext(
    fg_sprite_name,       // Спрайт переднего плана
    0,                   // Кадр анимации
    x, y,                // Позиция
    current_scale,       // Масштаб по X (наш анимированный)
    current_scale,       // Масштаб по Y (наш анимированный)
    0,                   // Угол поворота
    c_white,             // Цвет смешивания (белый = без изменений)
    1                    // Прозрачность
);

draw_sprite(ic_sprite_name, 0, x, y); // иконка на кнопке :3
