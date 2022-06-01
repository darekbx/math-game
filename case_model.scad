// Math game

$fa = 1;
$fs = 0.4;
$fn = 100;

showComponents = false;
flat = true;
noKeyboard = true;
noKeys = true;
noDisplay = false;

keyboardX = 0;
keyboardY = 40;

displayX = 1;
displayY = 0;

// https://openscad.org/cheatsheet/
// % transparent
// ! show only 
// # highlight
// * disable

difference() {
    Case();
    {
        if (noKeyboard) {
            translate([-10, 38, -5]) {
                cube([60, 80, 25]);
            }
        }
        if (noDisplay) {
            translate([-10, -10, -5]) {
                cube([60, 49, 25]);
            }
            translate([-10, 86, -5]) {
                cube([60, 30, 25]);
            }
        }
        if (flat) {            
            translate([-10, 86, 0]) {
                cube([60, 20, 20]);
            }
        }
    }
}

if (showComponents) {
    translate([displayX, displayY, 12])
        DisplayPlaceholder();

    translate([keyboardX, keyboardY, 11])
        KeyboardPlaceholder();
}

module Case() {
    difference() {
        minkowski() {
            sphere(2.2);
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
            translate([keyboardX, keyboardY, 10]) {
                KeyboardPlaceholder();
            }
            if (flat) {
                translate([-10, -10, -5]) {
                    cube([60, 110, 20]);
                }
            }
        }
    }
    translate([displayX, displayY, 12]) {
        DisplayMountingBolts();
    }
    translate([displayX, displayY, 12]) {
        DisplayFrame();
    }
    translate([keyboardX + 4.5, keyboardY, 15.7]) {
        if (!noKeys) {
            KeyboardKeys();
        }
    }
    KeyboardMounting();
}

module DisplayFrame() {
    frameHeight = 10;
    xPos = 30; // 2.5mm
    yPos = 85; // 8mm
    width = 350 - 20;
    height = 230 - 20;
        scale([0.1, 0.1, 0.1]) {
            translate([xPos - 5, yPos - 5, 30]) {
                
                difference() {
                    translate([0, 0, 0]) {
                        rotate([90, 0, 0]) {
                            translate([5, 12, -240]) {
                                cylinder(h = 240, d = 20);
                            }
                            translate([355, 12, -240]) {
                                cylinder(h = 240, d = 20);
                            }
                        }
                        rotate([90, 0, 90]) {
                            translate([5, 12, 5]) {
                                cylinder(h = 350, d = 20);
                            }
                            translate([235, 12, 5]) {
                                cylinder(h = 350, d = 20);
                            }
                        }
                    }
                    translate([-50, -20, -90]) {
                        cube([500, 340, 100]);
                    }
                }
                difference() {
                    cube([width + 30, height + 30, frameHeight]);
                    translate([15, 15, -40]) {
                        cube([width, height, 80]);
                    }
                }
            }
    }
}

module KeyboardMounting() {
    // Front wall
    translate([keyboardX - 2, keyboardY - 1.5, 8]) {
        cube([46, 1.2, 8]);
    }
    // Back wall
    translate([keyboardX - 2, keyboardY + 44.5, 8]) {
        cube([46, 1.2, 8]);
    }
    
    translate([keyboardX - 2, keyboardY - 0.5, 8]) {
        Mounting1();
    }
    translate([keyboardX - 2, keyboardY + 40, 8]) {
        Mounting1();
    }
    
    translate([keyboardX + 39.5, keyboardY + 2, 8]) {
        Mounting2();
    }
    translate([keyboardX + 39.5, keyboardY + 38, 8]) {
        Mounting2();
    }
    
    module Mounting1() {
        cube([2, 5, 8]);
        translate([1, 0, 0]) {
            cube([2, 5, 2]);
        }
    }
    
    module Mounting2() {
        cube([1.5, 5, 8]);
        translate([-1, 0, 0]) {
            difference() {
                translate([-0.25, 0, 0]) {
                    cube([2, 5, 2]);
                }
                translate([-2, -0.5, 0.25]){
                    rotate([0, 45, 0]) {
                        cube([3, 6, 2]);
                    }
                }
            }
        }
    }
}

module KeyboardKeys() {
    vSpace = 3; // 3mm
    hSpace = 3.5; // 3.5mm
    switchSize = 6; // 6mm
    
    labelIndex = 0;
    labels = [
        ["<", "9", "8", "7"],
        ["-", "6", "5", "4"],
        ["", "3", "2", "1"],
        ["=", "", "0", ""]
    ];
    
    for (y = [0:3]) {
        for (x = [0:3]) {       
            translate([
                1.5 + (switchSize + vSpace) * x, 
                2.5 + (switchSize + hSpace) * y, 
                -0.0]
            ) {
                difference() {
                    {
                        if (labels[y][x] == "") {
                            translate([-1, -1, 0.3]) {
                                cube([8, 8, 1.2]);
                            }
                        } else {
                            cube([5, 5, 1.5]);
                            translate([1.5, 0, 1]) {
                                cube([2, 7, 0.5]);
                            }
                        }
                    }
                    translate([3.5, 4, 1]) {
                        rotate(180, [0,0,1])
                        linear_extrude() text(text = labels[y][x], size = 3);
                    }
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
    d = 27; // Diameter of the bolt
    sd = 12; // Screw hole diameter
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
    thickness = 15; // 1.8mm
    d = 30; // Hole diameter, 3mm
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
        xPos = 30; // 2.5mm
        yPos = 85; // 8mm
        translate([xPos, yPos, 20]) {
            color("black") {
                cube([350, 230, 30]);
            }
        }
    }
}

module KeyboardPlaceholder() {
    width = 394; // 39.4mm
    height = 441; // 44.1mm
    thickness = 15; // 1.5mm
    scale([0.1, 0.1, 0.1]) {
        
        // Board
        color("green") {
            cube([width, height, thickness]);
        }
        
        offsetLeft = 35; // 5.5mm
        offsetTop = 20; // 2mm
        vSpace = 36; // 3.6mm
        hSpace = 28; // 2.8mm
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