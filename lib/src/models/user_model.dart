class UserModel {
  String login;
  String password;
  String usuario;
  String permiso;

  UserModel({
    this.usuario,
    this.permiso 
  });

  UserModel.fromJsonMap(Map<String, dynamic> json) {
    usuario = json['usuario'];
    permiso = 'DEALER';
  }

}