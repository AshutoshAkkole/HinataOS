#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>

#if defined (__linux__)
#error "Wrong compiler used"
#endif

#define WIDTH 80
#define HEIGHT 25
#define VGA_START_ADDRESS 0xB8000

enum vga_color {
	VGA_COLOR_BLACK = 0,
	VGA_COLOR_BLUE = 1,
	VGA_COLOR_GREEN = 2,
	VGA_COLOR_CYAN = 3,
	VGA_COLOR_RED = 4,
	VGA_COLOR_MAGENTA = 5,
	VGA_COLOR_BROWN = 6,
	VGA_COLOR_LIGHT_GREY = 7,
	VGA_COLOR_DARK_GREY = 8,
	VGA_COLOR_LIGHT_BLUE = 9,
	VGA_COLOR_LIGHT_GREEN = 10,
	VGA_COLOR_LIGHT_CYAN = 11,
	VGA_COLOR_LIGHT_RED = 12,
	VGA_COLOR_LIGHT_MAGENTA = 13,
	VGA_COLOR_LIGHT_BROWN = 14,
	VGA_COLOR_WHITE = 15,
};


uint8_t give_color(enum vga_color bg_color, enum vga_color font_color){
    return (uint8_t)(font_color | bg_color << 4);
}

size_t string_length(const char* c){
	size_t count = 0;

	while(c[count]){
		count++;
	}

	return count;
}


uint16_t give_char(unsigned char c, uint8_t color){
    return (uint16_t) ( (c | color << 8) | 1<<16);
}

void clear_screen(){

    uint16_t* screen = (uint16_t*) VGA_START_ADDRESS;
    uint8_t color = give_color(VGA_COLOR_BLACK, VGA_COLOR_WHITE);

    for(size_t i =0 ; i < WIDTH; i++){
        for(size_t j=0; j < HEIGHT; j++){
            size_t index = j * WIDTH + i;
            screen[index] = give_char(' ', color);
        }
    }

}

void print_string(const char *data, size_t str_len, uint16_t* address){
	
	uint16_t* screen = (uint16_t*) VGA_START_ADDRESS;
    uint8_t color = give_color(VGA_COLOR_LIGHT_GREY, VGA_COLOR_BLACK);

    for(size_t i =0 ; i < str_len; i++){
		if(data[i] == '\n'){
			screen[WIDTH * 2] = give_char(' ', color);
			return;
		}
		screen[i] = give_char(data[i], color);
    }

}

void big_bang(){

    clear_screen();
	const char* hello_world = "Hello World!\n";
	print_string(hello_world , string_length(hello_world), (uint16_t*)VGA_START_ADDRESS);

}

