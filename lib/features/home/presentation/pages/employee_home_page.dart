import 'package:flutter/material.dart';

class EmployeeHomePage extends StatelessWidget {
  const EmployeeHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Employee Dashboard')),
      body: const Center(
        child: Text('Welcome, Employee! This is your dashboard.'),
      ),
    );
  }
}
