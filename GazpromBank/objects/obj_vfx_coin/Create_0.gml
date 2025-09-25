// --- obj_vfx_coin: Create Event ---

/// @description Инициализация монетки-эффекта.

// Ставим "таймер самоуничтожения" на 2 секунды.
// Это "защита от дурака" на случай, если анимация не завершится
// и объект "зависнет" в комнате.
alarm[0] = 2 * game_get_speed(gamespeed_fps);

// Добавим немного случайности во вращение для красоты
image_angle = random(360);
image_xscale = 1/4
image_yscale = image_xscale