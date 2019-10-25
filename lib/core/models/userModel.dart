class User{
  //propiedades
  String id;
  String displayName;
  String email;
  String phone;
  //contructor
  User({this.id,this.displayName,this.email,this.phone});
  //mapeo para json 
  User.fromMap(Map snapshot,String id):
  id = id ?? '',
  displayName = snapshot['dispayname'] ?? '',
  email = snapshot['email'] ?? '',
  phone = snapshot['phone'] ?? '';
  //retorna en json
  toJson(){
    return {
      "displayName" : displayName,
      "email" : email,
      "phone" : phone
    };
  }
}