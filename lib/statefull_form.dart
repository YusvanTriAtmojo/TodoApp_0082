import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class StatefullForm extends StatefulWidget {
  const StatefullForm({super.key});

  @override
  State<StatefullForm> createState() => _StatefullFormState();
}

class _StatefullFormState extends State<StatefullForm> {
  final TextEditingController taskController = TextEditingController();
  final key = GlobalKey<FormState>();
  List<Map<String, dynamic>> daftarTask = [];
  DateTime? pilihDateTime;
  bool dateTime = false;

  void addData() {
    setState(() {
      daftarTask.add({
        'task': taskController.text,
        'status': false,
        'dateTime': '${pilihDateTime!.day.toString().padLeft(2, '0')}-'
            '${pilihDateTime!.month.toString().padLeft(2, '0')}-'
            '${pilihDateTime!.year} '
            '${pilihDateTime!.hour.toString().padLeft(2, '0')}:' 
            '${pilihDateTime!.minute.toString().padLeft(2, '0')}',
      });
      taskController.clear();
      pilihDateTime = null;
    });
    key.currentState!.reset();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Task added successfully'),
        backgroundColor: const Color.fromARGB(255, 67, 179, 125),
        duration: Duration(seconds: 5),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }

  void status(int index) {
    setState(() {
      daftarTask[index]['status'] = !daftarTask[index]['status'];
    });
  }

  void createDateTime(BuildContext context) {
    DateTime? tempDateTime = pilihDateTime ?? DateTime.now(); 

    showCupertinoModalPopup(
      context: context,
      builder: (_) => Container(
        height: 350,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Set Task Date & Time',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close, color: Colors.black, size: 24),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 200,
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.dateAndTime,
                initialDateTime: tempDateTime,
                onDateTimeChanged: (DateTime newDate) {
                  tempDateTime = newDate; 
                },
              ),
            ),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7),
                ),
              ),
              child: Text('Select'),
              onPressed: () {
                setState(() {
                  pilihDateTime = tempDateTime; 
                  dateTime = false; 
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Page'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded( 
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Task Date:', style: TextStyle(fontSize: 18)),
                        Text(
                          pilihDateTime == null
                              ? 'Select a date'
                              : '${pilihDateTime!.day.toString().padLeft(2, '0')}-'
                                '${pilihDateTime!.month.toString().padLeft(2, '0')}-'
                                '${pilihDateTime!.year} '
                                '${pilihDateTime!.hour.toString().padLeft(2, '0')}:'
                                '${pilihDateTime!.minute.toString().padLeft(2, '0')}',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                        if (dateTime) 
                          Text(
                            'Please select a date',
                            style: TextStyle(fontSize: 16, color: Colors.red),
                          ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {createDateTime(context);},
                    icon: const Icon(Icons.calendar_today, color: Colors.blue),
                    iconSize: 30,
                  ),
                ],
              ),
              SizedBox(height: 20),
              Form(
                key: key,
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: taskController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                          label: Text('First Name'),
                          hintText: 'Enter your first name',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.deepPurple),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 18),
                    OutlinedButton(
                      onPressed: () {
                        setState(() {
                          if (pilihDateTime == null) {
                            dateTime = true; 
                          }
                        });
                        if (key.currentState!.validate() && pilihDateTime != null) {
                          addData();
                        }
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.deepPurple,
                      ),
                      child: Text('Submit'),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Text('List Tasks',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                  Expanded(
                  child: ListView.builder(
                  itemCount: daftarTask.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Colors.indigo[100],
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                       child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  daftarTask[index]['task'],
                                  style: TextStyle(
                                      fontSize: 20, fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Deadline: ${daftarTask[index]['dateTime']}',
                                  style: TextStyle(
                                    fontSize: 16),
                                ),
                                Text(
                                  daftarTask[index]['status'] ? "Done" : "Not Done",
                                  style: TextStyle(
                                    color: daftarTask[index]['status'] ? Colors.green : Colors.red,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Transform.scale(
                            scale: 1.2, 
                            child: Checkbox(
                              value: daftarTask[index]['status'],
                              onChanged: (bool? value) {
                                status(index);
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}