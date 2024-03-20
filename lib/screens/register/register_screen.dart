import 'package:flutter/material.dart';
import 'package:todo_c9/screens/login/login_screen.dart';
import 'package:todo_c9/screens/login/validate_utils/validate_utils.dart';
import 'package:todo_c9/shared/network/firebase/firebase_manager.dart';
import 'package:todo_c9/shared/styles/colors.dart';

import '../../shared/components/dialog.dart';

class RegisterScreen extends StatefulWidget {
  static const String routName = 'register';

  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var emailController = TextEditingController();
  var nameController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  var passwordController = TextEditingController();

  bool isVisible = true;

  @override
  Widget build(BuildContext context) {
    return  Container(
      decoration:  BoxDecoration(
        color: mintGreen,
        image: const DecorationImage(
            image:AssetImage(
              'assets/images/SIGN IN – 1.png',
            ),
            fit:BoxFit.cover
        ),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: true,
          elevation: 0,
          title: const Text(
            'Register',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height*0.25,),
                  TextFormField(
                    validator: (String? value) {
                      if(value==null || value.trim().isEmpty){
                        return 'Please Enter Your Name';
                      }
                      if(!ValidationUtils.isNameValidate(value)){
                        return 'Please Enter A Valid Name';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.name,
                    cursorColor:primary,
                    cursorHeight: 25,
                    controller: nameController,
                    decoration:  InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: primary),),
                      errorStyle: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold
                      ),
                      labelStyle: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          height:.5
                      ),
                      labelText: 'First Name',
                      suffixIcon: const Icon(
                        Icons.drive_file_rename_outline,
                        color: Colors.grey,
                      ),
                    ),
                    style: const TextStyle(
                        fontSize: 20
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height*0.05,),
                  TextFormField(
                    validator: (String? value) {
                      if(value==null || value.trim().isEmpty){
                        return 'Please Enter your E-Mail';
                      }
                      if(!ValidationUtils.isEmailValidate(value)){
                        return 'Please Enter a Valid E-Mail';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    cursorColor:primary,
                    cursorHeight: 25,
                    controller: emailController,
                    decoration:  InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: primary),),
                      errorStyle: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold
                      ),
                      labelStyle: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          height:.5
                      ),
                      labelText: 'E-Mail Address',
                      suffixIcon: const Icon(
                        Icons.mail_outline,
                        color: Colors.grey,
                      ),
                    ),
                    style: const TextStyle(
                        fontSize: 20
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height*0.05,),
                  TextFormField(
                    obscureText: isVisible,
                    validator: (String? value) {
                      if(value==null ){
                        return 'Please Enter Your Password';
                      }
                      if(!ValidationUtils.isPasswordValidate(value)|| value.trim().isEmpty){
                        return 'Please Enter A Valid Password';
                      }
                      return null;
                    },

                    keyboardType: TextInputType.visiblePassword,
                    cursorColor:primary,
                    cursorHeight: 25,
                    controller: passwordController,
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: primary),),
                      errorStyle: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold
                      ),
                      labelStyle: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          height:.5
                      ),
                      labelText: 'Password',
                      suffixIcon: IconButton(
                        onPressed: (){
                          isVisible =! isVisible;
                          setState(() {
                          });
                        },
                        icon:Icon( isVisible ==true ? Icons.lock_outline: Icons.lock_open_outlined,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    style: const TextStyle(
                        fontSize: 20
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height*0.095,),
                  ElevatedButton(
                    onPressed: (){
                      if(formKey.currentState!.validate()){
                        FirebaseManager.createAccount(emailController.text, nameController.text ,passwordController.text,
                            onSuccess: (){
                              DialogUtils.showMessage(
                                isDismissible: false,
                                context,
                                message: 'you have successfully Registered into Todo App',
                                title:  'success',
                                icon: Icon(Icons.done_all,color: primary,size: 45,),
                                postActionMessage: 'Thank U',
                                postAction: (){
                                 // provider.initUser();
                                  Navigator.pushNamedAndRemoveUntil(context, LoginScreen.routName, (route) => false);
                                },
                              );

                            }, onError: (error){
                              DialogUtils.showMessage(
                                isDismissible: false,
                                context,
                                message: error.toString(),
                                title:  'Error',
                                icon: const Icon(Icons.error_outline,color: Colors.red,size: 40,),
                                postActionMessage: 'OK',
                                postAction: (){
                                },
                              );

                            }
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9),
                        ),
                    ),
                    child:const Padding(
                      padding:  EdgeInsets.only(top: 15.0,bottom: 15),
                      child: Row(
                        children: [
                        Text('Create Account',style: TextStyle(color: Colors.white),),
                         Spacer(),
                         Icon(Icons.arrow_forward,color: Colors.white,),
                      ],),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
