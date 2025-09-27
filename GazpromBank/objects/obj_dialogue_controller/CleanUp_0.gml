/// @description Очистка перед уничтожением.
// Прерываем все анимации, связанные с этим объектом.
/*
show_debug_message("Dialogue Controller: Уничтожен экземпляр #" + string(id));

// Если в вашем AnimationManager есть функция stop, используйте ее.
// Это предотвратит попытки AnimationManager'а обновить уже несуществующий объект.
if (variable_global_exists("Animation")) {
    // Предполагаем, что у вас есть или будет такая функция
    // Animation.stop(id, "visible_word_index"); 
}