
#include <Arduino.h>

#define MODIFICATORS_SIZE 3

class EquationGenerator {

  private:
    byte initialValue;
    char modificators[MODIFICATORS_SIZE];
    
    char randomModificator();
    char randomAddSubModificator();
    byte randomNumber(byte minimum, byte maximum);

  public:
    EquationGenerator();
    String generate(byte level);
};
