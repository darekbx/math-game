#include <Arduino.h>
#include <EEPROM.h>
#include <Keypad.h>
#include <U8g2lib.h>
#include <Wire.h>

#include "equation-generator.h"
#include "equation-validator.h"

#undef U8G2_WITH_FONT_ROTATION
#undef U8G2_WITH_UNICODE
#define U8G2_16BIT

#define SOLVED_COUNT_ADDRESS 10 
#define WRONG_COUNT_ADDRESS 12
#define ERASE_MEMORY false
#define ROWS 4
#define COLS 4
#define MAX_LEVEL 50
#define SPLASH_TIME 1000
#define SPLASH "Math Game"
 
byte rowPins[ROWS] = {19, 18, 5, 17};
byte colPins[COLS] = {16, 4, 0, 2};  
 
char keys[ROWS][COLS] = {
  {'x','m','-','='},
  {'2','5','8','>'},
  {'1','4','7','9'},
  {'0','3','6','<'}
};

Keypad keybrd = Keypad(makeKeymap(keys), rowPins, colPins, ROWS, COLS);
U8G2_SSD1306_128X64_NONAME_F_SW_I2C u8g2(U8G2_R0, 22, 21, U8X8_PIN_NONE);

EquationGenerator equationGenerator;
EquationValidator equationValidator;

bool refreshDisplay = false;
bool showSplash = true;

byte maxNumber = 13;
byte minNumber = 2;

byte good = 0;
byte bad = 0;

byte level = 1;

String data = "";
String equation = "";
String summary = "0/0";

u8g2_uint_t width;

void setup(void) {
  
  #if ERASE_MEMORY
    saveInt(SOLVED_COUNT_ADDRESS, 0);
    saveInt(WRONG_COUNT_ADDRESS, 0);
    #endif
    
  good = readInt(SOLVED_COUNT_ADDRESS);
  bad = readInt(WRONG_COUNT_ADDRESS);
  
  u8g2.begin();
  
  randomSeed(analogRead(0));
  
  generateEquation();
  refreshDisplay = true;
}

void loop(void) {
  if (showSplash) {
    splashScreen();
    showSplash = false;
  } else {
    gameScreen();
  }
}

void splashScreen() {    
  u8g2.clearBuffer();
  u8g2.setFont(u8g2_font_helvB10_tf); 
  u8g2.drawStr(26, 38, SPLASH);
  u8g2.sendBuffer();
  
  delay(SPLASH_TIME);
}

void gameScreen() {
  handleButtons();

  if (refreshDisplay) {    
    u8g2.clearBuffer();
    
    u8g2.setFont(u8g2_font_helvB10_tf); 
    u8g2.drawStr(2, 14, equation.c_str());
    
    u8g2.setFont(u8g2_font_helvR24_tf); 
    u8g2.drawStr(2, 46, data.c_str());
    
    u8g2.setFont(u8g2_font_helvR08_tf); 
    
    // Good/bad summary
    summary = String(good) + "/" + String(bad);
    width = u8g2.getUTF8Width(summary.c_str());
    u8g2.drawStr((128 - width) / 2, 64, summary.c_str());

    u8g2.drawLine(0, 52, 128, 52);
    
    u8g2.sendBuffer();
    
    refreshDisplay = false;
  }
}

void handleButtons() {
  char c = keybrd.getKey();
  if (!c) return;
  
  if (c == 'm') {
    generateEquation();
    data = "";
  } else if (c == 'x' && data.length() > 0) {
    data.remove(data.length() - 1, 1);
  } else if (c == '=') {
    handleResult();
  } else {
    data += String(c);
  }
  
  refreshDisplay = true;
}

void handleResult() {
  if (data == "") {
    return;
  }

  bool isNegative = false;
  if (data[0] == '-') {
    isNegative = true;
    data.remove(0, 1);
  }

  bool result= equationValidator.validate(
    equation, isNegative ? -data.toInt() : data.toInt()
  );

  if (result) {
    good++;
  } else {
    bad++;
  }
  
  saveInt(SOLVED_COUNT_ADDRESS, good);
  saveInt(WRONG_COUNT_ADDRESS, bad);
    
  generateEquation();
  data = "";
}

void generateEquation() {
  randomSeed(analogRead(random(3)));
  delay(random(10));
  equation = equationGenerator.generate(level);
}

void saveInt(int address, int number) { 
  EEPROM.write(address, number >> 8);
  EEPROM.write(address + 1, number & 0xFF);
}

int readInt(int address) {
  return (EEPROM.read(address) << 8) + EEPROM.read(address + 1);
}
