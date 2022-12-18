import 'dart:io';

import 'package:flutter/material.dart';
import 'package:code_editor/code_editor.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool showAnalysis = false;

  @override
  Widget build(BuildContext context) {
    // example of a easier way to write code instead of writing it in a single string
    List<String> contentOfPage1 = [
      "import 'package:flutter/material.dart';",
      "void main() => runApp(MyApp());",
      "class MyApp extends StatelessWidget {",
      "\t@override",
      "\tWidget build(BuildContext context) {",
      "\t\treturn MaterialApp(",
      "\t\t\ttitle: 'Material App',\n"
          "\t\t\t\thome: Scaffold(",
      "\t\t\t\t\tappBar: AppBar(\n"
          "\t\t\t\t\t\ttitle: Text('Material App Bar'),",
      "\t\t\t\t\t),",
      "\t\t\tbody: Center(",
      "\t\t\t\tchild: Container(",
      "\t\t\t\t\tchild: Text('Hello World'),",
      "\t\t\t\t),",
      "\t\t\t),",
      "\t\t),",
      "\t);",
      "}",
    ];

    // The files displayed in the navigation bar of the editor.
    // You are not limited.
    // By default, [name] = "file.${language ?? 'txt'}", [language] = "text" and [code] = "",
    List<FileEditor> files = [
      FileEditor(
        name: "main.dart",
        language: "dart",
        code: contentOfPage1.join("\n"), // [code] needs a string
      ),
      // FileEditor(
      //   name: "page2.html",
      //   language: "html",
      //   code: "<a href='page1.html'>go back</a>",
      // ),
      // FileEditor(
      //   name: "style.css",
      //   language: "css",
      //   code: "a { color: red; }",
      // ),
    ];

    // The model used by the CodeEditor widget, you need it in order to control it.
    // But, since 1.0.0, the model is not required inside the CodeEditor Widget.
    EditorModel model = EditorModel(
      files: files, // the files created above
      // you can customize the editor as you want
      styleOptions: EditorModelStyleOptions(
        fontSize: 13,
      ),
    );

    // A custom TextEditingController.
    final myController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text("CodeXeR")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
              onPressed: () {
                setState(() {
                  showAnalysis = true;
                });
              },
              child: const Text("Submit to Analyze")),
          const SizedBox(
            height: 10,
          ),
          showAnalysis
              ? SizedBox(
                  height: 200,
                  child: SingleChildScrollView(
                    child: textWidget(
                      """
This code is a Flutter app that displays a simple "Hello World" message on the screen.

The main() function is the entry point of the app, and it calls runApp() to run the app. runApp() takes in a widget, which in this case is an instance of the MyApp class.

MyApp is a subclass of the StatelessWidget class and represents the root of the widget tree. It has a build() method that returns a MaterialApp widget, which is a convenience widget that displays a material design app.

The MaterialApp widget has a title and a home property, which are respectively set to 'Material App' and a Scaffold widget. The Scaffold widget is a basic layout element in material design that provides a standard app bar and a body, which is where the content of the app is displayed.

The app bar has a title that reads 'Material App Bar' and the body contains a single widget, a Container widget that contains a Text widget that displays the "Hello World" message.

""",
                    ),
                  ),
                )
              : const SizedBox(),
          Expanded(
            child: SingleChildScrollView(
              // /!\ important because of the telephone keypad which causes a "RenderFlex overflowed by x pixels on the bottom" error
              // display the CodeEditor widget
              child: CodeEditor(
                model:
                    model, // the model created above, not required since 1.0.0
                edit: true, // can edit the files? by default true
                // onSubmit: (String? language, String? value) => print("yo"),
                // disableNavigationbar:
                //     false, // hide the navigation bar ? by default false
                textEditingController:
                    myController, // Provide an optional, custom TextEditingController.
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget textWidget(String text) {
  sleep(const Duration(seconds: 3));
  return Text(
    text,
    style: const TextStyle(fontSize: 20),
  );
}
