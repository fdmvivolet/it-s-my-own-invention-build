for (var i = array_length(active_voices) - 1; i >= 0; i--) {
    var _voice = active_voices[i];
    if (!audio_is_playing(_voice.sound_index)) {
        // Если звук больше не играет, удаляем его из списка
        array_delete(active_voices, i, 1);
    }
}
