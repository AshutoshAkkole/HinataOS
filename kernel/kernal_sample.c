

void main() {
    volatile unsigned short* vga = (unsigned short*)0xB8000;
    vga[0] = 0x0758; // 'X' + white-on-black
    while (1);
}
