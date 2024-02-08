import 'package:flutter/material.dart';
import 'package:todo_c9/layout/home_layout.dart';
import 'package:todo_c9/screens/login/validate_utilts/validate_utilts.dart';
import 'package:todo_c9/shared/styles/colors.dart';

class RegisterScreen extends StatefulWidget {
  static const String routName = 'register';

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
          title: Text(
            'Register',style: TextStyle(fontWeight: FontWeight.bold),
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
                  SizedBox(height: MediaQuery.of(context).size.height*0.25,),
                  TextFormField(
                    validator: (String? value) {
                      if(value==null || value.trim().isEmpty){
                        return 'Please Enter Your Name';
                      }
                      if(!ValidationUtils.isNameValidate(value)){
                        return 'Please Enter A Valid Name';
                      }
                    },
                    keyboardType: TextInputType.name,
                    cursorColor: Colors.grey,
                    cursorHeight: 25,
                    controller: nameController,
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
                      labelText: 'First Name',
                      suffixIcon: Icon(
                        Icons.drive_file_rename_outline,
                        color: Colors.grey,
                      ),
                    ),
                    style: TextStyle(
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
                      labelText: 'E-Mail Adress',
                      suffixIcon: Icon(
                        Icons.mail_outline,
                        color: Colors.grey,
                      ),
                    ),
                    style: TextStyle(
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
                  SizedBox(height: MediaQuery.of(context).size.height*0.095,),
                  ElevatedButton(
                    onPressed: (){
                      if(formKey.currentState!.validate()){
                        Navigator.pushNamed(context, HomeLayout.routName);
                      }
                    },
                    child:Padding(
                      padding: const EdgeInsets.only(top: 15.0,bottom: 15),
                      child: Row(children: [
                        Text('Create Account'),
                        Spacer(),
                        Icon(Icons.arrow_forward),
                      ],),
                    ),
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9),
                        ),
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
