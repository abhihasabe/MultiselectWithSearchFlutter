class CampaignType {
  String code;
  String message;
  List<DataList> dataList;

  CampaignType({this.code, this.message, this.dataList});

  CampaignType.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['dataList'] != null) {
      dataList = new List<DataList>();
      json['dataList'].forEach((v) {
        dataList.add(new DataList.fromJson(v));
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

class DataList {
  String generalID;
  String generalName;

  DataList({this.generalID, this.generalName});

  DataList.fromJson(Map<String, dynamic> json) {
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
