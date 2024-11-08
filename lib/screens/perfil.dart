import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:receitasapp/common/decoration_forms.dart';
import 'package:receitasapp/common/my_colors.dart';
import 'package:receitasapp/screens/add_edit_receita.dart';
import 'package:receitasapp/screens/favoritos.dart';
import 'package:receitasapp/screens/minhas_receitas.dart';
import 'package:receitasapp/services/auth.dart';

class Perfil extends StatefulWidget {
  final User user;
  const Perfil({super.key, required this.user});

  @override
  State<Perfil> createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 160,
                margin: EdgeInsets.only(bottom: 60),
                color: MyColors.azulPrincipal,
              ),
              Positioned(
                bottom: 20,
                right: 130,
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: MyColors.azulPrincipal,
                  ),
                  child: Icon(
                    Icons.account_circle,
                    color: MyColors.cinzaPrincipal,
                    size: 150,
                  ),
                ),
              )
            ],
          ),
          Text(
            widget.user.displayName!,
            style: getTextStyle(fontSize: 26, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 26,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MinhasReceitas(
                          user: widget.user,
                        ),
                      ),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Minhas receitas",
                        style: getTextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      Icon(
                        Icons.keyboard_arrow_right,
                        color: MyColors.azulPrincipal,
                        size: 24,
                      )
                    ],
                  ),
                ),
                Divider(
                  color: MyColors.azulPrincipal,
                  height: 3,
                ),
                SizedBox(
                  height: 16,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Favoritos(),
                      ),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Receitas salvas",
                        style: getTextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      Icon(
                        Icons.keyboard_arrow_right,
                        color: MyColors.azulPrincipal,
                        size: 24,
                      )
                    ],
                  ),
                ),
                Divider(
                  color: MyColors.azulPrincipal,
                  height: 3,
                ),
                SizedBox(
                  height: 16,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddEditReceita(),
                      ),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Adicionar nova receita",
                        style: getTextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      Icon(
                        Icons.keyboard_arrow_right,
                        color: MyColors.azulPrincipal,
                        size: 24,
                      )
                    ],
                  ),
                ),
                Divider(
                  color: MyColors.azulPrincipal,
                  height: 3,
                ),
                SizedBox(
                  height: 250,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MyColors.azulPrincipal,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                    minimumSize: Size(double.infinity, 48),
                  ),
                  onPressed: () {
                    Auth().logoutUser();
                  },
                  child: Text(
                    "Sair",
                    style: getTextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
