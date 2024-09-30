import 'package:flutter/material.dart';
import 'buttons.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculations extends StatefulWidget {
  const Calculations({super.key});

  @override
  State<Calculations> createState() => _CalculationsState();
}

class _CalculationsState extends State<Calculations> {
  var userInput = '';
  var answer = '';
  
  //Array of button
  final List<String> buttons = [
    'C',
    '+/-',
    '%',
    'DEL',
    '7',
    '8',
    '9',
    '/',
    '4',
    '5',
    '6',
    'x',
    '1',
    '2',
    '3',
    '-',
    '0',
    '.',
    '=',
    '+',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Calculator"),
      ),
      backgroundColor: const Color.fromARGB(162, 89, 83, 83),
      body: Column(
        children: [
          Expanded(
            child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container( 
                    padding: EdgeInsets.all(20),
                    alignment: Alignment.centerRight,
                    child: Text(
                      userInput,
                      style: TextStyle(fontSize: 18,
                      color: const Color.fromARGB(255, 255, 255, 255)),
                      ),
                  ),
                  Container(
                    padding: EdgeInsets.all(15),
                    alignment: Alignment.centerRight,
                    child: Text(
                      answer,style: TextStyle(fontSize: 30,color: Colors.white,fontWeight: FontWeight.bold),),
                  )
              ]),
            ),
          ),
          Expanded(flex: 3,
          child: Container(
            child: GridView.builder(itemCount: buttons.length,gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
            itemBuilder: (BuildContext context, int index){
              // clear button
              if(index==0){
                return MyButton(
                  buttontapped: (){
                    setState(() {
                      userInput = '';
                      answer = '0';
                    });
                  },
                  buttonText: 
                  buttons[index],
                  color: const Color.fromARGB(255, 55, 187, 216),
                  textColor: Colors.black,
                );
              }

              // +/- Button
              else if(index == 1){
                return MyButton(buttonText: 
                buttons [index],
                color: const Color.fromARGB(255, 55, 187, 216),
                textColor: Colors.black,
                );
              }
              // % Button
              else if(index == 2){
                return MyButton(buttontapped:(){
                  setState(() {
                    userInput += buttons[index];
                  });
                }, 
                buttonText: buttons[index],
                color: const Color.fromARGB(255, 55, 187, 216),
                textColor: Colors.black,
                );
              }

              // Delete BUtton
              else if(index == 3){
                return MyButton(buttontapped: (){
                  setState(() {
                    userInput = userInput.substring(0, userInput.length - 1);
                  });
                },
                buttonText: buttons[index],
                color: const Color.fromARGB(255, 221, 237, 7),
                textColor: Colors.black,
                );
              }
              // Equal_to Button
              else if(index == 18){
                return MyButton(buttontapped: (){
                  setState(() {
                    equalPressed();
                  });
                },
                buttonText: buttons[index],
                color: const Color.fromARGB(255, 76, 210, 244),textColor: Colors.white,
                );
              }

              //Other buttons
              else{
                return MyButton(buttontapped: (){
                  setState(() {
                    userInput += buttons[index];
                  });
                },
                buttonText: buttons[index],
                color: isOperator(buttons[index])?const Color.fromARGB(255, 89, 176, 239):Colors.white,
                textColor: isOperator(buttons[index])?Colors.white:Colors.black,
                );
              }
            },
            ),
          ),
          )
        ],
      ),
    );
  }
  
bool isOperator(String x){
  if(x == '/' || x =='x' || x =='-' || x =='+' || x =='='){
    return true;
  }
  return false;
}
// function to calculate the input operation
void equalPressed(){
  String finalUserinput = userInput;
  finalUserinput = userInput.replaceAll('x', '*');
  Parser p = Parser();
  Expression exp = p.parse(finalUserinput);
  ContextModel cm = ContextModel();
  double eval = exp.evaluate(EvaluationType.REAL, cm);
  answer = eval.toString();
}

}