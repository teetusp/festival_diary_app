class User {
  int? userId;
  String? userFullname;
  String? userName;
  String? userPassword;
  String? userImage;

  //เอาไว้แพ็กข้อมูล User
  User(
      {this.userId,
      this.userFullname,
      this.userName,
      this.userPassword,
      this.userImage});

  //เอาไว้แปลง JSON Data ให้เป็นข้อมูลที่ใช้ใน App
  User.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    userFullname = json['userFullname'];
    userName = json['userName'];
    userPassword = json['userPassword'];
    userImage = json['userImage'];
  }

  //เอาไว้แปลงข้อมูลที่ใช้ใน App ไปเป็น JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['userFullname'] = this.userFullname;
    data['userName'] = this.userName;
    data['userPassword'] = this.userPassword;
    data['userImage'] = this.userImage;
    return data;
  }
}
