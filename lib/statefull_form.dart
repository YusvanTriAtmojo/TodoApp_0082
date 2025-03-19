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
      if (pilihDateTime == null) {
        // Menampilkan alert
        dateTime = true; 
        return;
      } else {
        // Menghilangkan alert
        dateTime = false; 
      }

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
                initialDateTime: pilihDateTime ?? DateTime.now(),
                onDateTimeChanged: (DateTime newDate) {
                  setState(() {
                    pilihDateTime = newDate;
                    dateTime = false; 
                  });
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
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}