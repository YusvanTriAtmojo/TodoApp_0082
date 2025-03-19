import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}