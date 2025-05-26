shader_type canvas_item;
uniform float scroll_speed;
void vertex() {
	UV.x +=TIME*scroll_speed;
	UV.y+=TIME*scroll_speed;
}



//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
