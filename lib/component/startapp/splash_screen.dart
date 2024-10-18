import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pedi_agua/component/startapp/custom_navigation_bar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _loadSplash();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
    );
  }

  Widget _body() {
    return Center(
      child: Lottie.asset("assets/animations/logo_teste.json",
          fit: BoxFit.contain, width: 350, height: 600),
    );
  }

  Future<Timer> _loadSplash() async {
    return Timer(
      const Duration(seconds: 3),
      _onDoneLoading,
    );
  }

  _onDoneLoading() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: ((context) => const CustomNavigationBar()),
    ));
  }
}
