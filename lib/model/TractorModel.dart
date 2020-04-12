class TractorModel {
  String code;
  String message;
  List<TractorDataList> dataList;

  TractorModel({this.code, this.message, this.dataList});

  TractorModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['dataList'] != null) {
      dataList = new List<TractorDataList>();
      json['dataList'].forEach((v) {
        dataList.add(new TractorDataList.fromJson(v));
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

class TractorDataList {
  String modelCode;
  String modelName;
  String manufacturerCode;
  String manufacturerName;
  String modelType;

  TractorDataList(
      {this.modelCode,
        this.modelName,
        this.manufacturerCode,
        this.manufacturerName,
        this.modelType});

  TractorDataList.fromJson(Map<String, dynamic> json) {
    modelCode = json['modelCode'];
    modelName = json['modelName'];
    manufacturerCode = json['manufacturerCode'];
    manufacturerName = json['manufacturerName'];
    modelType = json['modelType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['modelCode'] = this.modelCode;
    data['modelName'] = this.modelName;
    data['manufacturerCode'] = this.manufacturerCode;
    data['manufacturerName'] = this.manufacturerName;
    data['modelType'] = this.modelType;
    return data;
  }
}