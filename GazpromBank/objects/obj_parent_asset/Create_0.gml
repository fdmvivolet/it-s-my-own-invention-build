/// @description Инициализация базового актива

// Наследуем переменные родителя (is_hovered, is_tapped)
event_inherited(); 

// --- Переменные состояния, общие для всех активов ---
level = 1;

// --- Переменные баланса, общие для всех активов ---
// Эти значения по умолчанию будут перезаписаны в дочерних объектах
// данными из global.game_config.
base_cost = 150;
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
    upgrade_cost = floor(base_cost * level);
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

depth = -y

image_xscale = 0.1;
image_yscale = 0.1;



// 2. Запускаем анимацию с помощью нашего нового движка!
// Мы просим анимировать свойства "image_xscale" и "image_yscale" этого экземпляра (id)
// до конечного значения 1.0 за 0.4 секунды, используя нашу кривую ac_ease_out.


global.Animation.play(id, "image_xscale", 1.0, 0.6, ac_back);
global.Animation.play(id, "image_yscale", 1.0, 0.6, ac_back);

function ease_out_click(){
	after_spawn_anim = false
	image_xscale = 1
	image_yscale = image_xscale
	var _target_scale = 1;
	// Длительность анимации "вдавливания" (очень быстрая)
	var _duration = 0.2; // 100 миллисекунд
	

	// Запускаем анимацию масштаба, используя нашу быструю кривую
	global.Animation.play(id, "image_xscale", _target_scale, _duration, ac_ease_out_cubic_asset);
	global.Animation.play(id, "image_yscale", _target_scale, _duration, ac_ease_out_cubic_asset);
	alarm[0] = game_get_speed(gamespeed_fps)
	
}

show_debug_message("Parent Asset: Запущена анимация появления.");

// Счетчик времени для синусоиды. У каждого экземпляра будет свой.
idle_anim_timer = 0; 
// Случайное смещение, чтобы активы "дышали" не в унисон, а асинхронно.
idle_anim_phase_offset = random(2 * pi); 
// Скорость "дыхания". Чем больше, тем быстрее.
idle_anim_speed = 0.03;
// Амплитуда "дыхания". 0.02 означает, что масштаб будет меняться на +/- 2%.
idle_anim_magnitude = 0.02;

after_spawn_anim = false
alarm[0] = game_get_speed(gamespeed_fps)

/*
bloom_layer = layer_create(depth - 1, "bloom_layer")
_blur = fx_create("_effect_gaussian_blur")
fx_set_parameter(_blur, "g_numDownsamples", 2);
fx_set_parameter(_blur, "g_numPasses", 2);
fx_set_single_layer(_blur, true)
layer_set_fx(bloom_layer, _blur)
*/

//layer_