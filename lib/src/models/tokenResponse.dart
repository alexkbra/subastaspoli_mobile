class TokenResponse {
  String idToken;
  String clientStatus;

  TokenResponse({this.idToken});

  TokenResponse.fromJson(Map<String, dynamic> json) {
    idToken = json['id_token'];
    clientStatus = json['client_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_token'] = this.idToken;
    data['client_status'] = this.clientStatus;
    return data;
  }
}
