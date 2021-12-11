import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_health/cubit/cubit.dart';
import 'package:i_health/cubit/states.dart';
import 'package:i_health/layout/home_layout.dart';
import 'package:i_health/shared/componants/controllers.dart';
import 'package:i_health/modules/register_screen.dart';
import 'package:i_health/shared/componants/components.dart';
import 'package:i_health/shared/network/local/cache_helper.dart';

class LoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context)
  {
    return BlocProvider(
      create: (context) => IhealthCubit(),
      child: BlocConsumer<IhealthCubit, IhealthStates>(
        listener: (context, state)
        {
          if(state is LoginErrorState)
            {
              showToast(
                  text: state.error ,
                  state: ToastStates.ERROR,
              );
            }
          if(state is LoginSuccessState)
            {
              CacheHelper.saveData(
                  key: 'uId',
                  value: state.uId,
              ).then((value)
              {
                navigateAndFinish(context, HomeLayOut());
              });

            }
        },
        builder: (context, state)
        {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0.0,
              title: Text(
                'I-Health',
                style: TextStyle(
                  color: Colors.deepPurple,
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsetsDirectional.only(
                start: 40.0,
                end: 40.0,
                bottom: 40.0,
              ),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Center(
                    child: Column(
                      children:
                      [
                        Image(
                          image: AssetImage('assets/images/signin.png'),
                        ),
                        Text(
                          'Login',
                          style: Theme.of(context)
                              .textTheme
                              .headline3!
                              .copyWith(color: Colors.black),
                        ),

                        SizedBox(
                          height: 20.0,
                        ),

                        defaultFormField(
                          controller: EmailController,
                          type: TextInputType.emailAddress,
                          validate: (String? value)
                          {
                            if (value!.isEmpty)
                            {
                              return 'Please enter your email';
                            } else
                              {
                              return null;
                            }
                          },
                          label: 'Email',
                          prefix: Icons.email_outlined,
                        ),

                        SizedBox(
                          height: 15.0,
                        ),

                        defaultFormField(
                            controller: PasswordController,
                            type: TextInputType.visiblePassword,
                            validate: (String? value)
                            {
                              if (value!.isEmpty)
                              {
                                return 'Password is too short';
                              } else
                                {
                                return null;
                              }
                            },
                            onSubmit: (value)
                            {
                             if(formKey.currentState!.validate())
                            {
                            // ShopLoginCubit.get(context).userLogin(
                            //  email: emailController.text,
                            //  password: passwordController.text,
                            // );
                              print('ok');
                                }
                             },
                            label: 'Password',
                            prefix: Icons.lock_outline,
                            isPssword: IhealthCubit.get(context).isPassword,
                            suffix: IhealthCubit.get(context).suffix,
                            suffixPressed: ()
                            {
                              IhealthCubit.get(context).ChangePasswordVisibility();
                            }),
                        SizedBox(
                          height: 15.0,
                        ),
                         BuildCondition(

                        condition: state is! LoginLoadingState,
                          builder: (context)=>
                        defaultButton(
                          text: 'Login',
                          isUpperCase: true,
                          function: ()
                          {
                                if(formKey.currentState!.validate())
                                {
                                  IhealthCubit.get(context).userLogin(
                                   email: EmailController.text,
                                  password: PasswordController.text,
                                );
                              }
                          },
                        ),
                         fallback: (context)=> Center(child: CircularProgressIndicator(color: Colors.deepPurple,)),
                         ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Center(
                          child: Row(
                            children:
                            [
                              Text('Don\'t have an account?'),
                              defaultTextButton(
                                  text: 'REGISTER NOW',
                                  function: ()
                                  {
                                    navigateTo(context, RegisterScreen());
                                  },
                                  ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
