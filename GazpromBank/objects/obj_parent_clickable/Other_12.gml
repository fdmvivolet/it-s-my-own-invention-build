/// @description Этот метод будет вызван, когда палец покинет объект.
is_hovered = false;
// В будущем здесь можно будет убрать эффект подсветки
/*
if (image_xscale != 1.0) { 
    var _target_scale = 1.0;
    var _duration = 0.4;
    global.Animation.play(id, "image_xscale", _target_scale, _duration, ac_back);
    global.Animation.play(id, "image_yscale", _target_scale, _duration, ac_back);
}