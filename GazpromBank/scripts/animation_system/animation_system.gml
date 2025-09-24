#macro MICROSECOND_IN_SECOND 1000000

// Мы создаем глобальную структуру (по сути, статичный класс),
// чтобы все наши функции были удобно сгруппированы.
global.Animation = {
    
    // --- Главная функция для ЗАПУСКА анимации ---
    
    /// @function       play(target_instance, property_name, end_value, duration, curve_asset)
    /// @param {Id.Instance}	target_instance		Экземпляр, который нужно анимировать.
    /// @param {string}			property_name		Имя переменной в виде строки (например, "image_xscale").
    /// @param {any}			end_value			Конечное значение, к которому стремится переменная.
    /// @param {real}			duration			Длительность анимации в секундах.
    /// @param {Id.AnimCurve}	curve_asset			Ассет кривой анимации (например, ac_ease_out).
	/// @param {function}		callback_func       Функция после завершения анимации
    play: function(target_instance, property_name, end_value, duration, curve_asset, callback_func = noone) {
        
        // --- ЗАЩИТА ---
        if (!instance_exists(target_instance)) return;
        
        // --- 1. Получаем начальное значение ---
        var _start_value = variable_instance_get(target_instance, property_name);
        
        // --- 2. Создаем "партитуру" - struct с описанием анимации ---
        var _new_tween = {
            target: target_instance,    // На ком играем
            property: property_name,    // Что играем (какую ноту)
            
            start_value: _start_value,  // С чего начинаем
            end_value: end_value,       // Чем заканчиваем
            
            duration: duration * MICROSECOND_IN_SECOND, // Переводим секунды в кадры
            time: 0,                    // Внутренний таймер анимации
            
            curve: curve_asset,          // Какая мелодия (кривая)
			on_complete: callback_func // Сохраняем callback-функцию
        };
        
        // --- 3. Кладем "партитуру" на "рабочий стол" дирижера ---
        array_push(obj_animation_manager.active_tweens, _new_tween);
        
        show_debug_message("Animation Manager: Запущена анимация '" + property_name + "'");
    }
    
    // В будущем здесь могут быть другие функции, например, Animation.stop(), Animation.sequence()
    
};