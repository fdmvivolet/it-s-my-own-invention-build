// --- ИЗМЕНЕНИЕ ЗДЕСЬ ---
// 1. БАЗОВЫЙ РАЗМЕР НАШЕГО ВИДИМОГО МИРА (9:16)
var base_w = 1080;
var base_h = 1920;
// --- КОНЕЦ ИЗМЕНЕНИЯ ---

// 2. РАЗМЕР ЭКРАНА УСТРОЙСТВА
var display_w = display_get_width();
var display_h = display_get_height();

// 3. РАСЧЕТ СООТНОШЕНИЙ
var base_aspect = base_w / base_h;
var device_aspect = display_w / display_h;

// 4. ЛОГИКА "РЕЗИНОВОЙ" КАМЕРЫ (МЕТОД "РАСШИРЕНИЯ")
var cam_w = base_w;
var cam_h = base_h;

if (device_aspect > base_aspect) {
    // Если экран ШИРЕ нашего (планшет), увеличиваем ширину камеры
    cam_w = base_h * device_aspect;
} else {
    // Если экран ВЫШЕ нашего (длинный телефон), увеличиваем высоту камеры
    cam_h = base_w / device_aspect;
}

// 5. ПРИМЕНЯЕМ НАСТРОЙКИ
view_enabled = true;
view_visible[0] = true;
var camera = view_camera[0];

// Устанавливаем "резиновый" размер камеры
camera_set_view_size(camera, cam_w, cam_h);

// Центрируем камеру в СЕРЕДИНЕ КОМНАТЫ
camera_set_view_pos(camera, room_width/2 - cam_w/2, room_height/2 - cam_h/2);

// Настройка окна

surface_resize(application_surface, display_w, display_h);
window_set_rectangle(0, 0, display_w, display_h);

// --- ИЗМЕНЕНИЕ ЗДЕСЬ ---
// 6. НАСТРОЙКА GUI (теперь на вертикальном холсте 1080x1920)

//display_set_gui_size(base_w, base_h)//;!!
display_set_gui_size(cam_w, cam_h)

// --- КОНЕЦ ИЗМЕНЕНИЯ ---
if webgl_enabled {gpu_set_texfilter(true)} else {gpu_set_texfilter(false)}
font_add_enable_aa(true)
draw_enable_swf_aa(true)


show_debug_message("Rubber Window Portrait Display Manager Initialized.");