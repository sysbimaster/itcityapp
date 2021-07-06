import 'package:flutter/material.dart';
import 'package:itcity_online_store/components/custom_stepper.dart';

class StepperDialog extends StatefulWidget {
  final bool initiallyShowStepper;

  StepperDialog({Key key, this.initiallyShowStepper = false}) : super(key: key);

  @override
  _StepperDialogState createState() => _StepperDialogState();
}

class _StepperDialogState extends State<StepperDialog> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(0),
      child: ExpansionTile(
        initiallyExpanded: widget.initiallyShowStepper,
        title: Text(
          "Status",
          style: Theme.of(context).textTheme.headline5,
        ),
        children: [
          Theme(
            data: ThemeData(
                accentColor: Colors.red,
                primaryColor: Colors.blue,
                iconTheme: IconThemeData(color: Colors.blue, size: 30),
                backgroundColor: Colors.green),
            child: stepper(),
          )
        ],
      ),
    );
  }

  Widget stepper() {
    return CustomStepper(
        physics: ClampingScrollPhysics(),
        controlsBuilder: (BuildContext context,
            {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
          return Container();
        },
        currentStep: 3,
        steps: [
          CustomStep(
            state: CustomStepState.complete,
            isActive: false,
            title:
                Text("Ordered", style: Theme.of(context).textTheme.headline6),
            subtitle: Text(
              "Your order is placed",
              style: TextStyle(color: Theme.of(context).hintColor),
            ),
            content: Text(""),
          ),
          CustomStep(
            state: CustomStepState.complete,
            title:
                Text("Proccessed", style: Theme.of(context).textTheme.headline6),
            subtitle: Text(
              "Your order have been Processed",
              style: TextStyle(color: Theme.of(context).hintColor),
            ),
            content: Text(""),
          ),
          CustomStep(
            state: CustomStepState.complete,
            title: Text("Shipped",
                style: Theme.of(context).textTheme.headline6),
            subtitle: Text(
              "Your Order is shipped",
              style: TextStyle(color: Theme.of(context).hintColor),
            ),
            content: Text(""),
          ),
          CustomStep(
            isActive: true,
            title: Text("Out for delivery",
                style: Theme.of(context).textTheme.headline6),
            subtitle: Text(
              "Your order is out for delivery",
              style: TextStyle(color: Theme.of(context).hintColor),
            ),
            content: Text(''),
            // Row(
            //   children: [
            //     InkWell(
            //       onTap: () {
            //         Navigator.pushNamed(context, 'deliver-agent-details');
            //       },
            //       child: Text("Delivering by Sanil",
            //           style: Theme.of(context).textTheme.subtitle1.copyWith(
            //               color: Colors.blueAccent,
            //               decoration: TextDecoration.underline)),
            //     )
            //   ],
            // ),
          ),
          CustomStep(
            isActive: false,
            title:
                Text("Delivered", style: Theme.of(context).textTheme.headline6),
            subtitle: Text(
              "Your order have been delivered",
              style: TextStyle(color: Theme.of(context).hintColor),
              overflow: TextOverflow.ellipsis,
            ),
            content: Text(""),
          ),
        ]);
  }
}
