import 'package:flutter/material.dart';
import 'package:todo_app/home_layout/home_layout.dart';
import 'package:todo_app/screens/register_screen/register_screen.dart';
import 'package:todo_app/screens/widgets/validate_utilts.dart';
import 'package:todo_app/shared/components/my_text_form_field.dart';
import 'package:todo_app/shared/styles/app_colors.dart';

class LoginScreen extends StatefulWidget {
  static const String routName = 'loginScreen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  bool isVisible=true;
  var emailController= TextEditingController();
  var passwordController= TextEditingController();
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
              'Login'
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: SingleChildScrollView(
            child: Form(
              key:formKey ,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(  height: MediaQuery.of(context).size.height*0.23,),
                  // email field
                  Text(
                    'Welcome back!',
                  style:Theme.of(context).textTheme.bodyLarge ,
                  ),
                  const SizedBox(height: 21,),
                  MyTextFormField(
                    validate: (String? value){
                      if(value==null || value.trim().isEmpty){
                        print('dsad');
                        return 'please enter your email';
                      }
                      {
                        if(!ValidationUtils.isEmailValidate(value)){
                          return 'Please enter a Valid Email';
                        }

                      }

                    },
                    controller:emailController ,
                    lableText: 'Email Address',
                    suffixIcon:  IconButton(
                      icon: const Icon(Icons.email_outlined),
                      onPressed: (){},
                    ),
                    inputType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 21,),
                  // password field
                  MyTextFormField(
                    controller: passwordController,
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
                    validate: (value){
                      if(value==null || value.trim().isEmpty){
                        return 'please Enter Password';
                      }

                      if(!ValidationUtils.isPasswordValidate(value)){
                        return 'Please Enter a Valid Password';
                      }

                    },
                  ),
                  const SizedBox(height: 21,),
                  TextButton(onPressed: (){
                  },
                      child: Text(
                        'Forgot Password ?',
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontSize: 12,
                          color: myBluePrimaryColor
                        ),
                      )),
                  const SizedBox(height: 21,),

                  ElevatedButton(
                    onPressed: (){
                      if(formKey.currentState!.validate()){
                        Navigator.pushNamed(context, HomeLayout.routName);
                      }
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
                              'Login',
                            ),
                            const Icon(
                                Icons.arrow_forward
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 21,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Don\'t have Acc ?',
                     style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontSize: 12,
                  ),
              ),
                      TextButton(
                        onPressed: (){
                        Navigator.pushNamed(context, RegisterScreen.routName);
                      },
                          child: Text(
                            'Create one',
                            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                fontSize: 12,
                                color: myBluePrimaryColor
                            ),
                          ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
