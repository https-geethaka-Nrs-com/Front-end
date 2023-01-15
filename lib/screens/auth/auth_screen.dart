// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:fuel_app/screens/auth/widgets/input_fields.dart';
import 'package:fuel_app/screens/auth/widgets/submit_button.dart';
import 'package:get/get.dart';

import '../../controllers/login_controller.dart';
import '../../controllers/registeration_controller.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  RegisterationController registerationController =
      Get.put(RegisterationController());

  LoginController loginController = Get.put(LoginController());
  final _formKey = GlobalKey<FormState>();

  var isLogin = false.obs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(36),
          child: Center(
            child: Obx(
              () => Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      child: Text(
                        'WELCOME',
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.black,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MaterialButton(
                          color:
                              !isLogin.value ? Colors.blueAccent : Colors.white,
                          // color: !isLogin.value ? Colors.amber : Colors.white,
                          onPressed: () {
                            isLogin.value = false;
                          },
                          child: Text('Register'),
                        ),
                        MaterialButton(
                          color:
                              isLogin.value ? Colors.blueAccent : Colors.white,
                          // color: !isLogin.value ? Colors.amber : Colors.white,
                          onPressed: () {
                            isLogin.value = true;
                          },
                          child: Text('Login'),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 80,
                    ),
                    isLogin.value ? loginWidget() : registerWidget()
                  ]),
            ),
          ),
        ),
      ),
    );
  }

  Widget registerWidget() {
    return Column(
      children: 
      [
        Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.always,
        child: Column(
        children: [
          TextFormField(
            controller: registerationController.nameController,
            decoration: const InputDecoration(
              hintText: 'Enter your name',
              label: Text('Name'),
              border: OutlineInputBorder(),
            ),
            validator: MultiValidator([
              RequiredValidator(errorText: "Name required"),
              MinLengthValidator(6,
                  errorText: "Name must be at least of 6 chars"),
            ]),
            keyboardType: TextInputType.text,
            obscureText: false,
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: registerationController.emailController,
            decoration: const InputDecoration(
              hintText: 'Enter your  Email',
              label: Text('Email'),
              border: OutlineInputBorder(),
            ),
            validator: MultiValidator([
              RequiredValidator(errorText: "Email required"),
              EmailValidator(errorText: "Please insert a valid email")
            ]),
            keyboardType: TextInputType.emailAddress,
            obscureText: false,
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: registerationController.phoneController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              hintText: 'Phone number',
              label: Text('Phone'),
              border: OutlineInputBorder(),
            ),
            validator: MultiValidator([
              RequiredValidator(errorText: "Phone number required"),
              PatternValidator(r'^(?:[+0][1-9])?[0-9]{10,12}$', errorText: ''),
            ]),
            obscureText: false,
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: registerationController.passwordController,
            obscureText: true,
            decoration: const InputDecoration(
              hintText: 'Enter password',
              label: Text('password'),
              border: OutlineInputBorder(),
            ),
            validator: MultiValidator([
              RequiredValidator(errorText: 'password is required'),
              MinLengthValidator(8,
                  errorText: 'password must be atleast 8 digits long'),
              PatternValidator(r'(?=.*?[#?!@$%^&*-])',
                  errorText: 'passwords must have at least one special character')
            ]),
            keyboardType: TextInputType.visiblePassword,
          ),
          SizedBox(
            height: 20,
          ),
          SubmitButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                registerationController.registerWithEmail();
              }
            },
            title: 'Register',
          )
        ],
      ),
     ),
    ]
    );
  }

  Widget loginWidget() {
    return Column(
      children: 
      [
        Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.always,
        child: Column(
      children: [
        SizedBox(
          height: 20,
        ),
        TextFormField(
          controller: loginController.emailController,
          decoration: const InputDecoration(
            hintText: 'Enter your  Email',
            label: Text('Email'),
            border: OutlineInputBorder(),
          ),
          validator: MultiValidator([
            RequiredValidator(errorText: "Email required"),
            EmailValidator(errorText: "Please insert a valid email")
          ]),
          keyboardType: TextInputType.emailAddress,
          obscureText: false,
        ),
        SizedBox(
          height: 20,
        ),
        TextFormField(
          controller: loginController.passwordController,
          obscureText: true,
          decoration: const InputDecoration(
            hintText: 'Enter password',
            label: Text('password'),
            border: OutlineInputBorder(),
          ),
          validator: MultiValidator([
            RequiredValidator(errorText: 'password is required'),
            MinLengthValidator(8,
                errorText: 'password must be atleast 8 digits long'),
            PatternValidator(r'(?=.*?[#?!@$%^&*-])',
                errorText: 'passwords must have at least one special character')
          ]),
          keyboardType: TextInputType.visiblePassword,
        ),
        SizedBox(
          height: 20,
        ),
        SubmitButton(
          // onPressed: () => loginController.loginWithEmail(),
          onPressed: () {
            if (_formKey.currentState!.validate()) {Navigator.pushNamed(context, '/dashBoard');}
          },
          title: 'Customer',
        ),
        SizedBox(
          height: 20,
        ),
        SubmitButton(
          // onPressed: () => loginController.loginWithEmail(),
          onPressed: () {
            if (_formKey.currentState!.validate()) {Navigator.pushNamed(context, '/fuelStateUpdate');}
          },
          title: 'Dealer',
        )
      ],
    ),
    ),
    ]
    );
  }
}
