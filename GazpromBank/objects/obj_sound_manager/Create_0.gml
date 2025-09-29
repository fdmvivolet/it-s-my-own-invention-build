show_debug_message("Sound Manager: Инициализация...");
randomize()
#macro AUDIO_VOICE_LIMIT 4
// --- 1. Загрузка и хранение звуков ---
// Мы используем struct (объект) для хранения ссылок на наши звуки.
// Это удобнее, чем запоминать имена ассетов.
sfx = {
    // ВАЖНО: snd_coin_collect, snd_ui_click и т.д. - это имена ваших
    // звуковых ассетов, которые вы должны сначала импортировать в проект.
    
    collect_income:		{ id: snd_coin_collect,		priority : 3},  
    ui_click_high:      { id: snd_ui_click_high,	priority : 2},       
    purchase:			{ id: snd_purchase,			priority : 4},         
    level_up:			{ id: snd_level_up,			priority : 5},        
	ui_click_low:		{ id: snd_ui_click_low,		priority  : 2},
	coin_hud:			{ id: snd_coin_hud,			priority : 1},
	open_tutorial:		{ id: snd_open_tutorial,	priority : 5},
	phone_call:			{},
	
};


// --- 2. Создание метода для проигрывания SFX ---

/// @function           play_sfx(sfx_struct_key)
/// @param {string}     sfx_struct_key  Ключ из нашего struct 'sfx' (например, "collect_income").
/// @description        Проигрывает звуковой эффект с небольшой вариацией высоты тона.
//function play_sfx(sfx_struct_key) {
    
//    // Проверяем, существует ли такой звук в нашем хранилище
//    if (!variable_struct_exists(sfx, sfx_struct_key)) {
//        show_debug_message("Sound Manager: ОШИБКА! Попытка проиграть несуществующий звук: " + sfx_struct_key);
//        return;
//    }
    
//    var _sound_to_play = sfx[$ sfx_struct_key];
    
//    // "Сочность"! Мы будем проигрывать звук с небольшой случайной вариацией высоты тона (pitch).
//    // Это делает так, что одинаковые звуки (например, частые клики) не звучат монотонно и не раздражают.
//    var _pitch = 1 + random_range(-0.05, 0.05);
    
//    audio_sound_pitch(_sound_to_play, _pitch);
//	var sound_gain = audio_sound_get_gain(_sound_to_play) + random_range(-0.05, 0.05)
//	var sound_time = audio_sound_length(_sound_to_play)
	
//    audio_sound_gain(_sound_to_play, sound_gain, sound_time)
	
//    // Проигрываем звук. 10 - приоритет (стандартный), false - не зацикливать.
//    audio_play_sound(_sound_to_play, 10, false);
	
//}

audio_group_load(sfx_group)
audio_group_load(audiogroup_default)

//audio_group_set_gain(sfx_group, 0, 0)
//audio_group_set_gain(audiogroup_default, 0, 0)
 
function play_background(){
	show_debug_message("try to play music")
	if audio_group_is_loaded(audiogroup_default) && !is_loaded{
		show_debug_message("start to play music")
		audio_play_sound(snd_ambient, 1, true)
		is_loaded = true
	}	
}

function start_stop_call(){
		
}

alarm[0] = 60
is_loaded = false

function play_sfx(sfx_struct_key) {
    
    // 1. Получаем всю информацию о звуке (ID и приоритет)
    var _sfx_info = sfx[$ sfx_struct_key];
    var _sound_to_play = _sfx_info.id;
    var _priority = _sfx_info.priority;
    
    // 2. Проверяем, есть ли свободные "голоса"
    if (array_length(active_voices) >= AUDIO_VOICE_LIMIT) {
        
        // --- ЛОГИКА ВЫТЕСНЕНИЯ ---
        var _lowest_priority = 999;
        var _lowest_priority_index = -1;
        
        // Ищем самый низкоприоритетный звук среди играющих
        for (var i = 0; i < array_length(active_voices); i++) {
            if (active_voices[i].priority < _lowest_priority) {
                _lowest_priority = active_voices[i].priority;
                _lowest_priority_index = i;
            }
        }
        
        // Сравниваем приоритеты
        if (_priority > _lowest_priority) {
            // Новый звук ВАЖНЕЕ. Останавливаем старый.
            var _sound_to_stop = active_voices[_lowest_priority_index].sound_index;
            audio_stop_sound(_sound_to_stop);
            // Удаляем его из нашего списка
            array_delete(active_voices, _lowest_priority_index, 1);
        } else {
            // Новый звук НЕ важнее. Просто не проигрываем его.
            return;
        }
    }
    
    // 3. Проигрываем новый звук
    var _pitch = 1 + random_range(-0.05, 0.05);
    var _played_sound_index = audio_play_sound(_sound_to_play, 10, false, 1.0, 0, _pitch);
    
    // 4. Добавляем информацию о новом "голосе" в наш список
    var _voice_info = {
        sound_index: _played_sound_index,
        priority: _priority
    };
    array_push(active_voices, _voice_info);
}

active_voices = []
//if audio_group_get_gain(audiogroup_default) != 0 {audio_group_set_gain(audiogroup_default, 0, 250)} else {audio_group_set_gain(audiogroup_default, 1, 250)}
//if audio_group_get_gain(sfx_group) != 0 {audio_group_set_gain(sfx_group, 0, 250)} else {audio_group_set_gain(sfx_group, 1, 250)}
//
//audio_group_set_gain(sfx, 0, 250)

show_debug_message("Sound Manager: Инициализация завершена.");