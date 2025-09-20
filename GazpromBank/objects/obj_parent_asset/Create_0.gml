/// @description Инициализация базового актива

// Наследуем переменные родителя (is_hovered, is_tapped)
event_inherited(); 

// --- Переменные состояния, общие для всех активов ---
level = 1;

// --- Переменные баланса, общие для всех активов ---
// Эти значения по умолчанию будут перезаписаны в дочерних объектах
// данными из global.game_config.
base_cost = 0;
base_income = 0;
base_timer_seconds = 60;

// --- Переменные логики таймера ---
// -1 означает, что таймер не запущен
timer_current = -1; 
is_ready_to_collect = false;

// Переменные для улучшения
upgrade_cost = 0;
next_level_income = 0;

// --- ФУНКЦИЯ РАСЧЕТА СЛЕДУЮЩЕГО УЛУЧШЕНИЯ ---
// Эта функция будет вызываться при создании и после каждого улучшения
function calculate_next_upgrade() {
    // Простая формула для примера:
    // Стоимость = базо_стоимость * уровень * 1.5
    // Доход = базо_доход * (уровень + 1)
    upgrade_cost = floor(base_cost * level * 1.5);
    next_level_income = base_income * (level + 1);
}

// --- ФУНКЦИЯ ВЫПОЛНЕНИЯ УЛУЧШЕНИЯ ---
function perform_upgrade() {
    // Проверяем, достаточно ли денег
    if (global.game_data.player_coins >= upgrade_cost) {
        // Списываем деньги
        global.game_data.player_coins -= upgrade_cost;
        
        // Повышаем уровень и доход
        level += 1;
        base_income = base_income*2//next_level_income;
        
        // Пересчитываем стоимость следующего улучшения
        calculate_next_upgrade();
        
        show_debug_message("УСПЕХ! Актив улучшен до Ур. " + string(level) + ". Новый доход: " + string(base_income));
        save_game();
        
    } else {
        show_debug_message("НЕУДАЧА! Недостаточно средств для улучшения.");
    }
}

// Вызываем расчет в первый раз при создании
calculate_next_upgrade();