import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_c9/layout/home_layout.dart';
import 'package:todo_c9/screens/login/validate_utils/validate_utils.dart';
import 'package:todo_c9/screens/register/register_screen.dart';
import 'package:todo_c9/shared/network/firebase/firebase_manager.dart';
import 'package:todo_c9/shared/styles/colors.dart';

import '../../providers/my_provider.dart';

class LoginScreen extends StatefulWidget {
static const String routName = 'login';

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
var emailController = TextEditingController();
var formKey = GlobalKey<FormState>();

var passwordController = TextEditingController();

bool isVisible = true;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);

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
            'Login',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
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
                  SizedBox(height: MediaQuery.of(context).size.height*0.23,),
                  const Text('Welcome back!',style:TextStyle(fontWeight: FontWeight.bold
                  ,fontSize: 24),),
                  SizedBox(height: MediaQuery.of(context).size.height*0.04,),
                  TextFormField(
                    validator: (String? value) {
                      if(value==null || value.trim().isEmpty){
                        return 'Please enter your email';
                      }
                      if(!ValidationUtils.isEmailValidate(value)){
                        return 'Please enter a Valid email';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    cursorColor: primary,
                    cursorHeight: 25,
                    controller: emailController,
                    decoration:  InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: primary)
                      ),

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
                      labelText: 'Email',
                      suffixIcon: const Icon(
                        Icons.mail_outline,
                        color: Colors.grey,
                      ),
                    ),
                    style: const TextStyle(
                      fontSize: 20
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height*0.04,),
                  TextFormField(
                    obscureText: isVisible,
                    validator: (String? value) {
                      if(value==null || value.trim().isEmpty){
                        return 'Please enter your password';
                      }
                      if(!ValidationUtils.isPasswordValidate(value)){
                        return 'Please enter a Valid password';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.visiblePassword,
                    cursorColor: primary,
                    cursorHeight: 25,
                    controller: passwordController,
                    decoration:
                    InputDecoration(
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
                  SizedBox(height: MediaQuery.of(context).size.height*0.04,),
                  Center(child: Text('Forgot Password',style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: primary,
                    fontSize: 14,
                  ),)),
                  SizedBox(height: MediaQuery.of(context).size.height*0.04,),
                  ElevatedButton(
                      onPressed: (){
                        if(formKey.currentState!.validate()){
                          FirebaseManager.login(emailController.text, passwordController.text,
                              onSuccess: (){
                            showDialog(
                              barrierDismissible: false,
                              context: context, builder: (context) =>
                               AlertDialog(
                                 icon: Icon(Icons.done_all,color: primary,size: 45,),
                                 title: const Text('success'),
                              content: const Text('you have successfully loged into Todo App'),
                              actions: [
                                ElevatedButton(onPressed: (){
                                  provider.initUser();
                                  Navigator.pushNamedAndRemoveUntil(context, HomeLayout.routName, (route) => false);
                                  },
                                  style: ElevatedButton.styleFrom(backgroundColor: primary),
                              child:const Text('Thank You',style: TextStyle(color: Colors.white),) ,
                              )
                              ],)
                            ,);
                              }, onError: (error){
                                showDialog(barrierDismissible: false,
                                  context: context, builder: (context) =>
                                  AlertDialog(
                                    icon: const Icon(Icons.error_outline,color: Colors.red,size: 40,),
                                    title: const Text('Error'),
                                    content:Text( error.toString(),),
                                    actions: [
                                      ElevatedButton(onPressed: (){Navigator.pop(context);},
                                        style: ElevatedButton.styleFrom(backgroundColor: primary),
                                        child:const Text('Okay',style: TextStyle(color: Colors.white),) ,
                                      )
                                    ],)
                                ,);
                              });}
                      },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9),
                      )
                    ),
                      child:const Padding(
                        padding: EdgeInsets.only(top: 15.0,bottom: 15),
                        child: Row(children: [
                          Text('Login',style: TextStyle(color: Colors.white),),
                          Spacer(),
                          Icon(Icons.arrow_forward,color: Colors.white,),
                        ],),
                      ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height*0.04,),
                  InkWell(
                    onTap: (){
                      Navigator.pushNamed(context,RegisterScreen.routName);
                    },
                    child: Center(
                      child: Text('Or Create My Account',style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: primary,
                        fontSize: 14,
                      ),),
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
