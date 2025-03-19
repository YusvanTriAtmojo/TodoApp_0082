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

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}