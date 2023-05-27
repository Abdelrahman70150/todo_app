import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/models/database/user_model.dart' as MyUser;
import 'package:todo_app/models/database/my_database.dart';
import 'package:todo_app/screens/login_screen/login_screen.dart';
import 'package:todo_app/screens/widgets/dialog_utils.dart';
import 'package:todo_app/screens/widgets/validate_utilts.dart';
import 'package:todo_app/shared/components/my_text_form_field.dart';

class RegisterScreen extends StatefulWidget {
  static const String routName = 'registerScreen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  bool isVisible=true;
   var nameController= TextEditingController(text: "AbdelRahman");

  var emailController= TextEditingController(text:"abdo@rout.com");

  var passwordController= TextEditingController(text: "abdo123456");
  var conformPasswordController= TextEditingController(text: "abdo123456");

var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return  Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          image: AssetImage(
              'assets/images/sign_in_bg.png',
          ),
          fit: BoxFit.cover
        ),

      ),
      child:  Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          title: const Text(
            'Create Account'
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: SingleChildScrollView(
            child: Form(
              key:formKey ,
              child: Column(
                children: [
                  SizedBox(  height: MediaQuery.of(context).size.height*0.20,),
                 // name field
                 MyTextFormField(
                   validate: (value){
                     if(value==null || value.trim().isEmpty){
                       return'Please Enter Your Name';
                     }
                   },
                   lableText: 'First Name',
                   suffixIcon:  IconButton(
                     onPressed: (){},
                     icon: Icon(
                         Icons.person_2_outlined
                     ),
                   ),
                   controller: nameController,
                 ),
                  const SizedBox(height: 21,),
                  // email field
                  MyTextFormField(
                    validate: (String? value){
                      if(value==null || value.trim().isEmpty){
                        return 'please enter your email';
                      }
                      if(!ValidationUtils.isEmailValidate(value)){
                        return 'Please Enter A Valid Email';
                      }

                    },
                    controller:emailController ,
                    lableText: 'Email Address',
                    suffixIcon:  IconButton(
                      icon: Icon(Icons.email_outlined),
                      onPressed: (){},
                    ),
                    inputType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 21,),
                  // password field
                  MyTextFormField(
                    controller: passwordController,
                    validate: (value){
                      if(value==null || value.trim().isEmpty){
                        return 'please Enter Password';
                      }
                      if(!ValidationUtils.isPasswordValidate(value)){
                        return 'Please Enter a Valid Password';
                      }
                      return null;
                    },
                    lableText: 'Password',
                    suffixIcon:
                    IconButton(
                     onPressed: (){
                       setState(() {
                         isVisible =! isVisible;
                       });
                     },
                      icon:Icon(
                          isVisible == true ? Icons.remove_red_eye_outlined : Icons.visibility_off,
                      ),
                    ),
                    isPassword: isVisible,
                  ),
                  const SizedBox(height: 21,),
                  MyTextFormField(
                    controller: conformPasswordController,
                    validate: (value){
                      if(value==null || value.trim().isEmpty){
                        return 'Please Enter Password Conformation';
                      } if(value != passwordController.text){
                        return 'Pleas Enter a Match Password';
                      }
                      return null;
                    },
                    lableText: 'Conform Password',
                    suffixIcon: IconButton(
                      onPressed: (){
                        setState(() {
                          isVisible =! isVisible;
                        });
                      },
                      icon:Icon(
                        isVisible == true ? Icons.remove_red_eye_outlined : Icons.visibility_off,
                      ),
                    ),
                    isPassword: isVisible,
                  ),
                  const SizedBox(height: 45
                    ,),
                  ElevatedButton(
                    onPressed: (){
                  register(context);
                    },
                    child:
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Create Account',
                          ),
                          const Icon(
                            Icons.arrow_forward
                          ),
                        ],
                      ),
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

  FirebaseAuth authService = FirebaseAuth.instance;
  void register (context)async{
    if(formKey.currentState!.validate()){
    }
    DialogUtils.showLoadingDialog(context, message: 'Loading ..!');
    try {
      var result = await authService.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      var myUser = MyUser.UserModel(
        id: result.user?.uid,
        name: nameController.text,
        email: emailController.text,
      );
       await FirebaseFunctions.addUser(myUser);
      DialogUtils.hideDialog(context);
      DialogUtils.showMessage(context,message: 'User Registered Successfully',
      postActionMessage: 'ok',
      postAction: (){
        Navigator.pushReplacementNamed(context, LoginScreen.routName);
      });
    } on FirebaseAuthException catch (e) {
      String errorMessage='Something Went Wrong';
      DialogUtils.hideDialog(context);
      if (e.code == 'weak-password') {
        errorMessage='The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        errorMessage='The account already exists for that email.';
      }
      DialogUtils.showMessage(context, message: errorMessage, postActionMessage: 'OK',
          postAction:  (){
          });
    } catch (e) {
      DialogUtils.hideDialog(context);
      String errorMessage='Something Went Wrong';
      DialogUtils.showMessage(
          context, message: errorMessage, postActionMessage: 'Try Again',
      postAction:  (){
        register(context);
      });
    }

  }
}
