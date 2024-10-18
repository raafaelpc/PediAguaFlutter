import 'package:flutter/material.dart';
import 'package:pedi_agua/view/home/home_screen.dart';
import 'package:pedi_agua/view/orders/orders_screen.dart';
import 'package:pedi_agua/view/settings/settings_screen.dart';

class CustomNavigationBar extends StatefulWidget {
  const CustomNavigationBar({super.key});

  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  int currentScreenIndex = 0;
  bool isLoading = false;

  final List<Widget> screens = [
    const HomeScreen(),
    const OrdersScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
            color: Color.fromRGBO(95, 96, 98, 0.99),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            )),
        child: NavigationBar(
          backgroundColor: Colors.transparent,
          indicatorColor:const Color.fromRGBO(87, 87, 87, 0.99),
          height: 70,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
          selectedIndex: currentScreenIndex,
          onDestinationSelected: (int index) {
            setState(() {
              isLoading = true;
            });

            Future.delayed(const Duration(seconds: 1), () {
              setState(() {
                currentScreenIndex = index;
                isLoading = false;
              });
            });
          },
          destinations: const <Widget>[
            NavigationDestination(
              icon: Icon(
                size: 30,
                Icons.store,
                color: Colors.white,
              ),
              label: '',
            ),
            NavigationDestination(
                icon: Icon(
                  size: 30,
                  Icons.inventory,
                  color: Colors.white,
                ),
                label: ''),
            NavigationDestination(
                icon: Icon(
                  size: 30,
                  Icons.person_2_outlined,
                  color: Colors.white,
                ),
                label: ''),
          ],
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : screens[currentScreenIndex],
    );
  }
}
