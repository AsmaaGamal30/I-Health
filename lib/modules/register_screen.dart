import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_health/cubit/cubit.dart';
import 'package:i_health/cubit/states.dart';
import 'package:i_health/layout/home_layout.dart';
import 'package:i_health/shared/componants/controllers.dart';
import 'package:i_health/shared/componants/components.dart';

class RegisterScreen extends StatelessWidget {

  var formKey = GlobalKey<FormState>();



  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => IhealthCubit(),
      child: BlocConsumer<IhealthCubit, IhealthStates>(
        listener: (context, state)
        {
          if(state is CreateUserSuccessState)
            {
              navigateAndFinish(context, HomeLayOut());
            }
        },
        builder: (context, state) {
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
              padding: const EdgeInsets.all(40.0),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Center(
                    child: Column(
                      children:
                      [
                        Text(
                          'Sign Up',
                          style: Theme.of(context)
                              .textTheme
                              .headline3!
                              .copyWith(color: Colors.black),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),


                        defaultFormField(
                          controller: UserNameController,
                          type: TextInputType.text,
                          validate: (String? value)
                          {
                            if (value!.isEmpty)
                            {
                              return 'Please enter User Name';
                            } else
                            {
                              return null;
                            }
                          },
                          label: 'User Name',
                          prefix: Icons.person_outline,

                        ),

                        SizedBox(
                          height: 15.0,
                        ),

                        defaultFormField(
                          controller: EmailController,
                          type: TextInputType.emailAddress,
                          validate: (String? value)
                          {
                            if (value!.isEmpty)
                            {
                              return 'Please enter Email';
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


                        defaultFormField(
                            controller: PhoneController,
                            type: TextInputType.phone,
                            validate: (String? value)
                            {
                              if (value!.isEmpty)
                              {
                                return 'Please enter your phone number';
                              }

                              else
                              {
                                return null;
                              }

                            },

                            label: 'Phone',
                            prefix: Icons.phone,


                          ),


                        SizedBox(
                          height: 30.0,
                        ),

                        BuildCondition(
                          condition: state is! RegisterLoadingState,
                          builder: (context) =>defaultButton(
                              text: 'Sign Up',
                              isUpperCase: true,
                              function: () {
                                if (formKey.currentState!.validate())
                                {
                                  IhealthCubit.get(context).userRegister(
                                    name: UserNameController.text,
                                    email: EmailController.text,
                                    password: PasswordController.text,
                                    phone: PhoneController.text,
                                  );
                                }
                              }

                          ),
                          fallback:(context)=> Center(child: CircularProgressIndicator(color: Colors.deepPurple,)),
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
