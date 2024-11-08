import 'package:flutter/material.dart';
import 'package:receitasapp/common/decoration_forms.dart';
import 'package:receitasapp/common/my_colors.dart';
import 'package:receitasapp/components/my_receitas.dart';
import 'package:receitasapp/screens/add_edit_receita.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class Receitas extends StatefulWidget {
  const Receitas({super.key});

  @override
  State<Receitas> createState() => _ReceitasState();
}

class _ReceitasState extends State<Receitas> {
  final List<String> items = [
    'Filtros',
    'Salgado',
    'Doce',
    'Bebida',
  ];

  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        title: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(
            "Receitas",
            style: getTextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: DropdownButtonHideUnderline(
              child: DropdownButton2(
                isExpanded: true,
                hint: const Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Filtros',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                buttonStyleData: ButtonStyleData(
                  height: 30,
                  width: 80,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: const Color(0xff012839),
                  ),
                ),
                iconStyleData: const IconStyleData(
                  icon: Icon(
                    Icons.sort,
                  ),
                  iconSize: 14,
                  iconEnabledColor: Colors.white,
                ),
                dropdownStyleData: DropdownStyleData(
                  maxHeight: 200,
                  width: 90,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: const Color(0xff012839),
                  ),
                  scrollbarTheme: ScrollbarThemeData(
                    radius: const Radius.circular(15),
                    thickness: WidgetStateProperty.all(6),
                    thumbVisibility: WidgetStateProperty.all(true),
                  ),
                ),
                menuItemStyleData: const MenuItemStyleData(
                  height: 40,
                  padding: EdgeInsets.only(left: 14, right: 14),
                ),
                value: selectedValue,
                onChanged: (value) {
                  setState(() {
                    selectedValue = value;
                    print("Filtro selecionado: $selectedValue");
                  });
                },
                items: items
                    .map((String item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ))
                    .toList(),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: MyColors.azulPrincipal,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddEditReceita()),
          );
        },
      ),
      body: Container(
        margin: EdgeInsets.only(left: 22, right: 22),
        child: MyReceitas(
          filtros: selectedValue,
        ),
      ),
    );
  }
}
