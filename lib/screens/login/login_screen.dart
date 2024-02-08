import 'package:flutter/material.dart';
import 'package:todo_c9/layout/home_layout.dart';
import 'package:todo_c9/screens/login/validate_utilts/validate_utilts.dart';
import 'package:todo_c9/screens/register/register_screen.dart';
import 'package:todo_c9/screens/tasks/tasks_tab.dart';
import 'package:todo_c9/shared/styles/colors.dart';

class LoginScreen extends StatefulWidget {
static const String routName = 'login';

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
    return  Container(
      decoration:  BoxDecoration(
        color: mintGreen,
        image: DecorationImage(
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
          title: Text(
            'Login',style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height*0.23,),
                  Text('Welcome back!',style:TextStyle(fontWeight: FontWeight.bold
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
                    },
                    keyboardType: TextInputType.emailAddress,
                    cursorColor: Colors.grey,
                    cursorHeight: 25,
                    controller: emailController,
                    decoration: InputDecoration(
                      errorStyle: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold
                      ),
                      labelStyle: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        height:.5
                      ),
                      labelText: 'Email',
                      suffixIcon: Icon(
                        Icons.mail_outline,
                        color: Colors.grey,
                      ),
                    ),
                    style: TextStyle(
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
                    },

                    keyboardType: TextInputType.visiblePassword,
                    cursorColor: Colors.grey,
                    cursorHeight: 25,
                    controller: passwordController,
                    decoration: InputDecoration(
                       errorStyle: TextStyle(
                         fontSize: 13,
                         fontWeight: FontWeight.bold
                       ),
                      labelStyle: TextStyle(
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
                    style: TextStyle(
                        fontSize: 20
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height*0.04,),
                  Center(child: Text('Forgot Password',style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: primary,
                    fontSize: 15,
                  ),)),
                  SizedBox(height: MediaQuery.of(context).size.height*0.04,),
                  ElevatedButton(
                      onPressed: (){
                        if(formKey.currentState!.validate()){
                          Navigator.pushNamed(context, HomeLayout.routName);
                        }
                      },
                      child:Padding(
                        padding: const EdgeInsets.only(top: 15.0,bottom: 15),
                        child: Row(children: [
                          Text('Login'),
                          Spacer(),
                          Icon(Icons.arrow_forward),
                        ],),
                      ),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9),
                      )
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
