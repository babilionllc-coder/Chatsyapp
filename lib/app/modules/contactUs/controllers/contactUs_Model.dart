class ContactUsModel {
  int? responseCode;
  String? responseMsg;
  String? result;
  String? serverTime;

  ContactUsModel(
      {this.responseCode, this.responseMsg, this.result, this.serverTime});

  ContactUsModel.fromJson(Map<String, dynamic> json) {
    responseCode = json['ResponseCode'];
    responseMsg = json['ResponseMsg'];
    result = json['Result'];
    serverTime = json['ServerTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ResponseCode'] = this.responseCode;
    data['ResponseMsg'] = this.responseMsg;
    data['Result'] = this.result;
    data['ServerTime'] = this.serverTime;
    return data;
  }
}
