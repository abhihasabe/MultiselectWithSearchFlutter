class DealerBranch {
  String code;
  String message;
  List<BranchDataList> dataList;

  DealerBranch({this.code, this.message, this.dataList});

  DealerBranch.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['dataList'] != null) {
      dataList = new List<BranchDataList>();
      json['dataList'].forEach((v) {
        dataList.add(new BranchDataList.fromJson(v));
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

class BranchDataList {
  String dealerCode;
  String dealerBranchName;
  String dealerBranchCode;
  String dealerBranchType;
  String dealerBranchCategory;
  String dealerBranchLocation;

  BranchDataList(
      {this.dealerCode,
        this.dealerBranchName,
        this.dealerBranchCode,
        this.dealerBranchType,
        this.dealerBranchCategory,
        this.dealerBranchLocation});

  BranchDataList.fromJson(Map<String, dynamic> json) {
    dealerCode = json['dealerCode'];
    dealerBranchName = json['dealerBranchName'];
    dealerBranchCode = json['dealerBranchCode'];
    dealerBranchType = json['dealerBranchType'];
    dealerBranchCategory = json['dealerBranchCategory'];
    dealerBranchLocation = json['dealerBranchLocation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dealerCode'] = this.dealerCode;
    data['dealerBranchName'] = this.dealerBranchName;
    data['dealerBranchCode'] = this.dealerBranchCode;
    data['dealerBranchType'] = this.dealerBranchType;
    data['dealerBranchCategory'] = this.dealerBranchCategory;
    data['dealerBranchLocation'] = this.dealerBranchLocation;
    return data;
  }

  @override
  String toString() {
    return '{${this.dealerCode} , ${this.dealerBranchCode}}';
  }
}