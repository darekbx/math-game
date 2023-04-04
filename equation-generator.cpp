#include "equation-generator.h"

EquationGenerator::EquationGenerator() {
  this->initialValue = 4;
  this->modificators[0] = '*';
  this->modificators[1] = '*';
  this->modificators[2] = '*';
}

String EquationGenerator::generate(byte level) {
  randomSeed(analogRead(0));
  
  byte firstNumber = this->randomNumber(1, 9);
  byte secondNumber = this->randomNumber(1, 9);

  return
    String(firstNumber) 
    + " "
    + " * " 
    + " "
    + String(secondNumber);
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
