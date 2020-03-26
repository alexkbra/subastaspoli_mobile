class LoginVM {
  String password;
  bool rememberMe;
  String username;

  LoginVM({this.password, this.rememberMe, this.username});

  LoginVM.fromJson(Map<String, dynamic> json) {
    password = json['password'];
    rememberMe = json['rememberMe'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['password'] = this.password;
    data['rememberMe'] = this.rememberMe;
    data['username'] = this.username;
    return data;
  }
}