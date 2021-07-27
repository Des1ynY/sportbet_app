import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '/data/funcs.dart';
import '/data/theme.dart';
import '/widgets/logo.dart';
import '/services/auth.dart';

class Restore extends StatefulWidget {
  const Restore({Key? key}) : super(key: key);

  @override
  _RestoreState createState() => _RestoreState();
}

class _RestoreState extends State<Restore> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email = '';

  @override
  Widget build(BuildContext context) {
    return Area(
      child: Scaffold(
        body: Container(
          height: getScaffoldSize(context),
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Logo(label: 'Betting Tips'),
              Spacer(),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'E-mail для восстановления',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                            color: hint,
                          ),
                        ),
                      ],
                    ),
                    TextFormField(
                      decoration: InputDecoration(),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) => _email = value,
                      validator: (value) =>
                          isValidEmail(value) ? null : 'Некорректный e-mail',
                      onFieldSubmitted: (value) => _submit(),
                    ),
                  ],
                ),
              ),
              Spacer(),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 15,
                ),
                decoration: BoxDecoration(
                  color: mainColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: MaterialButton(
                  onPressed: () => _submit(),
                  child: Text(
                    'Сбросить пароль',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  _submit() async {
    bool formIsValid = _formKey.currentState?.validate() ?? false;

    if (formIsValid) {
      await AuthServices.sendRestoreEmail(_email);
      Fluttertoast.showToast(
        msg:
            'Письмо с инструкциями по сбросу пароля было отправлено на $_email',
        timeInSecForIosWeb: 5,
      );
      Navigator.pop(context);
    }
  }
}
