class SourceModel {
  String code;
  String message;
  List<SourceDataList> dataList;

  SourceModel({this.code, this.message, this.dataList});

  SourceModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['dataList'] != null) {
      dataList = new List<SourceDataList>();
      json['dataList'].forEach((v) {
        dataList.add(new SourceDataList.fromJson(v));
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

class SourceDataList {
  String generalID;
  String generalName;

  SourceDataList({this.generalID, this.generalName});

  SourceDataList.fromJson(Map<String, dynamic> json) {
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
