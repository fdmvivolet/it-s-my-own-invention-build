// --- obj_savings_account: Create Event ---
/// @description Инициализация "Накопительного счета"

// Наследуем всю логику и переменные от obj_parent_asset
event_inherited(); 

// Присваиваем временный спрайт
//sprite_index = spr_safe_temp; 

// --- Получаем уникальные параметры из глобального конфига ---
var _config = global.game_config.assets.savings_account;

base_cost = _config.cost;
base_income = _config.base_income;
base_timer_seconds = _config.timer_seconds;

// --- Логика Туториала (Первая сессия) ---
// В будущем здесь будет проверка, находимся ли мы в туториале.
// if (global.is_in_tutorial) {
//     timer_current = 30; // Ускоренный таймер для первого сбора
// } else {
//     timer_current = base_timer_seconds;
// }
// Сейчас для простоты запускаем обычный таймер
timer_current = base_timer_seconds;

show_debug_message("Создан '" + _config.name + "' со временем созревания " + string(timer_current) + " сек.");