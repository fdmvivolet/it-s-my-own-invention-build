show_debug_message("Sound Manager: Инициализация...");
randomize()
// --- 1. Загрузка и хранение звуков ---
// Мы используем struct (объект) для хранения ссылок на наши звуки.
// Это удобнее, чем запоминать имена ассетов.
sfx = {
    // ВАЖНО: snd_coin_collect, snd_ui_click и т.д. - это имена ваших
    // звуковых ассетов, которые вы должны сначала импортировать в проект.
    
    collect_income:		snd_coin_collect,  // Звук сбора дохода
    ui_click_high:      snd_ui_click_high,        // Обычный клик по кнопке
    purchase:			snd_purchase,        // Звук покупки/улучшения
    //level_up:			snd_level_up         // Джингл повышения уровня
	ui_click_low:		snd_ui_click_low,
	coin_hud:			snd_coin_hud
};


// --- 2. Создание метода для проигрывания SFX ---

/// @function           play_sfx(sfx_struct_key)
/// @param {string}     sfx_struct_key  Ключ из нашего struct 'sfx' (например, "collect_income").
/// @description        Проигрывает звуковой эффект с небольшой вариацией высоты тона.
function play_sfx(sfx_struct_key) {
    
    // Проверяем, существует ли такой звук в нашем хранилище
    if (!variable_struct_exists(sfx, sfx_struct_key)) {
        show_debug_message("Sound Manager: ОШИБКА! Попытка проиграть несуществующий звук: " + sfx_struct_key);
        return;
    }
    
    var _sound_to_play = sfx[$ sfx_struct_key];
    
    // "Сочность"! Мы будем проигрывать звук с небольшой случайной вариацией высоты тона (pitch).
    // Это делает так, что одинаковые звуки (например, частые клики) не звучат монотонно и не раздражают.
    var _pitch = 1 + random_range(-0.05, 0.05);
    
    audio_sound_pitch(_sound_to_play, _pitch);
	var sound_gain = audio_sound_get_gain(_sound_to_play) + random_range(-0.05, 0.05)
	var sound_time = audio_sound_length(_sound_to_play)
	
    audio_sound_gain(_sound_to_play, sound_gain, sound_time)
	
    // Проигрываем звук. 10 - приоритет (стандартный), false - не зацикливать.
    audio_play_sound(_sound_to_play, 10, false);
	
}

audio_group_load(sfx_group)
audio_group_load(audiogroup_default)

audio_group_set_gain(sfx_group, 0, 0)
audio_group_set_gain(audiogroup_default, 0, 0)
 
function play_background(){
	show_debug_message("try to play music")
	if audio_group_is_loaded(audiogroup_default) && !is_loaded{
		show_debug_message("start to play music")
		audio_play_sound(snd_ambient, 1, true)
		is_loaded = true
	}	
}

alarm[0] = 60
is_loaded = false

//if audio_group_get_gain(audiogroup_default) != 0 {audio_group_set_gain(audiogroup_default, 0, 250)} else {audio_group_set_gain(audiogroup_default, 1, 250)}
//if audio_group_get_gain(sfx_group) != 0 {audio_group_set_gain(sfx_group, 0, 250)} else {audio_group_set_gain(sfx_group, 1, 250)}
//
//audio_group_set_gain(sfx, 0, 250)

show_debug_message("Sound Manager: Инициализация завершена.");