/// @description Insert description here
// You can write your code in this editor
function GetMessage(_data){
	
	var _message = _data.message 
	show_debug_message("Получено сообщение: " + string(_message))
	
}

function Deactivate(){
		EventBusBroadcast(EVENT_NAMES.DEACTIVATE_RECIEVER, {})
		EventBusUnsubscribe(EVENT_NAMES.SEND_MESSAGE, id)
}

is_pressed = false
EventBusSubscribe(EVENT_NAMES.SEND_MESSAGE, id, GetMessage)