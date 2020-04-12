class LoginModel {
  String code;
  String message;
  Data data;

  LoginModel({this.code, this.message, this.data});

  LoginModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  String userId;
  String userType;
  String userName;
  String loginId;
  String password;
  String strLoginFlag;
  String strMsg;
  String mobileNumber;
  String email;
  String currentRole;
  String currentRoleLevel;
  List<CurrentRoleBelongTo> currentRoleBelongTo;

  Data(
      {this.userId,
        this.userType,
        this.userName,
        this.loginId,
        this.password,
        this.strLoginFlag,
        this.strMsg,
        this.mobileNumber,
        this.email,
        this.currentRole,
        this.currentRoleLevel,
        this.currentRoleBelongTo});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    userType = json['userType'];
    userName = json['userName'];
    loginId = json['loginId'];
    password = json['password'];
    strLoginFlag = json['strLoginFlag'];
    strMsg = json['strMsg'];
    mobileNumber = json['mobileNumber'];
    email = json['email'];
    currentRole = json['currentRole'];
    currentRoleLevel = json['currentRoleLevel'];
    if (json['currentRoleBelongTo'] != null) {
      currentRoleBelongTo = new List<CurrentRoleBelongTo>();
      json['currentRoleBelongTo'].forEach((v) {
        currentRoleBelongTo.add(new CurrentRoleBelongTo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['userType'] = this.userType;
    data['userName'] = this.userName;
    data['loginId'] = this.loginId;
    data['password'] = this.password;
    data['strLoginFlag'] = this.strLoginFlag;
    data['strMsg'] = this.strMsg;
    data['mobileNumber'] = this.mobileNumber;
    data['email'] = this.email;
    data['currentRole'] = this.currentRole;
    data['currentRoleLevel'] = this.currentRoleLevel;
    if (this.currentRoleBelongTo != null) {
      data['currentRoleBelongTo'] =
          this.currentRoleBelongTo.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CurrentRoleBelongTo {
  String generalID;
  String generalName;

  CurrentRoleBelongTo({this.generalID, this.generalName});

  CurrentRoleBelongTo.fromJson(Map<String, dynamic> json) {
    generalID = json['generalID'];
    generalName = json['generalName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['generalID'] = this.generalID;
    data['generalName'] = this.generalName;
    return data;
  }
}