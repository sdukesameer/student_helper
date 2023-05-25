class UserModel{
  String? email;
  String? displayName;
  String? phoneNumber;
  UserModel({
    required this.email,
    required this.displayName,
    this.phoneNumber
  });
 factory UserModel.fromJSON(Map<String,dynamic> json){
   return UserModel(email: json["email"], displayName: json["username"],phoneNumber:json["phoneNumber"]);
 }
}