import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_health/cubit/states.dart';
import 'package:i_health/models/user_model.dart';
import 'package:i_health/modules/i_home.dart';
import 'package:i_health/modules/i_prescription_layout.dart';
import 'package:sqflite/sqflite.dart';



class IhealthCubit extends Cubit<IhealthStates>
{
  IhealthCubit() : super(IhealthInitialState());
  static IhealthCubit get(context) => BlocProvider.of(context);

  // Bottom Navigation Bar


  int currentIndex = 0;
  List<Widget> bottomScreens =
      [
        IhomeScreen(),
        IprescriptionScreen(),
      ];

  void changBottom(int index)
  {
    currentIndex=index;
    emit(ChangeBottomNavState());
  }

  bool isBottomSheetShown = false;
  IconData fabIcon = Icons.edit;


  void ChangeBottomSheetState ({
    required bool isShow,
    required IconData icon,
  })
  {
    isBottomSheetShown = isShow;
    fabIcon = icon;
    emit(AppChangeBottomSheetState());
  }


 


  IconData suffix = Icons.visibility_outlined;

  bool isPassword= true;

  void ChangePasswordVisibility()
  {
    isPassword = !isPassword;

    suffix = isPassword ?  Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(ChangePasswordVisibilityState());
  }




  // User Login

  void userLogin ({
  required String email,
  required String password,
  }) {
    emit(LoginLoadingState());
    
    FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email, 
        password: password
    ).then((value)
    {
      print(value.user!.email);
      print(value.user!.uid);
      emit(LoginSuccessState(value.user!.uid));
    }
    ).catchError((error)
    {
      emit(LoginErrorState(error.toString()));
    }
    );
  }
  
  
  
  
      // User Register

      void userRegister({
        required String name,
        required String email,
        required String password,
        required String phone,
      }) {
        print('hello');
        emit(RegisterLoadingState());
        FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: email,
            password: password
        ).then((value) {

          userCreate(
              name: name,
              email: email,
              phone: phone,
              uId: value.user!.uid,
          );

        }).catchError((error) {
          print(error.toString());
          emit(RegisterErrorState(error.toString()));
        });
      }

      void userCreate({
        required String name,
        required String email,
        required String phone,
        required String uId,
     })
      {
        userModel? model = userModel(
          name: name,
          email: email,
          phone: phone,
          uId: uId,
        );

        FirebaseFirestore.instance
            .collection('users')
            .doc(uId)
            .set(model.toMap())
            .then((value)
        {
          emit(CreateUserSuccessState());
        }
        ).catchError((error)
        {
          print(error.toString());
          emit(CreateUserErrorState(error.toString()));
        }
        );


      }



// sqflite database
  late Database database;
  List<Map> newItems = [];




  void createDatabase()  {
    openDatabase(
      'ihealth.db',
      version: 1,
      onCreate: (database, version) {
        print('database created');
        database.execute(
            'CREATE TABLE items ('
                'id INTEGER PRIMARY KEY ,'
                ' drugName TEXT ,'
                ' doctorName TEXT ,'
                ' drugTimeOne TEXT ,'
                'drugTimeTwo TEXT ,'
                'drugTimeThree TEXT ,'
                ' status TEXT)'
        )
            .then((value) {
          print('table created');
        }).catchError((error) {
          print('error when creating table ${error.toString()}');
        });
      },
      onOpen: (database) {
        getDataFromDatabase(database);
        print('database opened');
      },
    ).then((value)
    {
      database = value;

      emit(AppCreateDatabaseState());

    });
  }

  insertToDatabase(
      {
        required String drugName,
        required String doctorName,
        required String drugTimeOne,
        required String drugTimeTwo,
        required String drugTimeThree,

      }) async
  {
    await database.transaction((txn) {
      return txn.rawInsert(
          'INSERT INTO items('
              'drugName ,'
              'doctorName ,'
              'drugTimeOne ,'
              'drugTimeTwo, '
              'drugTimeThree,'
              'status) VALUES("$drugName","$doctorName","$drugTimeOne","$drugTimeTwo","$drugTimeThree","new")'
      ).then((value)
      {
        print('$value inserted successfully');
        emit(AppInsertDatabaseState());

        getDataFromDatabase(database);


      }).catchError((error) {
        print('error when inserting new record ${error.toString()}');
        print(error.toString());
      });
    });
  }

  void getDataFromDatabase(database)
  {
    newItems = [];



    emit(AppGetDatabaseLoadingState());
    return  database.rawQuery('SELECT * FROM items').then((value)
    {

      value.forEach((element)
      {
        if(element['status']=='new')
          newItems.add(element);
      });

      emit(AppGetDatabaseState());
    });
  }


  void updateDatabase({
    required String status,
    required int id,
  }) async
  {
    database.rawUpdate(
        'UPDATE items SET status = ? WHERE id = ?',
        ['$status', id]
    ).then((value)
    {
      getDataFromDatabase(database);
      emit(AppUpdateDatabaseState());
    });


  }


  void
  deleteDatabase({
    required int id,
  }) async
  {
    database.rawDelete(
        'DELETE FROM items WHERE id = ?',
        [id]).then((value)
    {
      getDataFromDatabase(database);
      emit(AppDeleteDatabaseState());
    });


  }



}
 
