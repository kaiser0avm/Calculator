import 'package:angular/angular.dart';
import 'package:angular/application_factory.dart';

@Controller(
    selector: '[calculator]',
    publishAs: 'CalcCtrl'
)
class CalculatorController {
    String number = "0";
    bool pointFlag = false;
    bool newNumber = false;
    var operation = {"num1":null,"op":null,"num2":null};
    int index = 0;
    
    /*
     * Constructor
     */
    CalculatorController(){
      
    }
    /*
     * Events
     */
    void opClick(String op){
      if(operation["num1"] == null){
        operation["num1"] = double.parse(number);
        number = "0";
      }
      else{
        operation["num2"] = double.parse(number);
      }
      if(operation["op"] == null){
        operation["op"] = op;
      }
      else{
        switch(operation["op"]){
          case "+":
            number = (operation["num1"] + operation["num2"]).toString();
            break;
          case "-":
            number = (operation["num1"] - operation["num2"]).toString();
            break;
          case "*":
            number = (operation["num1"] * operation["num2"]).toString();
            break;
          case "/":
            number = (operation["num1"] / operation["num2"]).toString();
            break;
          case "%":
            number = (operation["num1"] % operation["num2"]).toString();
            break;
          }
          RegExp exp = new RegExp("^[0-9]*\.[0]\$");
          if(exp.hasMatch(number)){
            number = number.replaceAll(".0", "");
          }
          operation = {"num1":double.parse(number),"op":op,"num2":null};
          newNumber = true;
      }
    }
    
    void equalClick(){
      if(operation["num1"] != null && operation["op"] != null){
        operation["num2"] = double.parse(number);
        switch(operation["op"]){
         case "+":
           number = (operation["num1"] + operation["num2"]).toString();
           break;
         case "-":
           number = (operation["num1"] - operation["num2"]).toString();
           break;
         case "*":
           number = (operation["num1"] * operation["num2"]).toString();
           break;
         case "/":
           number = (operation["num1"] / operation["num2"]).toString();
           break;
         case "%":
           number = (operation["num1"] % operation["num2"]).toString();
           break;
        }
        RegExp exp = new RegExp("^[0-9]*\.[0]\$");
        if(exp.hasMatch(number)){
          number = number.replaceAll(".0", "");
        }
        operation = {"num1":double.parse(number),"op":null,"num2":null};
        newNumber = true;
      }
    }
    
    void numClick(String value){
      if(pointFlag){
         number += ("." + value);
         pointFlag = false;
      }
      else if(number == "0" || newNumber){
        number = value;
        newNumber = false;
      }
      else{
        number += value;
      }
    }
    
    void pointClick(){
      pointFlag = true;
    }
    
    void clClick(){
      number = "0";
      operation = {"num1":null,"op":null,"num2":null};
    }
}

class CalculatorModule extends Module{
  CalculatorModule(){
    bind(CalculatorController);
  }
}

void main() {
  applicationFactory().addModule(new CalculatorModule()).run();
}