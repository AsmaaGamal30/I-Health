class userModel
{
  String? name;
  String? phone;
  String? email;
  String? uId;

  userModel({
    this.name,
    this.phone,
    this.email,
    this.uId
  });

  userModel.fromJson(Map<String,dynamic> json)
  {
    email=json['email'];
    name=json['name'];
    phone=json['phone'];
    uId=json['uId'];

  }

  Map<String,dynamic> toMap()
  {
    return
      {
        'name':name,
        'email':email,
        'phone':phone,
        'uId':uId,
      };
  }
}