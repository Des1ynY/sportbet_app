import 'package:flutter/material.dart';

import '/data/funcs.dart';
import '/data/theme.dart';
import '/widgets/logo.dart';
import '/services/auth.dart';
import '/services/database.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  FocusNode _passwordField = FocusNode(), _passDuplicateFiled = FocusNode();
  String _email = '', _password = '', _passDuplicate = '';
  bool _isLoading = false, _invisiblePassword = true, _secondPass = true;

  @override
  Widget build(BuildContext context) {
    return Area(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: getScaffoldSize(context),
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
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
                            FocusScope.of(context).requestFocus(_passwordField),
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
                        focusNode: _passwordField,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: _invisiblePassword,
                        onChanged: (value) => _password = value,
                        validator: (value) =>
                            isValidPass(value) ? null : 'Некорректный пароль',
                        onFieldSubmitted: (value) => FocusScope.of(context)
                            .requestFocus(_passDuplicateFiled),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Повторите пароль',
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
                                _secondPass = !_secondPass;
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
                        focusNode: _passDuplicateFiled,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: _secondPass,
                        onChanged: (value) => _passDuplicate = value,
                        validator: (value) => _password == _passDuplicate
                            ? null
                            : 'Пароли не совпадают',
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
                    child: _isLoading
                        ? CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : Text(
                            'Зарегистрироваться',
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
      ),
    );
  }

  _submit() async {
    bool formIsValid = _formKey.currentState?.validate() ?? false;

    if (formIsValid) {
      setState(() {
        _isLoading = true;
      });
      await AuthServices.signUp(_email, _password, onError: () {
        setState(() => _isLoading = false);
        _formKey.currentState?.reset();
        _formKey.currentState?.validate();
      });
      await UsersDB.addUser({'email': _email, 'vipCount': 0, 'forecasts': []});
      Navigator.pop(context);
      await AuthServices.signIn(_email, _password, onError: () {});
    }
  }
}
