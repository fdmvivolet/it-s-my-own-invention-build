// --- Это пример того, как мы будем использовать конфиг ---

// Наследуем переменные от родителя
event_inherited(); 

// Получаем наши уникальные параметры из глобального конфига
var _config = global.game_config.assets.deposit;

my_name = _config.name;
base_cost = _config.cost;
base_income = _config.base_income;
base_timer_seconds = _config.timer_seconds;

timer_current = base_timer_seconds;

show_debug_message("Создан '" + _config.name + "' со временем созревания " + string(timer_current) + " сек.");