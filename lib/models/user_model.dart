class UserModel {
  final String uid;
  final String email;
  final String name;
  UserModel({this.uid, this.email, this.name});
  UserModel.fromSnapshot(Map<String, dynamic> snapshot)
      : uid = snapshot['uid'],
        email = snapshot['email'],
        name = snapshot['name'];
}
