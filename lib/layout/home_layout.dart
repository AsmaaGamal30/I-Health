import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_health/cubit/cubit.dart';
import 'package:i_health/cubit/states.dart';
import 'package:i_health/shared/componants/components.dart';
import 'package:i_health/shared/componants/controllers.dart';


class HomeLayOut extends StatelessWidget {

  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=> IhealthCubit()..createDatabase(),
      child: BlocConsumer<IhealthCubit,IhealthStates> (
        listener: (context , state)
        {
          if (state is AppInsertDatabaseState)
          {
            Navigator.pop(context);
          }
        },
         builder: (context,state)
        {
          return Scaffold(
            key: scaffoldKey,
            backgroundColor: Colors.white,
            appBar: AppBar(

                title: Text(
                  'I-Health',
                  style: TextStyle(
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            body:BuildCondition(
              condition: state is! AppGetDatabaseLoadingState,
              builder: (context) => IhealthCubit.get(context).bottomScreens[IhealthCubit.get(context).currentIndex],
              fallback: (context) => Center(child: CircularProgressIndicator(color: Colors.deepPurple,)),
            ),
            bottomNavigationBar: BottomNavigationBar(
              onTap: (int index)
              {
                IhealthCubit.get(context).changBottom(index);
              },
              currentIndex: IhealthCubit.get(context).currentIndex,
              items:
              [
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.home_outlined,
                    ),
                    label: 'I-Home',
                ),

                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.checklist_outlined,
                  ),
                  label: 'I-Prescription',
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.deepPurple,
              onPressed: () {
                if (IhealthCubit.get(context).isBottomSheetShown) {
                  if (formKey.currentState!.validate())
                  {
                    IhealthCubit.get(context).insertToDatabase
                      (
                      drugName: drugNameController.text,
                      doctorName: doctorNameController.text,
                      drugTimeOne: timeOneController.text,
                      drugTimeTwo: timeTwoController.text,
                      drugTimeThree: timeThreeController.text,
                    );

                  }
                } else
                {
                  scaffoldKey.currentState!.showBottomSheet(
                        (context) => SingleChildScrollView(
                          child: Container(
                      color: Colors.white,
                      padding: EdgeInsets.all(20.0),
                      child: Form(
                          key: formKey,
                          child: Column(

                            mainAxisSize: MainAxisSize.min,
                            children: [
                              defaultFormField(
                                label: 'Drug Name',
                                validate: (String? value) {
                                  if (value!.isEmpty) {
                                    return 'Drug Name not be empty';
                                  }
                                  return null;
                                },
                                type: TextInputType.text,
                                prefix: Icons.medical_services_outlined,
                                controller: drugNameController,
                              ),

                              SizedBox(height: 15.0),

                              defaultFormField(
                                label: 'Doctor Name',
                                validate: (String? value) {
                                  if (value!.isEmpty) {
                                    return 'Doctor Name not be empty';
                                  }
                                  return null;
                                },
                                type: TextInputType.text,
                                prefix: Icons.person_outline,
                                controller: doctorNameController,
                              ),

                              SizedBox(height: 15.0),

                              defaultFormField(
                                label: 'First drug time',
                                onTap: () {
                                  showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                  ).then((value) {
                                    timeOneController.text =
                                        (value!.format(context)).toString();
                                  });
                                },
                                validate: (String? value) {
                                  if (value!.isEmpty)
                                  {
                                    return 'time must not be empty';
                                  }
                                  return null;
                                },
                                type: TextInputType.datetime,
                                prefix: Icons.timer_outlined,
                                controller: timeOneController,
                              ),
                              SizedBox(height: 15.0),

                              defaultFormField(
                                label: 'Second drug time',
                                onTap: () {
                                  showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                  ).then((value) {
                                    timeTwoController.text =
                                        (value!.format(context)).toString();
                                  });
                                },
                                validate: (String? value) {
                                  if (value!.isEmpty)
                                  {
                                    return 'time must not be empty';
                                  }
                                  return null;
                                },
                                type: TextInputType.datetime,
                                prefix: Icons.timer_outlined,
                                controller: timeTwoController,
                              ),

                              SizedBox(height: 15.0),

                              defaultFormField(
                                label: 'Third drug time',
                                onTap: () {
                                  showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                  ).then((value) {
                                    timeThreeController.text =
                                        (value!.format(context)).toString();
                                  });
                                },
                                validate: (String? value) {
                                  if (value!.isEmpty)
                                  {
                                    return 'time must not be empty';
                                  }
                                  return null;
                                },
                                type: TextInputType.datetime,
                                prefix: Icons.timer_outlined,
                                controller: timeThreeController,
                              ),

                            ],
                          ),
                      ),
                    ),
                        ),
                    elevation: 20.0,
                  ).closed.then((value)
                  {
                    IhealthCubit.get(context).ChangeBottomSheetState(
                      isShow: false,
                      icon: Icons.edit,
                    );
                  });
                  IhealthCubit.get(context).ChangeBottomSheetState(
                    isShow: true,
                    icon: Icons.add,
                  );
                }
              },
              child: Icon(
                IhealthCubit.get(context).fabIcon,
              ),
            ),

          );
        },
      ),
    );
  }
}
