// ignore_for_file: unused_local_variable

import "dart:js";

import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class calculator extends StatefulWidget{
  @override
  State<calculator> createState() => _calculatorState();
}

class _calculatorState extends State<calculator> {
  String userInput = "";
  String result = "0"; 


  List <String> buttonList = [
    'AC',
    'sin',
    '√',
    '/',
    '7',
    '8',
    '9',
    '*',
    '4',
    '5',
    '6',
    '+',
    '1',
    '2',
    '3',
    '-',
    'C',
    '0',
    '.',
    '=',



  ];
  @override
  Widget build(BuildContext context){


  return Scaffold(
    backgroundColor: Color(0xFF1d2630),
    body:Column(
      children: [
      SizedBox(
        height: MediaQuery.of(context).size.height / 3,
        child:Column(mainAxisAlignment: MainAxisAlignment.end, children: [
          Container(
          padding: EdgeInsets.all(20) ,
          alignment: Alignment.centerRight,
          child: Text(
            userInput,
            style: TextStyle(
              fontSize:25,
              color: Colors.white,

            ),
          ),
        ),
          Container(
          padding: EdgeInsets.all(10) ,
          alignment: Alignment.centerRight,
          child: Text(
            result,
            style: TextStyle(
              fontSize:30,
              color: Colors.white,
              fontWeight: FontWeight.bold,

              ),
            ),
          ),
        ]),
      ),
      Divider(color: Colors.white),

      Expanded(child: Container(
        padding: EdgeInsets.all(10),
        child: GridView.builder(
          itemCount:buttonList.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12, 
          ),
          itemBuilder: (BuildContext context, int index){
            return CustomButton(buttonList[index]);
            },
          ),
         ),
        ),
      ],
    ),
  ); 
}
    Widget CustomButton(String text) {
    // Representa el botón "√" como una cadena única
    String buttonText = (text == "√") ? "SQRT" : text;

    return InkWell(
      splashColor: Color(0xFF1d2630),
      onTap: () {
        setState(() {
          handleButtons(buttonText); // Pasa el texto modificado a la función handleButtons
      });
    },
      child: Ink(
        decoration: BoxDecoration(
          color: getBgColor(text),
          borderRadius: BorderRadius.circular(10),
          boxShadow:[
            BoxShadow(
              color: Colors.white.withOpacity(0.1),
              blurRadius: 4,
              spreadRadius: 0.5,
              offset: Offset(-3, -3),
            )
          ]
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: getColor(text),
              fontSize:20,
              fontWeight: FontWeight.bold,
               ),
          ), 
          ),
      ),
    );
    

  }
  


        getColor(String text) {
        if (text == "/" || 
        text == "*" ||
        text == "+" ||
        text == "-" ||
        text == "C" ||
        text == "(" ||
        text == ")"){
          return Color.fromARGB(255, 252, 100, 100);//Color de las funciones getColor
      }
      
        return Colors.white;
      }
      



      getBgColor(String text) {
        if (text == "AC"){
          return Color.fromARGB(255, 252, 100, 100);//Color de las funciones getBgColor
      }
         if (text == "="){
          return Color.fromARGB(255, 104, 204, 159);//Color del =
      }
      if (text == "sin") {
        Color.fromARGB(255, 100, 200, 250); // Color para el botón "sin"
}

          return Color(0xFF1d2630);
    }
    
          handleButtons(String text) {
            if (text == "AC") {
              userInput = "";
              result = "0";
              return;
            }

            if (text == "C") {
              // este boton eliminar el último carácter 
              if (userInput.isNotEmpty) {
                userInput = userInput.substring(0, userInput.length - 1);
              } else {
                return null; 
              }
            }

            if (text == "=") {
              // esta funsionlo que hace es agregar paréntesis de cierre si es necesario
              int openParenthesesCount = userInput.split('(').length - 1;
              int closeParenthesesCount = userInput.split(')').length - 1;

              for (int i = 0; i < openParenthesesCount - closeParenthesesCount; i++) {
                userInput += ')';
              }

              
              result = calculate();
              userInput = result;

              
              if (userInput.endsWith(".0")) {
                userInput = userInput.replaceAll(".0", "");
              }

              if (result.endsWith(".0")) {
                result = result.replaceAll(".0", "");
              }

              return;
            }
            if (text == "√" || text == "SQRT") {
                // Botón "√" o "SQRT" - Agregar "sqrt(" a la entrada
                userInput = userInput + "sqrt(";
                return;
            }



            if (text == "sin") {
              userInput = userInput + "sin(";
              return;
            }

            userInput = userInput + text;
          }

              
    
        String calculate(){
          try {
            var exp = Parser().parse(userInput);
            var evaluation = exp.evaluate(EvaluationType.REAL, ContextModel());
            return evaluation.toString();
          } catch(e){
            return "Error";
          }
          
          // ignore: dead_code
          String calculate() {
            try {
              var modifiedExpression = userInput.replaceAll("sin(", "sin(");
              var exp = Parser().parse(modifiedExpression);
              var evaluation = exp.evaluate(EvaluationType.REAL, ContextModel());
              return evaluation.toString();
            } catch (e) {
              return "Error";
            }

          String calculate() {
              try {
                var modifiedExpression = userInput.replaceAll("sin(", "sin(").replaceAll("sqrt(", "sqrt(");
                var exp = Parser().parse(modifiedExpression);
                var evaluation = exp.evaluate(EvaluationType.REAL, ContextModel());
                return evaluation.toString();
              } catch (e) {
                return "Error";
              }
            }
          }
        }
      }
