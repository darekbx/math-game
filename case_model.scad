// Math game

$fa = 1;
$fs = 0.4;
$fn = 100;

// https://openscad.org/cheatsheet/
// % transparent
// ! show only 
// # highlight
// * disable

DisplayPlaceholder();

translate([0, 40, 0])
    KeyboardPlaceholder();   

module DisplayPlaceholder() {
    // https://www.waveshare.com/1.3inch-oled-b.htm
    // https://botland.com.pl/wyswietlacze-oled/4441-wyswietlacz-oled-niebieski-graficzny-13-b-128x64px-spi-i2c-proste-zlacza-waveshare-10451-5904422371968.html
    width = 405; // 40.5mm
    height = 375; // 37.5mm
    thickness = 18; // 1.8mm
    scale([-0.1, 0.1, 0.1]) {
        cube([width, height, thickness]);
        xPos = 25; // 2.5mm
        yPos = 85; // 8mm
        translate([xPos, yPos, 20]) {
            color("black") {
            cube([345, 230, 10]);
            }
        }
    }
}

module KeyboardPlaceholder() {
    width = 395; // 39.5mm
    height = 445; // 44.5mm
    thickness = 18; // 1.8mm
    scale([-0.1, 0.1, 0.1]) {
        
        // Board
        color("green") {
            cube([width, height, thickness]);
        }
        
        offsetLeft = 10; // 1mm
        offsetTop = 20; // 2mm
        vSpace = 30; // 3mm
        hSpace = 35; // 3.5mm
        switchSize = 60; // 6mm
        
        translate([offsetLeft, offsetTop, 0]) {
            for (y = [0:3]) {
                for (x = [0:3]) {                     
                    translate([
                        (switchSize +vSpace) * x, 
                        (switchSize + hSpace) * y, 
                        18]
                    ) {
                        TactSwitch(switchSize);
                    }
                }
            }
        }
    }
    
    module TactSwitch(size) {
        height = 32; // 3.2mm
        color("black") {
            cube([size, size, height - 1]);
        }
        translate([0, 0, height - 1]) {
            cube([size, size, 1]);
        }
        translate([30, 30, 30]) {
            cylinder(10, d = 35);
        }
    }
}