import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
    );
  }

  AppBar _appBar() {
    return AppBar(
      toolbarHeight: 150,
      title: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Row(
              children: [
                const SizedBox(
                  width: 60,
                ),
                _titleAppBar(),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
      centerTitle: true,
      backgroundColor: const Color.fromRGBO(95, 96, 98, 0.99),
    );
  }


  Widget _titleAppBar() {
    return const Text('CONFIGURAÇÕES',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 30,
        ));
  }
}
