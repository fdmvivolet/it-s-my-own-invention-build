// --- obj_tile: Clean Up Event ---
/// @description Уничтожаем актив, если он есть на ячейке

if (instance_exists(asset_instance_id)) {
    instance_destroy(asset_instance_id);
}