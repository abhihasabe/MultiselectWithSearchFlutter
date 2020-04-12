class AgencyEmployeeModel {
  String code;
  String message;
  List<employeeDataList> dataList;
  AgencyEmployeeModel({this.code, this.message, this.dataList});
  AgencyEmployeeModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['dataList'] != null) {
      dataList = new List<employeeDataList>();
      json['dataList'].forEach((v) {
        dataList.add(new employeeDataList.fromJson(v));
      });
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.dataList != null) {
      data['dataList'] = this.dataList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
class employeeDataList {
  String userId;
  String userName;
  String mobileNumber;
  String email;
  String vendorName;
  employeeDataList(
      {this.userId,
        this.userName,
        this.mobileNumber,
        this.email,
        this.vendorName});
  employeeDataList.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    userName = json['userName'];
    mobileNumber = json['mobileNumber'];
    email = json['email'];
    vendorName = json['vendorName'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['userName'] = this.userName;
    data['mobileNumber'] = this.mobileNumber;
    data['email'] = this.email;
    data['vendorName'] = this.vendorName;
    return data;
  }
}