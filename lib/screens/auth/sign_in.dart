import 'package:flutter/material.dart';

import '/data/funcs.dart';
import '/data/theme.dart';
import '/services/auth.dart';
import '/services/router.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool _invisiblePassword = true, _isLoading = false;
  FocusNode _passwordFiled = FocusNode();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email = '', _password = '';

  @override
  Widget build(BuildContext context) {
    return Area(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: getScaffoldSize(context),
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Container(
                      height: 150,
                      child: Image.asset('assets/logo.png'),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Betting Tips',
                      style: TextStyle(
                        color: mainColor,
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'E-mail',
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
                        onFieldSubmitted: (value) =>
                            FocusScope.of(context).requestFocus(_passwordFiled),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Пароль',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 15,
                              color: hint,
                            ),
                          ),
                        ],
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(top: 20),
                          suffixIconConstraints:
                              BoxConstraints(minWidth: 0, minHeight: 0),
                          isDense: true,
                          suffixIcon: RawMaterialButton(
                            constraints:
                                BoxConstraints(minHeight: 0, maxHeight: 14),
                            onPressed: () {
                              setState(() {
                                _invisiblePassword = !_invisiblePassword;
                              });
                            },
                            child: Icon(
                              Icons.visibility,
                              color: Colors.black,
                              size: 25,
                            ),
                          ),
                        ),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                        focusNode: _passwordFiled,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: _invisiblePassword,
                        onChanged: (value) => _password = value,
                        validator: (value) =>
                            isValidPass(value) ? null : 'Неверный пароль',
                        onFieldSubmitted: (value) => _submit(),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () =>
                                Navigator.pushNamed(context, restoreRoute),
                            child: Text(
                              'Забыли пароль?',
                              style: TextStyle(
                                color: hint,
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Column(
                  children: [
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
                        child: _isLoading
                            ? CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : Text(
                                'Войти',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Нет аккаунта?',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: hint,
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        RawMaterialButton(
                          constraints:
                              BoxConstraints(minHeight: 0, minWidth: 0),
                          onPressed: () =>
                              Navigator.pushNamed(context, signUpRoute),
                          child: Text(
                            'Зарегистрироваться',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: mainColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _submit() async {
    bool formIsCorrect = _formKey.currentState?.validate() ?? false;

    if (formIsCorrect) {
      setState(() {
        _isLoading = true;
      });
      await AuthServices.signIn(_email.trim(), _password, onError: () {
        setState(() => _isLoading = false);
        _formKey.currentState?.reset();
        _formKey.currentState?.validate();
      });
    }
  }
}
