import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "My Calculator",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const CalculatorApp(),
    );
  }
}

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({super.key});

  @override
  State<CalculatorApp> createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  String equation = "";
  String eq2 = "";
  String result = "";
  String operand = "";
  String sign = "";
  num num1 = 0;
  num num2 = 0;
  num num3 = 0;

  num ans = 0;

  void buttonPressed(buttonText) {
    setState(() {
      if (buttonText == "+" ||
          buttonText == "-" ||
          buttonText == "X" ||
          buttonText == "/") {
        operand = buttonText;
        equation += buttonText;
        if (eq2.isNotEmpty) {
          num1 = num.parse(eq2);
        }
        eq2 = "";

        if (operand == "+") {
          if (sign == "-") {
            ans -= num1;
          } else if (sign == "X") {
            if (num1 == 0) {
            } else {
              ans *= num1;
            }
          } else if (sign == "/") {
            if (num1 == 0) {
            } else {
              ans /= num1;
            }
          } else {
            ans = ans + num1;
          }
          sign = "+";
        } else if (operand == "-") {
          if (sign == "+") {
            ans += num1;
          } else if (sign == "X") {
            if (num1 == 0) {
            } else {
              ans *= num1;
            }
          } else if (sign == "/") {
            if (num1 == 0) {
            } else {
              ans /= num1;
            }
          } else {
            if (ans == 0) {
              ans = num1;
            } else {
              ans -= num1;
            }
          }
          sign = "-";
        } else if (operand == "X") {
          if (sign == "+") {
            ans += num1;
          } else if (sign == "-") {
            ans -= num1;
          } else if (sign == "/") {
            if (num1 == 0) {
            } else {
              ans /= num1;
            }
          } else {
            if (ans == 0) {
              ans = 1;
              ans *= num1;
            } else if (num1 == 0) {
            } else {
              ans *= num1;
            }
          }
          sign = "X";
        } else if (operand == "/") {
          if (sign == "+") {
            ans += num1;
          } else if (sign == "-") {
            ans -= num1;
          } else if (sign == "X") {
            if (num1 == 0) {
            } else {
              ans *= num1;
            }
          } else {
            if (ans == 0) {
              ans = num1;
            } else if (num1 == 0) {
            } else {
              ans /= num1;
            }
          }
          sign = "/";
        }
      } else if (buttonText == ".") {
        if (eq2.contains(".")) {
        } else {
          equation += buttonText;
          eq2 += buttonText;
        }
      } else if (buttonText == "C") {
        equation = "";
        result = "";
        num1 = 0;
        eq2 = "";
        ans = 0;
        num3 = 0;
        sign = '';
      } else if (buttonText == "DEL") {
        if (equation == "") {
          equation = "0";
        } else if (eq2 == "") {
          equation = "";
          result = "";
          num1 = 0;
          eq2 = "";
          ans = 0;
          num3 = 0;
          sign = '';
        } else {
          equation = equation.substring(0, equation.length - 1);
          eq2 = eq2.substring(0, eq2.length - 1);
        }
      } else if (buttonText == "=") {
        num1 = 0;
        if (eq2.isNotEmpty) {
          num2 = num.parse(eq2);
          if (operand == "+") {
            ans += num2;
          } else if (operand == "-") {
            ans -= num2;
          } else if (operand == "X") {
            ans *= num2;
          } else if (operand == "/") {
            ans /= num2;
          }
        }
        eq2 = "";
      } else {
        equation += buttonText;
        eq2 += buttonText;
      }
      if (ans % 1 == 0) {
        result = ans.toString();
      } else {
        result = ans.toStringAsFixed(2);
      }
    });
  }

  Widget buildButton(
    String buttonText,
    Color buttonColor,
    double buttonHeignt,
  ) {
    return Container(
      margin: const EdgeInsets.all(2),
      height: MediaQuery.of(context).size.height * buttonHeignt * 0.1,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: buttonColor,
      ),
      child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: () => buttonPressed(buttonText),
          child: Text(
            buttonText,
            style: const TextStyle(fontSize: 24, color: Colors.white),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text("My Calculator"),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              alignment: Alignment.topRight,
              color: Colors.white,
              child: Text(
                equation,
                style: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              alignment: Alignment.topRight,
              color: Colors.white,
              child: Text(
                result,
                style: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Expanded(
              child: Divider(
                color: Colors.transparent,
              ),
            ),
            Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: Table(
                    children: [
                      TableRow(
                        children: [
                          buildButton("C", Colors.red, 1),
                          buildButton("DEL", Colors.blue, 1),
                          buildButton("/", Colors.blue, 1),
                        ],
                      ),
                      TableRow(
                        children: [
                          buildButton("7", Colors.black38, 1),
                          buildButton("8", Colors.black38, 1),
                          buildButton("9", Colors.black38, 1),
                        ],
                      ),
                      TableRow(
                        children: [
                          buildButton("4", Colors.black38, 1),
                          buildButton("5", Colors.black38, 1),
                          buildButton("6", Colors.black38, 1),
                        ],
                      ),
                      TableRow(
                        children: [
                          buildButton("1", Colors.black38, 1),
                          buildButton("2", Colors.black38, 1),
                          buildButton("3", Colors.black38, 1),
                        ],
                      ),
                      TableRow(
                        children: [
                          buildButton(".", Colors.black38, 1),
                          buildButton("0", Colors.black38, 1),
                          buildButton("00", Colors.black38, 1),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.24,
                  child: Table(children: [
                    TableRow(children: [
                      buildButton("X", Colors.blue, 1),
                    ]),
                    TableRow(children: [
                      buildButton("-", Colors.blue, 1),
                    ]),
                    TableRow(children: [
                      buildButton("+", Colors.blue, 1),
                    ]),
                    TableRow(children: [
                      buildButton("=", Colors.redAccent, 2),
                    ]),
                  ]),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
