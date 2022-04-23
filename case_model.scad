// Math game

$fa = 1;
$fs = 0.4;
$fn = 100;

showComponents = false;

keyboardX = 3;
keyboardY = 40;

displayX = 1;
displayY = 0;

// https://openscad.org/cheatsheet/
// % transparent
// ! show only 
// # highlight
// * disable

Case();

if (showComponents) {
    translate([1, 1, 20])
        DisplayPlaceholder();

    translate([3, 40, 20])
        KeyboardPlaceholder();
}

module Case() {
    difference() {
        minkowski() {
            sphere(2.5);
            cube([42, 90, 15]);
        }
        {
            translate([-1, -1, -9]) {
                cube([44, 92, 25]);
            }
            translate([displayX, displayY, 13]) {
                DisplayPlaceholder();
            }
            translate([keyboardX, keyboardY, 13]) {
                KeyboardPlaceholder();
            }
        }
    }
    translate([displayX, displayY, 12]) {
        DisplayMountingBolts();
    }
    translate([keyboardX, keyboardY, 16]) {
        KeyaboardKeys();
    }
}

module KeyaboardKeys() {
    
    offsetLeft = 1; // 1mm
    offsetTop = 2; // 2mm
    vSpace = 3; // 3mm
    hSpace = 3.5; // 3.5mm
    switchSize = 6; // 6mm
    
    for (y = [0:3]) {
        for (x = [0:3]) {       
            translate([
                1.5 + (switchSize + vSpace) * x, 
                2.5 + (switchSize + hSpace) * y, 
                -0.5]
            ) {
                cube([5, 5, 2]);
                translate([1.5, 0, 1]) {
                    cube([2, 7, 1]);
                }
            }
        }
    }
}

module DisplayMountingBolts() {
    width = 405; // 40.5mm
    height = 375; // 37.5mm
    x = 25; // X position offset
    y = 25; // Y position offset
    d = 23; // Diameter of the bolt
    sd = 10; // Screw hole diameter
    h = 40; // Height of the bolt
    scale([0.1, 0.1, 0.1]) {
        difference() {
            translate([x, y, 8]) { cylinder(h, d = d); }
            translate([x, y, 6]) { cylinder(h, d = sd); }
        }
        difference() {
            translate([width - x, y, 8]) { cylinder(h, d = d); }
            translate([width - x, y, 6]) { cylinder(h, d = sd); }
        }
        difference() {
            translate([x, height - y, 8]) { cylinder(h, d = d); }
            translate([x, height - y, 6]) { cylinder(h, d = sd); }
        }
        difference() {
            translate([width - x, height - y, 8]) { cylinder(h, d = d); }
            translate([width - x, height - y, 6]) { cylinder(h, d = sd); }
        }
    }
}

module DisplayPlaceholder() {
    // https://www.waveshare.com/1.3inch-oled-b.htm
    // https://botland.com.pl/wyswietlacze-oled/4441-wyswietlacz-oled-niebieski-graficzny-13-b-128x64px-spi-i2c-proste-zlacza-waveshare-10451-5904422371968.html
    width = 405; // 40.5mm
    height = 375; // 37.5mm
    thickness = 18; // 1.8mm
    d = 25; // Hole diameter, 2.5mm
    x = 25; // Hole X position offset
    y = 25; // Hole Y position offset
    scale([0.1, 0.1, 0.1]) {
        difference() {
            cube([width, height, thickness]);
            {
                translate([x, y, -1]) { cylinder(50, d = d); }
                translate([width - x, y, -1]) { cylinder(50, d = d); }
                translate([x, height - y, -1]) { cylinder(50, d = d); }
                translate([width - x, height - y, -1]) { cylinder(50, d = d); }
            }
        }
        xPos = 25; // 2.5mm
        yPos = 85; // 8mm
        translate([xPos, yPos, 20]) {
            color("black") {
                cube([345, 230, 30]);
            }
        }
    }
}

module KeyboardPlaceholder() {
    width = 395; // 39.5mm
    height = 445; // 44.5mm
    thickness = 18; // 1.8mm
    scale([0.1, 0.1, 0.1]) {
        
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
                        (switchSize + vSpace) * x, 
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