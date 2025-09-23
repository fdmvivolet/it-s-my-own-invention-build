/// @description Insert description here
// You can write your code in this editor
if (is_ready_to_collect) {
	image_xscale = 1
	image_yscale = 1
    var _duration = 0.6
    // ...запускаем анимацию "подпрыгивания" еще раз.
    global.Animation.play(id, "image_xscale", 1.0, _duration, ac_bounce);
    global.Animation.play(id, "image_yscale", 1.0, _duration, ac_bounce);
    
    // И снова взводим этот же Alarm, чтобы он сработал через 1.5 секунды.
    // Мы создали бесконечный цикл, который прервется,
    // когда is_ready_to_collect станет false.
    alarm[1] = game_get_speed(gamespeed_fps);
}