import 'package:flutter/material.dart';

const userName = 'USER';

List<Todo> todos = [
  Todo("Paint House", "Paint it black"),
  Todo("Pet the Dog", "Use a comb to brush as well"),
  Todo("Go to Moon", "Don't forget to use rockets!")
];

void main() {
  // Sert a déclarer des variables null sans avoir a leur assigner de valeurs;
  int? nullableVar;

  // Sert a assigner une valeur une valeur a une variable nullable uniquement si elle est null
  nullableVar ??= 100;

  // Sert a déclarer une variable sans lui assigner de valeur a condition de ne pas l'utiliser avant !
  late String mustBeAssignedVar;

  //print(mustBeAssignedVar); = error car pas encore assignée

  mustBeAssignedVar = "New value";

  print(mustBeAssignedVar);

  runApp(const MyApp());
  // runApp(const MaterialApp(home: Counter()));
  // runApp(const MaterialApp(home: DynamicBackground()));
  // runApp(const MaterialApp(home: RowsAndColumns()));
  // runApp(const MaterialApp(home: SimpleStatelessWidget()));
  // runApp(const MaterialApp( home: Scaffold( body: Center( child: UserButton()))));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // return const MaterialApp(home: MyTextField());
    // return const MaterialApp(home: MyListBuilderView());
    // return MaterialApp(title: "Flutter Tutorial", home: TodosListScreen(todos: todos));
    return const MaterialApp(title: "Return Data", home: HomeScreen());
  }
}

/*
* Navigation with data
* */

// Returning data with Navigator.pop()

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selection = 'None';

  void _onGoToOption() async {
    final choice = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => const SelectionScreen()));

    setState(() {
      _selection = choice ?? "None";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select an Option"),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("Your Selection: $_selection"),
          const SizedBox(height: 20),
          ElevatedButton(
              onPressed: _onGoToOption,
              child: const Text("Go to Option Screen"))
        ],
      )),
    );
  }
}

class SelectionScreen extends StatelessWidget {
  const SelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String opt1 = "OPTION ONE";
    String opt2 = "OPTION TWO";
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select an Option"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, opt1);
                },
                child: Text(opt1)),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, opt2);
                },
                child: Text(opt2))
          ],
        ),
      ),
    );
  }
}

// Sending data with Navigator.push()

class TodosListScreen extends StatelessWidget {
  final List<Todo> todos;

  const TodosListScreen({super.key, required this.todos});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo List"),
      ),
      body: ListView.builder(
          itemCount: todos.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(todos[index].title),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TodoDetail(todo: todos[index])));
              },
            );
          }),
    );
  }
}

class TodoDetail extends StatelessWidget {
  final Todo todo;

  const TodoDetail({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(todo.title),
      ),
      body: Center(
        child: Text(todo.description),
      ),
    );
  }
}

class Todo {
  final String title;
  final String description;

  Todo(this.title, this.description);
}

/*
* Drawer Widget
* */

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            "Drawer widget exemple",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.blueAccent),
      drawer: Drawer(
        child: ListView(
          children: [
            const SizedBox(
              height: 60.0,
              child: DrawerHeader(
                decoration: BoxDecoration(color: Colors.redAccent),
                child: Text("Drawer Header"),
              ),
            ), // Sert a gerer les dimension d'un widget en ligne?
            ListTile(
              title: const Text("First Screen"),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const FirstScreen()));
              },
            ),
            ListTile(
              title: const Text("Second Screen"),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SecondScreen()));
              },
            )
          ],
        ),
      ),
      body: const Center(
        child: Text("My Home Page"),
      ),
    );
  }
}

/*
* Simple Navigation with Widgets
* */

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My first screen"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const SecondScreen();
            }));
          },
          child: const Text("Go to second Screen"),
        ),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Second screen"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Retour au précédant écran
            Navigator.pop(context);
          },
          child: const Text("Go to first screen"),
        ),
      ),
    );
  }
}

/*
* Widget Stateless & Stateful part
* */

// Dynamic List

class MyListBuilderView extends StatelessWidget {
  const MyListBuilderView({super.key});

  static const items = ["item1", "item2", "item3"];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Example",
      home: Scaffold(
        appBar: AppBar(
          title: const Text("App Bar Title"),
        ),
        body: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];

            return ListTile(
              title: Text(item),
              onTap: () {
                print("You just tapped on $item");
              },
            );
          },
        ),
      ),
    );
  }
}

class MyListView extends StatefulWidget {
  const MyListView({super.key});

  @override
  State<MyListView> createState() => _MyListView();
}

class _MyListView extends State<MyListView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My List View"),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text("Person One"),
            // subtitle: const  Text("email@one.fr"),
            // trailing: const  Icon(Icons.arrow_forward),
            onTap: () => print("ListTile 1 was Tapped!"),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text("Person Two"),
            // subtitle: const  Text("email@one.fr"),
            // trailing: const  Icon(Icons.arrow_forward),
            onTap: () => print("ListTile 2 was Tapped!"),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text("Person Three"),
            // subtitle: const  Text("email@one.fr"),
            // trailing: const  Icon(Icons.arrow_forward),
            onTap: () => print("ListTile 3 was Tapped!"),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text("Person Four"),
            // subtitle: const  Text("email@one.fr"),
            // trailing: const  Icon(Icons.arrow_forward),
            onTap: () => print("ListTile 4 was Tapped!"),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text("Person Five"),
            // subtitle: const  Text("email@one.fr"),
            // trailing: const  Icon(Icons.arrow_forward),
            onTap: () => print("ListTile 5 was Tapped!"),
          ),
        ],
      ),
    );
  }
}

/*
* Stateful Widgets Part
* */

// Dialog Box Displaying

class MyDialogBox extends StatefulWidget {
  const MyDialogBox({super.key});

  @override
  State<MyDialogBox> createState() => _MyDialogBox();
}

class _MyDialogBox extends State<MyDialogBox> {
  String _inputText = "";

  void _showInputDialog() {
    showDialog(
        context: context,
        builder: (context) {
          TextEditingController controller = TextEditingController();

          return AlertDialog(
            title: const Text("Enter some text!"),
            content: TextField(
              controller: controller,
              decoration: const InputDecoration(hintText: 'Enter Some text'),
            ),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("Cancel")),
              TextButton(
                  onPressed: () {
                    setState(() {
                      _inputText = controller.text;
                    });
                    Navigator.of(context).pop();
                  },
                  child: const Text("Save"))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("My new App!"),
        ),
        body: Center(
            child: Text(_inputText.isEmpty
                ? "Tap the icon to enter text"
                : "You entered $_inputText")),
        floatingActionButton: FloatingActionButton(
          onPressed: _showInputDialog,
          backgroundColor: Colors.black,
          child: const Icon(
            Icons.edit,
            color: Colors.red,
          ),
        ));
  }
}

// TextField Use

class MyTextField extends StatefulWidget {
  const MyTextField({super.key});

  @override
  State<MyTextField> createState() => _MyTextField();
}

class _MyTextField extends State<MyTextField> {
  String _inputText = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("App bar $_inputText !"),
      ),
      body: Center(
        child: TextField(
          decoration: const InputDecoration(
            hintText: "Enter some text here!",
          ),
          onChanged: (value) {
            setState(() {
              _inputText = value;
            });
          },
        ),
      ),
      bottomSheet: Container(
        alignment: Alignment.center,
        height: 50,
        child: Text("You typed: $_inputText"),
      ),
    );
  }
}

// SetState use for updating states

class Counter extends StatefulWidget {
  const Counter({super.key});

  @override
  State<Counter> createState() {
    return _CounterState();
  }
}

class _CounterState extends State<Counter> {
  int _count = 0;

  void _increment() {
    setState(() {
      _count++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: Center(
            child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(onPressed: _increment, child: const Text("Push Me!")),
        Text("You pressed the button $_count times")
      ],
    )));
  }
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
      body: GestureDetector(
        onTap: () {
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

/*
* Stateless Widgets Part
* */

// Rows & Column Widget Handling

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

// Button action

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

// Simple Widget Displaying

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
