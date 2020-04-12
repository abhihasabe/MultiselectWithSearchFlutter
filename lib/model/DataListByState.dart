class DealerListByStateModel {
  String code;
  String message;
  List<DataListByState> dataList;

  DealerListByStateModel({this.code, this.message, this.dataList});

  DealerListByStateModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['dataList'] != null) {
      dataList = new List<DataListByState>();
      json['dataList'].forEach((v) {
        dataList.add(new DataListByState.fromJson(v));
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

class DataListByState {
  String dealerCode;
  String dealerName;
  String location;
  String district;
  String channelPartnerType;

  DataListByState(
      {this.dealerCode,
        this.dealerName,
        this.location,
        this.district,
        this.channelPartnerType});

  DataListByState.fromJson(Map<String, dynamic> json) {
    dealerCode = json['dealerCode'];
    dealerName = json['dealerName'];
    location = json['location'];
    district = json['district'];
    channelPartnerType = json['channelPartnerType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dealerCode'] = this.dealerCode;
    data['dealerName'] = this.dealerName;
    data['location'] = this.location;
    data['district'] = this.district;
    data['channelPartnerType'] = this.channelPartnerType;
    return data;
  }
}