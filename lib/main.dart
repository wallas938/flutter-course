import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

const userName = 'USER';

void main() {
  runApp(const MaterialApp(home: DynamicBackground()));
  // runApp(const MaterialApp(home: RowsAndColumns()));
  // runApp(const MaterialApp(home: SimpleStatelessWidget()));
  // runApp(const MaterialApp( home: Scaffold( body: Center( child: UserButton()))));
}

class DynamicBackground extends StatefulWidget {
  const DynamicBackground({super.key});

  @override
  State<DynamicBackground> createState() => _DynamicBackgroundState();
}

class _DynamicBackgroundState extends State<DynamicBackground> {
  bool isButtonPressed = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: GestureDetector(onTap: () {
        setState(() {
          isButtonPressed = !isButtonPressed;
          print(isButtonPressed);
        });
      },
        child: Container(color: getColor()),
      ),
    );
  }

  Color getColor() => isButtonPressed ? Colors.red : Colors.blue;
}

class RowsAndColumns extends StatelessWidget {
  const RowsAndColumns({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            width: 100,
            height: 100,
            color: Colors.red,
            // margin: const EdgeInsets.fromLTRB(0, 0, 8.0, 0),
          ),
          Container(
            width: 100,
            height: 100,
            color: Colors.blue,
            // margin: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
          ),
          Container(
            width: 100,
            height: 100,
            color: Colors.green,
            // margin: const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
          ),
        ],
      ),
    ));
  }
}

class UserButton extends StatelessWidget {
  const UserButton({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: () {
        print("The userButton was tapped!");
      },
      child: Container(
        height: 60.0,
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0), color: Colors.red[600]),
        child: const Center(
          child: Text("CLICK HERE!"),
        ),
      ),
    );
  }
}

class SimpleStatelessWidget extends StatelessWidget {
  const SimpleStatelessWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('App Bar Title'),
          backgroundColor: Colors.amber,
        ),
        body: const Center(
          child: Text('Text in a Child Widget in the main body'),
        ));
  }
}
