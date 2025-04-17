import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

int age = 0;
String? formattedDate;
TextEditingController name = TextEditingController();
GlobalKey<FormState> formKey = GlobalKey<FormState>();
String email = '';

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          leading: Container(
            margin: const EdgeInsets.fromLTRB(15, 8, 0, 8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.black26),
            child: const Icon(
              Icons.person,
              color: Colors.black,
              size: 20,
            ),
          ),
          title: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'G Thaaranya',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Flutter Developer',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(Icons.notifications_active_rounded)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.settings)),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Text(
                'Please select your date of birth to find your age',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      selectDate();
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      backgroundColor:
                          Theme.of(context).colorScheme.inversePrimary,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: formattedDate != null
                        ? Text(
                            formattedDate!,
                            style: const TextStyle(fontSize: 16),
                          )
                        : const Text(
                            'Select Your Date Of Birth',
                            style: TextStyle(fontSize: 16),
                          ),
                  ),
                  const SizedBox(width: 10),
                  formattedDate != null
                      ? InkWell(
                          onTap: () {
                            setState(() {
                              age = 0;
                              formattedDate = null;
                            });
                          },
                          child: const Icon(
                            Icons.cancel,
                            size: 22,
                          ),
                        )
                      : const SizedBox()
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Text(
                    'Your Age is : ',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    age.toString(),
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              TextField(
                controller: name,
                decoration: InputDecoration(
                  label: const Text('Name'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Colors.black38,
                    ),
                  ),
                ),
                onSubmitted: (String value) {
                  name.text = value;
                  log('name - ${name.text}');
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                key: formKey,
                decoration: InputDecoration(
                  label: const Text('Email ID'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.black38),
                  ),
                ),
                onSaved: (String? value) {
                  email = value!;
                  log('email - $email');
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              OutlinedButton(
                style: ButtonStyle(
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                onPressed: () {},
                child: const Text('Submit'),
              ),
            ],
          ),
        ));
  }

  selectDate() async {
    DateTime currentDate = DateTime.now();
    DateTime? selectedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (selectedDate != null) {
      setState(() {
        formattedDate = DateFormat('dd - MM - yyyy').format(selectedDate);
        age = currentDate.year - selectedDate.year;
        if (currentDate.month < selectedDate.month ||
            (currentDate.month == selectedDate.month &&
                currentDate.day < selectedDate.day)) {
          age--;
        }
      });

      log("Age: $age");
    }
  }
}
