import 'package:flutter/material.dart';

class Becomecustomer extends StatefulWidget {
  const Becomecustomer({Key? key}) : super(key: key);

  @override
  State<Becomecustomer> createState() => _BecomecustomerState();
}

class _BecomecustomerState extends State<Becomecustomer> {
  int currentStep = 0;
  Color myCustomColor = Color.fromRGBO(40, 0, 81, 1);
  bool isCompleted = false;

  List<Step> getSteps() => [
        Step(
          state: currentStep >= 0 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 0,
          title: Text('Vehicule'),
          content: Container(),
        ),
        Step(
          state: currentStep >= 1 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 1,
          title: Text('Pieces'),
          content: Container(),
        ),
        Step(
          state: currentStep >= 2 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 2,
          title: Text('Infos'),
          content: Container(),
        ),
        Step(
          state: currentStep >= 3 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 3,
          title: Text('Complete'),
          content: Container(),
        ),
      ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Image.asset('images/previous.png', height: 10, width: 10),
          style: ButtonStyle(
             backgroundColor:
                  MaterialStateProperty.all(Color.fromRGBO(225, 225, 225, 1))
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Spacer(),
            Text(
              'devenir convoyeur',
              textAlign: TextAlign.end,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 15,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
      body: isCompleted
          ? buildCompleted()
          : Container(
              color: Colors.white,
              child: Theme(
                data: ThemeData(
                  primarySwatch:
                      Colors.deepPurple, // Change this to the color you want
                  //accentColor: Colors.blueAccent, // Change this to the color you want
                  textTheme: TextTheme(
                    bodyText2: TextStyle(
                        color:
                            Colors.black), // Change this to the color you want
                  ),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: Stepper(
                        type: StepperType.vertical,
                        steps: getSteps(),
                        currentStep: currentStep,
                        onStepContinue: () {
                          final isLastStep =
                              currentStep == getSteps().length - 1;
                          if (isLastStep) {
                            setState(() {
                              isCompleted =
                                  true; // Use the assignment operator '=' instead of '=='
                              print('iscompleted');
                            });
                          } else {
                            setState(() => currentStep += 1);
                          }
                        },
                        onStepCancel: () {
                          if (currentStep > 0) {
                            setState(() => currentStep -= 1);
                          }
                        },
                        onStepTapped: (step) => setState(() {
                          currentStep = step;
                        }),
                        controlsBuilder: (BuildContext context,
                            ControlsDetails controlsDetails) {
                          final isLastStep =
                              currentStep == getSteps().length - 1;
                          return Container(
                            margin: EdgeInsets.only(top: 50),
                            child: Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: controlsDetails
                                        .onStepContinue, // Corrected line

                                    child:
                                        Text(isLastStep ? 'Confirm' : 'Next'),
                                  ),
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                if (currentStep != 0)
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: controlsDetails
                                          .onStepCancel, // Corrected line
                                      child: Text('Previous'), // Corrected text
                                    ),
                                  ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  StatelessWidget buildCompleted() {
    return Container(
      color: Colors.white,
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset('images/success.png', width: 200, height: 200),
          )
        ],
      ),
    );
  }
}
