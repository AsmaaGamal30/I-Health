import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:i_health/cubit/cubit.dart';


Widget defaultButton (
{
  double width = double.infinity,
  Color background = Colors.deepPurple,
  required VoidCallback function,
  required String text,
  bool isUpperCase = true,
  double borderRadius =20.0,
}) => Container(
  width: width,
  height: 50.0,
  child: MaterialButton(
    onPressed: function ,
    child: Text(
      isUpperCase ? text.toUpperCase() : text,
      style: TextStyle(
        color: Colors.white,
      ),
    ),
  ),
  decoration: BoxDecoration(
    color: background,
    borderRadius: BorderRadius.circular(borderRadius,),
  ),
);

Widget defaultTextButton ({
  required String text,
  required VoidCallback? function,
  Color textColor = Colors.black,

}) =>TextButton(
    onPressed: function ,
    child: Text(
        text.toUpperCase(),
      style: TextStyle(
        color: textColor,
        fontWeight: FontWeight.bold,
      ),
      maxLines: 4,
    ),
  );


Widget defaultFormField ({
  required TextEditingController controller,
  required TextInputType type,
  bool isPssword = false,
  ValueChanged<String>? onSubmit,
  ValueChanged<String>? onChange,
  GestureTapCallback? onTap,
  bool isClickable = true,
  required  FormFieldValidator<String>? validate,
  required String label,
  required IconData prefix,
  IconData? suffix,
  VoidCallback? suffixPressed,


}) => TextFormField(
  cursorColor: Colors.deepPurple,
  controller: controller,
  keyboardType: type,
  obscureText: isPssword,
  onFieldSubmitted: onSubmit ,

  onChanged: onChange ,
  onTap: onTap,
  enabled: isClickable,
  validator: validate,


  decoration: InputDecoration(

    focusColor: Colors.deepPurple,
    labelText: label ,
    prefixIcon:Icon(
      prefix,
      color: Colors.deepPurple,
    ),
    suffixIcon: IconButton(
      onPressed :suffixPressed,
      icon: Icon(
        suffix,
        color: Colors.deepPurple,
      ),
    ),
  ),
);


Widget buildTaskItem (Map model ,context) => Dismissible(

  key: Key(model['id'].toString()),
  child:   Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 20.0,
              child: Text(
                '${model['id']}',
                style: TextStyle(
                  color: Colors.white
                ),
              ),
              backgroundColor: Colors.deepPurple,
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${model['drugName']}',
                    style: TextStyle(

                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                  Text(
                    '${model['doctorName']}',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    '${model['drugTimeOne']}',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    '${model['drugTimeTwo']}',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    '${model['drugTimeThree']}',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
  onDismissed: (direction)
  {
    IhealthCubit.get(context).deleteDatabase(id: model['id'],);
  },
);

Widget tasksBuilder({
  required List<Map> items
}) => BuildCondition(
  condition: items.length>0,
  builder: (context) => ListView.separated(itemBuilder: (context ,index) => buildTaskItem(items[index],context),
    separatorBuilder: (context ,index) => myDivider() ,
    itemCount: items.length,
  ),
  fallback: (context) => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.menu,
          color: Colors.grey,
          size: 100.0,
        ),
        Text(
          'Please Add Something',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
      ],
    ),
  ),

);


Widget myDivider() => Padding(
  padding: const EdgeInsetsDirectional.only(
    start: 20.0,
  ),
  child: Container(
    height: 1.0,
    color: Colors.grey[300],
    width: double.infinity,
  ),
);




void navigateTo(context , widget) => Navigator.push(context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
);

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (Route<dynamic> route) => false,
);

void showToast({required String text , required ToastStates state}) => Fluttertoast.showToast(
    msg: text ,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: chooseToastColor(state),
    textColor: Colors.white,
    fontSize: 16.0
);

//enum
enum ToastStates {SUCCESS , ERROR , WARNING}

Color? chooseToastColor(ToastStates state)
{
  Color color;
  switch(state)
  {

    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.yellow;
      break;
  }
  return color;
}

