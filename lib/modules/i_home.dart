import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:i_health/modules/web_view_1.dart';
import 'package:i_health/modules/web_view_2.dart';
import 'package:i_health/shared/componants/components.dart';


class homeModel {
   final String image;
   final String title;
   final String address;
   final String phone;
  homeModel({
    required this.image,
    required this.title,
    required this.address,
    required this.phone,
});

}

class IhomeScreen extends StatefulWidget {

  @override
  _IhomeScreenState createState() => _IhomeScreenState();


}

class _IhomeScreenState extends State<IhomeScreen> {

  List<homeModel> home=
      [
       homeModel(
           image: 'assets/images/elawly.jpeg',
           title: 'Alexandria international hospital',
           address: '-Mostafa Kamel , Alexandria',
           phone: '-034207243',
    ),
       homeModel(
            image: 'assets/images/zohairy.jpeg',
            title: 'El Zohery hospital',
            address: '-Old Egypt , Cairo',
            phone: '-0223648364',
        ),
        homeModel(
            image: 'assets/images/hekma.jpeg',
            title: 'El Hekma hospital',
            address: '-El Monira , Cairo',
            phone: '-0223680200',
        ),
        homeModel(
          image: 'assets/images/sh.jpeg',
          title: 'El Shorouk hospital',
          address: '-sanstephano , Alexandria',
          phone: '-035856453',
        ),
        homeModel(
          image: 'assets/images/elnas.jpeg',
          title: 'El Nas hospital',
          address: '-Shobra elkheima , Qalyobia',
          phone: '-01142717904',
        ),
      ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),

          child: Column(

            children: [
              Row(
                  children: [
                    Container(
                      height: 120,
                      width: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(color: Colors.deepPurple),
                      ),
                      child: defaultTextButton(
                          text: 'coronavirus all over the world',
                          function: ()
                          {
                            navigateTo(context, WorldWebViewScreen());
                          },
                          ),
                    ),
                    SizedBox(width: 10,),
                    Container(
                      height: 120,
                      width: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(color: Colors.deepPurple),
                      ),
                      child: defaultTextButton(
                        text: 'coronavirus all over Egypt',
                        function: ()
                        {
                          navigateTo(context, EgyptWebViewScreen());
                        },
                      ),
                    ),

                  ],

                ),
              SizedBox(height: 30.0,),


              ListView.separated(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),

                itemBuilder:(context, index) => buildHomeItem(home[index]) ,
                separatorBuilder:(context, index) => SizedBox(height: 20.0,),
                itemCount: 5,
              ),


            ],
          ),
        ),
      ),
    );
  }

  Widget buildHomeItem(homeModel model) =>Container(
    height: 100.0,
    width: double.infinity,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: Colors.deepPurple),
    ),
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(

        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(

            decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(50.0),
      border: Border.all(color: Colors.deepPurple),
  ),
            child: CircleAvatar(

              backgroundColor: Colors.grey[100],
              child: Image(image:
              AssetImage(
                  '${model.image}',
              ),
                height: 28.0,
                width: 28.0,
                fit: BoxFit.fill,

              ),
            ),
          ),
          SizedBox(width: 10.0,),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  '${model.title}',
                  maxLines: 4,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,

                  ),

                ),
              ),

              Expanded(
                child: Text(
                  '${model.address}',
                  style: TextStyle(
                      color: Colors.grey,
                  ),

                ),
              ),

              Expanded(
                child: Text(
                  '${model.phone}',
                  style: TextStyle(
                      color: Colors.grey,
                  ),

                ),
              ),
            ],
          ),

        ],
      ),
    ),
  );






}
