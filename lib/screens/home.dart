import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:receitasapp/common/my_colors.dart';
import 'package:receitasapp/screens/favoritos.dart';
import 'package:receitasapp/screens/perfil.dart';
import 'package:receitasapp/screens/receitas.dart';

class Home extends StatefulWidget {
  final User user;
  const Home({super.key, required this.user});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Widget> _getTelas() {
    return [
      Receitas(),
      Favoritos(),
      Perfil(user: widget.user),
    ];
  }

  String? selectedValue;

  int _selectedNavigationIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedNavigationIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getTelas()[_selectedNavigationIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: MyColors.azulPrincipal,
        selectedItemColor: Colors.white,
        unselectedItemColor: MyColors.cinzaEscuro,
        iconSize: 40,
        elevation: 0,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline),
            label: 'Favoritos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            label: 'Perfil',
          )
        ],
        currentIndex: _selectedNavigationIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
