import 'package:flutter/material.dart';

enum CalculatorActions {
  none(""),
  equal("="),
  remove("c"),
  summation("+"),
  subtraction("-"),
  division("/"),
  multiplication("x");

  const CalculatorActions(this.symbol);
  final String symbol;
}

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<StatefulWidget> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  double result = 0.0;
  double temp = 0.0;
  CalculatorActions action = CalculatorActions.none;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          title: Text("hello"),
          // leading: IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
        ),
        body: Center(
            child: SizedBox(
          width: 300,
          height: 500,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(result.toString()),
                        ),
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            result = 0.0;
                            action = CalculatorActions.none;
                            temp = 0.0;
                          });
                        },
                        child: const Icon(Icons.delete))
                  ],
                ),
              ),
              GridView.count(
                shrinkWrap: true,
                crossAxisCount: 4,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                children: buttons(),
              ),
            ],
          ),
        )));
  }

  List<Widget> buttons() {
    List<Widget> lst = [];
    lst.add(numberButton(7));
    lst.add(numberButton(8));
    lst.add(numberButton(9));
    lst.add(actionButton(CalculatorActions.subtraction));
    lst.add(numberButton(4));
    lst.add(numberButton(5));
    lst.add(numberButton(6));
    lst.add(actionButton(CalculatorActions.summation));
    lst.add(numberButton(1));
    lst.add(numberButton(2));
    lst.add(numberButton(3));
    lst.add(actionButton(CalculatorActions.multiplication));
    lst.add(actionButton(CalculatorActions.remove));
    lst.add(numberButton(0));
    lst.add(actionButton(CalculatorActions.equal));
    lst.add(actionButton(CalculatorActions.division));

    return lst;
  }

  Widget numberButton(int number) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          result = result * 10 + number;
        });
      },
      child: Text(number.toString()),
    );
  }

  Widget actionButton(CalculatorActions btnAction) {
    return ElevatedButton(
      onPressed: () {
        if (btnAction == CalculatorActions.equal) {
          calculate();
        } else if (btnAction == CalculatorActions.remove) {
          setState(() {
            result = (result ~/ 10.0).toDouble();
          });
        } else {
          setState(() {
            action = btnAction;
            temp = result;
            result = 0.0;
          });
        }
      },
      child: Text(btnAction.symbol),
    );
  }

  void calculate() {
    switch (action) {
      case CalculatorActions.none:
      case CalculatorActions.equal:
      case CalculatorActions.remove:
        break;
      case CalculatorActions.summation:
        result = temp + result;
        break;
      case CalculatorActions.subtraction:
        result = temp - result;
        break;
      case CalculatorActions.division:
        result = temp / result;
        break;
      case CalculatorActions.multiplication:
        result = temp * result;
        break;
    }
    action = CalculatorActions.none;
    temp = 0.0;
    setState(() {});
  }
}
