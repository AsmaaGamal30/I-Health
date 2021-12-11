import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_health/cubit/cubit.dart';
import 'package:i_health/cubit/states.dart';
import 'package:i_health/shared/componants/components.dart';



class IprescriptionScreen extends StatelessWidget
{


  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<IhealthCubit , IhealthStates>
      (
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, Object? state)
        {
          var items = IhealthCubit.get(context).newItems;
          return tasksBuilder(
            items: items,
          );
        },
    );
  }
}