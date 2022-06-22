#include "equation-generator.h"

EquationGenerator::EquationGenerator() {
  this->initialValue = 4;
  this->modificators[0] = '+';
  this->modificators[1] = '-';
  this->modificators[2] = '*';
}

String EquationGenerator::generate(byte level) {
  randomSeed(analogRead(0));
  
  byte maximum = initialValue + level;
  byte minimum = 1 + level;
  
  byte minimumFirst = minimum - 1;
  byte minimumSecond = minimum + 1;
  byte minimumThird = minimum;
  
  char firstModificator = this->randomModificator();
  char secondModificator = this->randomModificator();

  if (level <= 2) {
    firstModificator = '+';
  }

  if (firstModificator == '*' && secondModificator == '*' && level < 10) {
    secondModificator = '-';
  }
  
  byte firstNumber = this->randomNumber(minimumFirst, maximum);
  byte secondNumber = this->randomNumber(minimumSecond, maximum);
  byte thirdNumber = this->randomNumber(minimumThird, maximum);

  return
    String(firstNumber) 
    + " "
    + firstModificator 
    + " "
    + String(secondNumber) 
    + " "
    + secondModificator 
    + " "
    + String(thirdNumber);
}

char EquationGenerator::randomModificator() {
  return this->modificators[random(MODIFICATORS_SIZE)];
}

char EquationGenerator::randomAddSubModificator() {
  return this->modificators[random(MODIFICATORS_SIZE - 1)];
}

byte EquationGenerator::randomNumber(byte minimum, byte maximum) {
  return random(minimum, (minimum + maximum));
}
