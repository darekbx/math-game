#include <Arduino.h>

class EquationValidator {

  private:
    
    String getValue(String data, char separator, int index);
    bool isMultiplicator(char manipulator);
    bool isAddition(char manipulator);
    bool isSubtraction(char manipulator);

  public:
    EquationValidator();
    bool validate(String equation, int result);
};
