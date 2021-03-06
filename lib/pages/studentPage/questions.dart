import 'package:flutter/material.dart';

class Questions extends StatefulWidget {
  const Questions({Key key}) : super(key: key);

  @override
  _QuestionsState createState() => _QuestionsState();
}

class _QuestionsState extends State<Questions> {
  int currentStep = 0;
  bool complete = false;
  List<Step> steps = [
    Step(
      title: Text("Temperature"),
      content: Text("In this article, I will tell you how to create a page."),
    ),
    Step(
      title: Text("tested..."),
      content: Text("Let's look at its construtor."),
    ),
  ];
  next() {
    currentStep + 1 != steps.length
        ? goTo(currentStep + 1)
        : setState(() => complete = true);
  }

  cancel() {
    if (currentStep > 0) {
      goTo(currentStep - 1);
    }
  }

  goTo(int step) {
    setState(() => currentStep = step);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(children: <Widget>[
        complete
            ? Expanded(
                child: Center(
                  child: AlertDialog(
                    title: new Text("Profile Created"),
                    content: new Text(
                      "Tada!",
                    ),
                    actions: <Widget>[
                      new FlatButton(
                        child: new Text("Close"),
                        onPressed: () {
                          setState(() => complete = false);
                        },
                      ),
                    ],
                  ),
                ),
              )
            : Stepper(
                type: StepperType.vertical,
                currentStep: currentStep,
                steps: steps,
                onStepContinue: next,
                onStepTapped: (step) => goTo(step),
                onStepCancel: cancel,
              ),
      ]),
    ));
  }
}
