import 'package:flutter/material.dart';
import 'package:receitasapp/common/decoration_forms.dart';
import 'package:receitasapp/common/my_colors.dart';
import 'package:receitasapp/components/my_snackbar.dart';
import 'package:receitasapp/services/auth.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class Autenticacao extends StatefulWidget {
  const Autenticacao({super.key});

  @override
  State<Autenticacao> createState() => _AutenticacaoState();
}

class _AutenticacaoState extends State<Autenticacao> {
  bool logar = true;
  bool isLoading = false;

  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _senhaController = TextEditingController();
  TextEditingController _nomeController = TextEditingController();
  TextEditingController _telefoneController = TextEditingController();

  Auth _authService = Auth();

  btnLoginCadastro() {
    String nome = _nomeController.text;
    String senha = _senhaController.text;
    String email = _emailController.text;
    String telefone = _telefoneController.text;

    if (_formKey.currentState!.validate()) {
      if (logar) {
        print("Login efetuado");
        setState(() {
          isLoading = true;
        });

        _authService
            .logarUser(senha: senha, email: email)
            .then((String? error) {
          setState(() {
            isLoading = false;
          });
          if (error != null) {
            print(error);
            // ignore: use_build_context_synchronously
            showMySnackBar(context: context, text: error);
          }
        });
      } else {
        print("Cadastro efetuado");
        setState(() {
          isLoading = true;
        });

        _authService
            .cadastrarUser(
                nome: nome, senha: senha, email: email, telefone: telefone)
            .then((String? error) {
          setState(() {
            isLoading = false;
          });
          if (error != null) {
            print(error);
            // ignore: use_build_context_synchronously
            showMySnackBar(context: context, text: error);
          }
        });
      }
    } else {
      print("Form inválido");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: 250,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Image.asset(
                        "assets/Logo.png",
                        height: 250,
                      ),
                    ],
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: (logar)
                      ? const EdgeInsets.symmetric(horizontal: 45, vertical: 50)
                      : const EdgeInsets.symmetric(
                          horizontal: 45,
                        ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        AnimatedTextKit(
                          key: ValueKey(
                              logar), // Garante que o widget seja recriado quando logar muda
                          repeatForever:
                              false, // Impede a repetição infinita da animação
                          animatedTexts: [
                            TyperAnimatedText(
                              logar ? "Bem - vindo!" : "Cadastre-se",
                              textStyle: getTextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        Visibility(
                          visible: !logar,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 4,
                              ),
                              TextFormField(
                                controller: _nomeController,
                                decoration: getAuthenticationInputDecoration(
                                    "Nome Completo:"),
                                validator: (value) {
                                  if (value == null) {
                                    return "O nome não deve estar vazio!";
                                  }
                                  if (value.isNotEmpty && value.length <= 5) {
                                    return "Nome muito curto!";
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: 8,
                              ),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: !logar,
                          child: Column(
                            children: [
                              TextFormField(
                                controller: _telefoneController,
                                decoration: getAuthenticationInputDecoration(
                                    "Telefone:"),
                                validator: (value) {
                                  if (value == null) {
                                    return "O telefone não deve estar vazio!";
                                  }
                                  if (value.isNotEmpty && value.length <= 5) {
                                    return "Telefone muito curto!";
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          controller: _emailController,
                          decoration:
                              getAuthenticationInputDecoration("E-mail:"),
                          validator: (value) {
                            if (value == null) {
                              return "O e-mail não deve estar vazio!";
                            }
                            if (value.isNotEmpty && value.length <= 5) {
                              return "E-mail muito curto!";
                            }
                            if (!value.contains("@")) {
                              return "E-mail inválido";
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: (logar) ? 24 : 8,
                        ),
                        TextFormField(
                          controller: _senhaController,
                          obscureText: true,
                          decoration:
                              getAuthenticationInputDecoration("Senha:"),
                          validator: (value) {
                            if (value == null) {
                              return "A senha não deve estar vazia!";
                            }
                            if (value.isNotEmpty && value.length <= 5) {
                              return "Senha muito curta!";
                            }
                            return null;
                          },
                        ),
                        Visibility(
                          visible: !logar,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 8,
                              ),
                              TextFormField(
                                decoration: getAuthenticationInputDecoration(
                                    "Confirmar Senha:"),
                                obscureText: true,
                                validator: (value) {
                                  if (value == null) {
                                    return "O campo não deve estar vazio!";
                                  }
                                  if (value.isNotEmpty && value.length <= 5) {
                                    return "Senha muito curta!";
                                  }
                                  if (value != _senhaController.text) {
                                    return "As senhas devem ser iguais!";
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: 8,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            btnLoginCadastro();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: MyColors.azulPrincipal,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                            ),
                            minimumSize: Size(double.infinity, 48),
                          ),
                          child: (isLoading)
                              ? const SizedBox(
                                  height: 16,
                                  width: 16,
                                  child: CircularProgressIndicator(),
                                )
                              : Text(
                                  (logar) ? "Entrar" : "Cadastrar",
                                  style: getTextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              logar = !logar;
                            });
                          },
                          child: Text(
                            (logar)
                                ? "Cadastre-se aqui"
                                : "Já tem conta? Acesse aqui!",
                            style: getTextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              underline: true,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
