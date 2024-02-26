import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:to_farma_app/app/components/componets.dart';
import 'package:to_farma_app/app/pages/login_page.dart';
import 'package:to_farma_app/app/widgets/widgets.dart';
import 'package:to_farma_app/core/models/models.dart';
import 'package:to_farma_app/core/providers/providers.dart';
import 'package:to_farma_app/core/services/services.dart';
import 'package:to_farma_app/core/utlis/utlis.dart';

///exportaciones de formato

class BodyFormRegisterUser extends StatefulWidget {
  const BodyFormRegisterUser({
    super.key,
  });

  @override
  State<BodyFormRegisterUser> createState() => _BodyFormRegisterUserState();
}

class _BodyFormRegisterUserState extends State<BodyFormRegisterUser> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  DateTime _selectedDate = DateTime.now();

  final TextEditingController _dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthUserProvider>(context);
    final registerProvider = Provider.of<UsersServices>(context);
    final Register model = Register();
    final loagingProvider = Provider.of<LoadingProviders>(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Form(
        //key: formKey,
        //autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            ///nombre
            Padding(
              padding: const EdgeInsets.only(
                top: 20,
                bottom: 10,
              ),
              child: TextFormField(
                autocorrect: false,
                inputFormatters: <TextInputFormatter>[
                  LengthLimitingTextInputFormatter(40), //cambiar a 11
                  //FilteringTextInputFormatter.allow(),
                ],
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
                style: Fonts.robotoRegularBlack,
                keyboardType: TextInputType.text,
                decoration: InputDecorationCustom.getInputDecoration(
                  context: context,
                  hintext: 'Nombre',
                  prefixicon: const Icon(Icons.person),
                ),
                onChanged: (value) {
                  authProvider.userName = value;
                },
              ),
            ),

            ///cedula
            Padding(
              padding: const EdgeInsets.only(
                top: 20,
                bottom: 10,
              ),
              child: TextFormField(
                enabled: true,
                inputFormatters: <TextInputFormatter>[
                  RegularExpressions.formatterIdentification,
                  LengthLimitingTextInputFormatter(14), //cambiar a 11
                ],
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
                style: Fonts.robotoRegularBlack,
                keyboardType: TextInputType.number,
                decoration: InputDecorationCustom.getInputDecoration(
                  context: context,
                  hintext: '1-2345-6789',
                  labeltext: 'Cédula',
                  prefixicon: const Icon(Icons.perm_identity),
                ),
                onChanged: (value) {
                  authProvider.cedula = value;
                },
              ),
            ),

            //telefono
            Padding(
              padding: const EdgeInsets.only(
                top: 20,
                bottom: 10,
              ),
              child: TextFormField(
                enabled: true,
                inputFormatters: <TextInputFormatter>[
                  RegularExpressions.formatterTelephone,
                  LengthLimitingTextInputFormatter(9), //cambiar a 11
                ],
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
                style: Fonts.robotoRegularBlack,
                keyboardType: TextInputType.number,
                decoration: InputDecorationCustom.getInputDecoration(
                  context: context,
                  hintext: '8888-8888',
                  labeltext: 'Teléfono',
                  prefixicon: const Icon(Icons.call),
                ),
                onChanged: (value) {
                  authProvider.telefono = value;
                },
              ),
            ),

            //direccion
            Padding(
              padding: const EdgeInsets.only(
                top: 20,
                bottom: 10,
              ),
              child: TextFormField(
                enabled: true,
                inputFormatters: <TextInputFormatter>[
                  //RegularExpressions.formatterTelephone,
                  LengthLimitingTextInputFormatter(40), //cambiar a 11
                ],
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
                style: Fonts.robotoRegularBlack,
                keyboardType: TextInputType.text,
                decoration: InputDecorationCustom.getInputDecoration(
                  context: context,
                  hintext: 'Provincia - Cantón - Distrito',
                  labeltext: 'Dirección con señas',
                  prefixicon: const Icon(Icons.map),
                ),
                onChanged: (value) {
                  authProvider.direccion = value;
                },
              ),
            ),

            ///correo
            Padding(
              padding: const EdgeInsets.only(
                top: 20,
                bottom: 10,
              ),
              child: TextFormField(
                autocorrect: false,
                inputFormatters: <TextInputFormatter>[
                  LengthLimitingTextInputFormatter(-1), //cambiar a 11
                  //FilteringTextInputFormatter.allow(),
                ],
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
                style: Fonts.robotoRegularBlack,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecorationCustom.getInputDecoration(
                  context: context,
                  hintext: 'Correo electrónico',
                  prefixicon: const Icon(Icons.email),
                ),
                onChanged: (value) {
                  authProvider.email = value;
                },
              ),
            ),

            ///Contrasena
            Padding(
              padding: const EdgeInsets.only(
                top: 20,
                bottom: 20,
              ),
              child: TextFormField(
                autocorrect: false,
                obscureText: authProvider.isVisisblePassword,
                inputFormatters: <TextInputFormatter>[
                  LengthLimitingTextInputFormatter(-1), //cambiar a 11
                  //FilteringTextInputFormatter.allow(),
                ],
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
                style: Fonts.robotoRegularBlack,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecorationCustom.getInputDecoration(
                  context: context,
                  hintext: 'Contraseña',
                  prefixicon: const Icon(
                    Icons.lock,
                  ),
                  suffixIcon: IconButton(
                      onPressed: () async {
                        if (authProvider.isVisisblePassword) {
                          authProvider.isVisisblePassword = false;
                        } else {
                          authProvider.isVisisblePassword = true;
                        }
                      },
                      icon: (authProvider.isVisisblePassword)
                          ? const Icon(Icons.visibility)
                          : const Icon(Icons.visibility_off)),
                ),
                onChanged: (value) {
                  authProvider.password = value;
                },
                validator: (value) {
                  if (RegularExpressions.resexpPassword.hasMatch(value ?? '')) {
                    return null;
                  }
                  return '6 digitos. Incluir mayusculas, numeros y caracteres especiales';
                },
              ),
            ),

            //nacimiento
            Padding(
              padding: const EdgeInsets.only(
                top: 20,
                bottom: 10,
              ),
              child: TextFormField(
                controller: _dateController,
                onTap: () => _selectDate(context, authProvider),
                readOnly: true,
                inputFormatters: <TextInputFormatter>[
                  RegularExpressions.formatterDateTime,
                  LengthLimitingTextInputFormatter(10), //cambiar a 11
                ],
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
                style: Fonts.robotoRegularBlack,
                keyboardType: TextInputType.number,
                decoration: InputDecorationCustom.getInputDecoration(
                  context: context,
                  hintext: 'año-mes-dia',
                  labeltext: 'Fecha de Nacimiento',
                  prefixicon: const Icon(Icons.calendar_today),
                ),
                onChanged: (value) {},
              ),
            ),

            ///botones
            ///
            Padding(
              padding: const EdgeInsets.only(
                top: 20,
                bottom: 10,
              ),
              child: ButtonActionWidget(
                function: () async {
                  FocusScope.of(context).unfocus();
                  if (authProvider.isValidateRegister()) {
                    model.email = authProvider.email;
                    model.password = authProvider.password;
                    model.birthDate = CustomFuntions.parseDateString(
                        authProvider.fechaNacimiento);
                    model.phone = authProvider.telefono;
                    model.name = authProvider.userName;
                    model.address = authProvider.direccion;
                    model.identification =
                        CustomFuntions.removeDashes(authProvider.cedula);

                    loagingProvider.isLoading = true;
                    //peticion al server
                    final responseApi =
                        await registerProvider.registerUser(model);

                    loagingProvider.isLoading = false;

                    if (responseApi && context.mounted) {
                      ShowSnackBar.showCustomSuccess(
                          context, 'Registro Exitoso');
                      authProvider.cleanRegister();

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()),
                      );
                    } else {
                      ShowSnackBar.showCustomSnackBar(
                          context, 'Ha ocurrido un error, intente de nuevo.');
                      return;
                    }
                  } else {
                    ShowSnackBar.showCustomSnackBar(
                        context, 'información requerida!!');
                  }
                },
                titleButton: 'Regístrate aquí',
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 20,
                bottom: 30,
              ),
              child: ButtonActionWidget(
                function: () {
                  Navigator.pop(context);
                },
                titleButton: 'Cancelar',
              ),
            ),
          ],
        ),
      ),
    );
  }

  ///funciones
  Future<void> _selectDate(
      BuildContext context, AuthUserProvider provider) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1950),
      lastDate: DateTime(2050),
    );
    if (picked != null && picked != _selectedDate) {
      _selectedDate = picked;
      provider.fechaNacimiento = CustomFuntions.formatDate(_selectedDate);
      _dateController.text = provider.fechaNacimiento;
      setState(() {
        _selectedDate = picked;
        provider.fechaNacimiento = CustomFuntions.formatDate(_selectedDate);
        _dateController.text = provider.fechaNacimiento;
      });
    }
  }
}
