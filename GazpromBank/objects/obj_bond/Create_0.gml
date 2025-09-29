// --- Это пример того, как мы будем использовать конфиг ---

// Наследуем переменные от родителя
event_inherited(); 

// Получаем наши уникальные параметры из глобального конфига
var _config = global.game_config.assets.bond;


name = _config.name

my_name = _config.name;
base_cost = _config.cost;
base_income = _config.base_income;
base_timer_seconds = _config.timer_seconds;
levels_curve = _config.levels

calculate_next_upgrade();
timer_current = base_timer_seconds;
trigger_one_time_event("FirstBondPurchase", {tutorial_id: "FirstBondPurchase"});		
show_debug_message("Создан '" + _config.name + "' со временем созревания " + string(timer_current) + " сек.");