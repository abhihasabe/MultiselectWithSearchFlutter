import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/model/BranchDataList.dart';
import 'package:flutter_app/model/CurrentRoleBelongTo.dart';
import 'package:flutter_app/model/DataList.dart';
import 'package:flutter_app/model/DataListByState.dart';
import 'package:flutter_app/model/EmployeeDataList.dart';
import 'package:flutter_app/model/SourceDataList.dart';
import 'package:flutter_app/model/TractorModel.dart';
import 'package:flutter_app/model/saveCampagin.dart';
import 'package:flutter_app/network/apicall.dart';
import 'package:flutter_app/utils/Constant.dart';
import 'package:flutter_app/utils/Dialogs.dart';
import 'package:flutter_app/utils/network.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';
import 'package:intl/intl.dart';
import 'package:more/char_matcher.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyHomePage();
  }
}

class _MyHomePage extends State {
  var agencyState;
  List restState = List();
  TextEditingController _textStartdate = TextEditingController();
  TextEditingController _textEnddate = TextEditingController();
  DateTime inital;
  static final dateFormatter = DateFormat('yyyy-MM-dd');
  final String dateString = dateFormatter.format(DateTime.now());
  final TextEditingController remarkController = new TextEditingController();
  FocusNode _campnameFocusNode = new FocusNode();

  List<CurrentRoleBelongTo> agencySateList = List();
  final TextEditingController campNameController = new TextEditingController();
  List<DropdownMenuItem<CurrentRoleBelongTo>> _dropdownMenuItems;

  List<DropdownMenuItem<SourceDataList>> _dropdownMenuSource;
  List<int> selectedState = List();
  final List<DropdownMenuItem> items = [];

  var agencySource;
  List restSource = List();
  List<SourceDataList> agencySourceList = List();
  SourceDataList selectedSource;
  String SourceId, campType;

  var campaignType;
  List restCampType = List();
  List<DropdownMenuItem<DataList>> _dropdownMenuItemsCamp;
  List<DataList> campTypeList = List();
  DataList selectCamp;

  var agencytractor;
  List rest1 = List();
  List<TractorDataList> agencyTractorList = List();
  List<CurrentRoleBelongTo> currentRoleList = List();
  List<int> userSearchItems = [];
  List<String> empData = [];
  List<String> tractorData = [];
  List<Map<String, String>> selectedBranchArray = List();

  List<String> userSearchBranch = [];
  List<DropdownMenuItem<TractorDataList>> _dropdownMenuItemsTractorModel;
  List<int> selectedTractor = [];

  var agencyDealerListByState;
  List restDealer = List();
  List<DataListByState> agencyDealerListByStateList = List();
  List<DropdownMenuItem<DataListByState>> _dropdownMenuItemsDealerListByState;
  List<int> selectedDealerListByState = [];

  var agencyBranch;
  List restBranch = List();
  List<BranchDataList> agencyBranchList = List();
  List<DropdownMenuItem<BranchDataList>> _dropdownMenuItemsBranch;
  List<int> selectedBranch = [];

  var agencyEmployeeResponce;
  List restEmp = List();
  List<employeeDataList> agencyEmployeeList = List();
  List<TractorDataList> tractorList = List();
  List<DropdownMenuItem<employeeDataList>> _dropdownMenuEmployee;
  List<int> selectedEmployee = [];

  var saveAgencyData;
  SaveCampagin saveCampagin;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getState();
    getSources();
    getTractorModel();
    getEmployee();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    campNameController.dispose();
    remarkController.dispose();
    _textEnddate.dispose();
    _textStartdate.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: Text("Campaign Form"),
            backgroundColor: Color(0xffee1c3c)),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                    child: TextField(
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        alignLabelWithHint: true,
                        labelText: 'Campaign Name *',
                      ),
                      textCapitalization: TextCapitalization.words,
                      inputFormatters: [
                        WhitelistingTextInputFormatter(RegExp("[a-zA-Z0-9 ]")),
                      ],
                      controller: campNameController,
                    )),
              ),
              Container(
                  padding: const EdgeInsets.only(
                      left: 10.0, right: 10, bottom: 10, top: 16),
                  child: _dropdownMenuItems != null
                      ? SearchableDropdown.multiple(
                          items: _dropdownMenuItems,
                          disabledHint: "Select State*",
                          label: Text(
                            "Select State*",
                            style: TextStyle(color: Colors.black54),
                          ),
                          selectedItems: selectedState,
                          displayClearIcon: false,
                          hint: Text("Select State *"),
                          searchHint: "Select State *",
                          onChanged: (value) {
                            setState(() {
                              selectedState = value;
                            });
                            if (selectedState.length > 0)
                              getDealers(selectedState);
                          },
                          closeButton: (selectedItems) {
                            return (selectedItems.isNotEmpty
                                ? "Save ${selectedItems.length == 1 ? '"' + items.toString() + '"' : '(' + selectedItems.length.toString() + ')'}"
                                : "Save without selection");
                          },
                          underline: Container(
                            height: 1.0,
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: Colors.black38, width: 1.0))),
                          ),
                          isExpanded: true,
                        )
                      : Container()),
              Container(
                padding: EdgeInsets.all(10.0),
                child: _dropdownMenuSource != null
                    ? SearchableDropdown.single(
                        items: _dropdownMenuSource,
                        value: selectedSource,
                        isCaseSensitiveSearch: false,
                        displayClearIcon: false,
                        hint: "Select Source *",
                        label: Text(
                          "Select Source *",
                          style: TextStyle(color: Colors.black54),
                        ),
                        searchHint: "Select Source *",
                        onChanged: (value) {
                          setState(() {
                            selectedSource = value;
                          });
                          if (selectedSource != null)
                            SourceId = selectedSource.generalID;
                          getCampaginType(selectedSource.generalID);
                        },
                        underline: Container(
                          height: 1.0,
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color: Colors.black38, width: 1.0))),
                        ),
                        isExpanded: true,
                      )
                    : Container(),
              ),
              _dropdownMenuItemsCamp != null
                  ? Container(
                      padding: EdgeInsets.all(8.0),
                      child: SearchableDropdown.single(
                        items: _dropdownMenuItemsCamp,
                        value: selectCamp,
                        displayClearIcon: false,
                        isCaseSensitiveSearch: true,
                        hint: "Select Compaign Type *",
                        label: Text(
                          "Select Compaign Type *",
                          style: TextStyle(color: Colors.black54),
                        ),
                        searchHint: "Select Compaign Type *",
                        onChanged: (value) {
                          setState(() {
                            selectCamp = value;
                          });
                          campType = selectCamp.generalID;
                        },
                        underline: Container(
                          height: 1.0,
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color: Colors.black38, width: 1.0))),
                        ),
                        searchFn: (String keyword, items) {
                          List<int> ret = List<int>();
                          if (keyword != null &&
                              items != null &&
                              keyword.isNotEmpty) {
                            keyword.split(" ").forEach((k) {
                              int i = 0;
                              items.forEach((item) {
                                if (k.isNotEmpty &&
                                    (item.value
                                        .toString()
                                        .toLowerCase()
                                        .contains(k.toLowerCase()))) {
                                  ret.add(i);
                                }
                                i++;
                              });
                            });
                          }
                          if (keyword.isEmpty) {
                            ret = Iterable<int>.generate(items.length).toList();
                          }
                          return (ret);
                        },
                        isExpanded: true,
                      ),
                    )
                  : Container(),
              _dropdownMenuItemsTractorModel != null
                  ? Container(
                      padding: const EdgeInsets.all(8.0),
                      child: SearchableDropdown.multiple(
                        items: _dropdownMenuItemsTractorModel,
                        displayClearIcon: false,
                        disabledHint: "Select Tractor Model *",
                        label: Text(
                          "Select Tractor Model *",
                          style: TextStyle(color: Colors.black54),
                        ),
                        selectedItems: selectedTractor,
                        hint: Text("Select Tractor Model *"),
                        searchHint: "Select Tractor Model *",
                        onChanged: (value) {
                          setState(() {
                            selectedTractor = value;
                          });
                          if (selectedTractor.length > 0)
                            getTractor(selectedTractor);
                        },
                        closeButton: (selectedItems) {
                          return (selectedItems.isNotEmpty
                              ? "Save ${selectedItems.length == 1 ? '"' + items.toString() + '"' : '(' + selectedItems.length.toString() + ')'}"
                              : "Save without selection");
                        },
                        underline: Container(
                          height: 1.0,
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color: Colors.black38, width: 1.0))),
                        ),
                        isExpanded: true,
                      ))
                  : Container(),
              _dropdownMenuItemsDealerListByState != null
                  ? Container(
                      padding: const EdgeInsets.all(8.0),
                      child: SearchableDropdown.multiple(
                        items: _dropdownMenuItemsDealerListByState,
                        displayClearIcon: false,
                        disabledHint: "Select Dealers *",
                        label: Text(
                          "Select Dealers *",
                          style: TextStyle(color: Colors.black54),
                        ),
                        selectedItems: selectedDealerListByState,
                        hint: Text("Select Dealers *"),
                        searchHint: "Select Dealers *",
                        onChanged: (value) {
                          setState(() {
                            selectedDealerListByState = value;
                          });
                          if (selectedDealerListByState.length > 0)
                            getBranch(selectedDealerListByState);
                        },
                        closeButton: (selectedItems) {
                          return (selectedItems.isNotEmpty
                              ? "Save ${selectedItems.length == 1 ? '"' + items.toString() + '"' : '(' + selectedItems.length.toString() + ')'}"
                              : "Save without selection");
                        },
                        underline: Container(
                          height: 1.0,
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color: Colors.black38, width: 1.0))),
                        ),
                        isExpanded: true,
                      ))
                  : Container(),
              _dropdownMenuItemsBranch != null
                  ? Container(
                      padding: const EdgeInsets.all(8.0),
                      child: SearchableDropdown.multiple(
                        items: _dropdownMenuItemsBranch,
                        displayClearIcon: false,
                        disabledHint: "Select Branch *",
                        label: Text(
                          "Select Branch *",
                          style: TextStyle(color: Colors.black54),
                        ),
                        selectedItems: selectedBranch,
                        hint: Text("Select Branch *"),
                        searchHint: "Select Branch *",
                        onChanged: (value) {
                          setState(() {
                            selectedBranch = value;
                          });
                          if (selectedBranch.length > 0) {
                            getBranchData(selectedBranch);
                          }
                        },
                        closeButton: (selectedItems) {
                          return (selectedItems.isNotEmpty
                              ? "Save ${selectedItems.length == 1 ? '"' + items.toString() + '"' : '(' + selectedItems.length.toString() + ')'}"
                              : "Save without selection");
                        },
                        underline: Container(
                          height: 1.0,
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color: Colors.black38, width: 1.0))),
                        ),
                        isExpanded: true,
                      ))
                  : Container(),
              _dropdownMenuEmployee != null
                  ? Container(
                      padding: const EdgeInsets.all(8.0),
                      child: SearchableDropdown.multiple(
                        items: _dropdownMenuEmployee,
                        displayClearIcon: false,
                        disabledHint: "Select Employee *",
                        label: Text(
                          "Select Employee *",
                          style: TextStyle(color: Colors.black54),
                        ),
                        selectedItems: selectedEmployee,
                        hint: Text("Select Employee *"),
                        searchHint: "Select Employee *",
                        onChanged: (value) {
                          setState(() {
                            selectedEmployee = value;
                          });
                          if (selectedEmployee.length > 0)
                            getEmpData(selectedEmployee);
                        },
                        closeButton: (selectedItems) {
                          return (selectedItems.isNotEmpty
                              ? "Save ${selectedItems.length == 1 ? '"' + items.toString() + '"' : '(' + selectedItems.length.toString() + ')'}"
                              : "Save without selection");
                        },
                        underline: Container(
                          height: 1.0,
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color: Colors.black38, width: 1.0))),
                        ),
                        isExpanded: true,
                      ))
                  : Container(),
              Padding(
                padding: EdgeInsets.only(left: 10.0, right: 10.0),
                child: TextField(
                  readOnly: true,
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.date_range),
                    hintText: "Start Date *",
                    labelText: "Start Date *",
                  ),
                  controller: _textStartdate,
                  onTap: () async {
                    _textStartdate.value =
                        TextEditingValue(text: dateString.toString());
                    Dialogs.dismissKeyboard(context);
                    DateTime selectedDate = DateTime.now();
                    final DateTime picked = await showRoundedDatePicker(
                        borderRadius: 16,
                        context: context,
                        theme: ThemeData(
                          dialogBackgroundColor: Colors.white,
                          primaryColor: Colors.white,
                          accentColor: Color(0xffee1c3c),
                          colorScheme: ColorScheme.light(
                              primary: const Color(0xffee1c3c)),
                          accentTextTheme: TextTheme(
                              body1: TextStyle(color: Color(0xffee1c3c)),
                              body2: TextStyle(color: Colors.white)),
                        ),
                        initialDate: DateTime.now().add(Duration(days: 0)),
                        firstDate: DateTime.now().add(Duration(days: -1)),
                        lastDate: DateTime(2099));
                    if (picked != null && picked != selectedDate) {
                      setState(() {
                        _textEnddate.clear();

                        selectedDate = picked;
                        inital = picked;
                        _textStartdate.value = TextEditingValue(
                            text: picked.toString().split(" ")[0]);
                      });
                    } else if (picked == null) {
                      setState(() {
                        _textStartdate.clear();
                        _textEnddate.clear();
                      });
                    }
                    print("start $picked");
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: TextField(
                  readOnly: true,
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.date_range),
                    hintText: "End Date *",
                    labelText: "End Date *",
                  ),
                  controller: _textEnddate,
                  onTap: () async {
                    if (_textStartdate.text.length == 0) {
                      Toast.show("Please Select Start Date", context,
                          duration: Toast.LENGTH_LONG, gravity: Toast.TOP);
                    } else {
                      Dialogs.dismissKeyboard(context);
                      DateTime selectedDate = DateTime.now();
                      _textEnddate.value =
                          TextEditingValue(text: dateString.toString());
                      final DateTime picked1 = await showRoundedDatePicker(
                          context: context,
                          borderRadius: 16,
                          theme: ThemeData(
                            dialogBackgroundColor: Colors.white,
                            primaryColor: Colors.white,
                            accentColor: Color(0xffee1c3c),
                            colorScheme: ColorScheme.light(
                                primary: const Color(0xffee1c3c)),
                            // buttonTheme: ButtonThemeData(
                            //     textTheme: ButtonTextTheme.accent),
                            accentTextTheme: TextTheme(
                                body1: TextStyle(color: Color(0xffee1c3c)),
                                body2: TextStyle(color: Colors.white)),
                          ),
                          initialDate: inital,
                          //DateTime.now().add(Duration(days: 0)),
                          firstDate: inital,
                          //DateTime.now().add(Duration(days: -1)),
                          lastDate: DateTime(2099));

                      if (picked1 != null && picked1 != selectedDate)
                        setState(() {
                          // _textFieldController1.value = null;
                          selectedDate = picked1;
                          _textEnddate.value = TextEditingValue(
                              text: picked1.toString().split(" ")[0]);
                        });
                      else if (picked1 == null) {
                        _textEnddate.clear();
                      }
                      print("End Date $picked1");
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: TextField(
                  //                readOnly: true,
                  decoration: InputDecoration(
                    hintText: "Remarks",
                    labelText: "Remarks",
                  ),
                  inputFormatters: [
                    WhitelistingTextInputFormatter(RegExp("[a-zA-Z0-9.! ,]")),
                  ],
                  textCapitalization: TextCapitalization.sentences,
                  autofocus: false,
                  controller: remarkController,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 8.0, right: 8, top: 20, bottom: 10),
                child: SizedBox(
                  height: 45,
                  width: 120,
                  child: MaterialButton(
                    color: Color(0xffee1c3c),
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(32.0),
                        side: BorderSide(color: Color(0xffee1c3c))),
                    elevation: 4.0,
                    child: Text("SUBMIT",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    onPressed: () {
                      Network().check().then((intenet) {
                        if (intenet != null && intenet) {
                          // Internet Present Case
                          onSubmit();
                        } else {
                          // No-Internet Case
                          Toast.show(
                              "No internet connection available please turn on your data or Wi-Fi",
                              context,
                              duration: Toast.LENGTH_LONG,
                              gravity: Toast.TOP);
                        }
                      });
                    },
                  ),
                ),
              )
            ],
          ),
        ));
  }

  Future getState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = prefs.getString('email');
    String password = prefs.getString('password');
    Dialogs.showLoadingDialog(context);
    //var loginJson = {"loginId": '$email', "password": '$password'};
    var loginJson = {"loginId": "6668", "password": "PNABD6VXSA"};
    agencyState = APICall.postJsonData(Constant.login, loginJson);
    agencyState.then((value) => {
          restState = (value['data'])['currentRoleBelongTo'] as List,
          Navigator.pop(context),
          if (restState.length != 0)
            {
              agencySateList = restState
                  .map<CurrentRoleBelongTo>(
                      (json) => CurrentRoleBelongTo.fromJson(json))
                  .toList(),
              if (agencySateList != null)
                {_dropdownMenuItems = buildDropdownMenuItems(agencySateList)}
            }
        });
  }

  Future navigateToLogin() async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => MyHomePage()));
  }

  static List<DropdownMenuItem<CurrentRoleBelongTo>> buildDropdownMenuItems(
      List companies) {
    List<DropdownMenuItem<CurrentRoleBelongTo>> items = List();
    for (CurrentRoleBelongTo project in companies) {
      items.add(
        DropdownMenuItem(
          value: project,
          child: Text(project.generalName),
        ),
      );
    }
    return items;
  }

  void getSources() {
    agencySource = APICall.getJsonData(Constant.compaignSource);
    agencySource.then((value) => {
          restSource = (value['dataList']) as List,
          this.setState(() {
            agencySourceList = restSource
                .map<SourceDataList>((json) => SourceDataList.fromJson(json))
                .toList();
            _dropdownMenuSource = buildDropdownSource(agencySourceList);
          }),
        });
  }

  List<DropdownMenuItem<SourceDataList>> buildDropdownSource(
      List<SourceDataList> agencySourceList) {
    List<DropdownMenuItem<SourceDataList>> items = List();
    for (SourceDataList project in agencySourceList) {
      items.add(
        DropdownMenuItem(
          value: project,
          child: Text(project.generalName),
        ),
      );
    }
    return items;
  }

  void getCampaginType(String sourceID) {
    var tractorJson = {"id": "$sourceID"};
    Dialogs.showLoadingDialog(context);
    campaignType = APICall.postJsonData(Constant.campaignTypeList, tractorJson);
    campaignType.then((value) => {
          restCampType = value["dataList"] as List,
          this.setState(() {
            campTypeList = restCampType
                .map<DataList>((json) => DataList.fromJson(json))
                .toList();
            _dropdownMenuItemsCamp = buildDropdownCampagin(campTypeList);
            Navigator.pop(context);
          })
        });
  }

  List<DropdownMenuItem<DataList>> buildDropdownCampagin(
      List<DataList> campTypeList) {
    List<DropdownMenuItem<DataList>> items = List();
    for (DataList project in campTypeList) {
      items.add(
        DropdownMenuItem(
          value: project,
          child: Text(project.generalName),
        ),
      );
    }
    return items;
  }

  void getTractorModel() {
    var tractorJson = {"fromDate": ""};
    agencytractor = APICall.postJsonData(Constant.tractorModels, tractorJson);
    agencytractor.then((value) => {
          rest1 = value["dataList"] as List,
          this.setState(() {
            //agencyTractorList = value;
            agencyTractorList = rest1
                .map<TractorDataList>((json) => TractorDataList.fromJson(json))
                .toList();
            _dropdownMenuItemsTractorModel =
                buildDropdownTractoCampagin(agencyTractorList);
          }),
          //      Navigator.pop(context),
        });
  }

  List<DropdownMenuItem<TractorDataList>> buildDropdownTractoCampagin(
      List<TractorDataList> campTypeList) {
    List<DropdownMenuItem<TractorDataList>> items = List();
    for (TractorDataList project in campTypeList) {
      items.add(
        DropdownMenuItem(
          value: project,
          child: Text(project.modelName),
        ),
      );
    }
    return items;
  }

  void getDealers(List<int> selectedStates) {
    userSearchItems.clear();
    if (selectedDealerListByState != null) selectedDealerListByState.clear();
    for (int x in selectedStates.toList()) {
      print("getData ${agencySateList[x].generalID}");
      setState(() {
        userSearchItems.add(int.parse(agencySateList[x].generalID));
      });
    }
    if (userSearchItems != null) CallDealer(userSearchItems);
  }

  void CallDealer(List<int> userSearchItems) {
    print("setValue $userSearchItems");
    var agencyEmpJson = {"stateId": userSearchItems};
    agencyDealerListByState =
        APICall.postJsonData1(Constant.dealerListByState, agencyEmpJson);
    agencyDealerListByState.then((value) => {
          restDealer = value["dataList"] as List,
          this.setState(() {
            if (restDealer != null)
              agencyDealerListByStateList = restDealer
                  .map<DataListByState>(
                      (json) => DataListByState.fromJson(json))
                  .toList();
            _dropdownMenuItemsDealerListByState =
                buildDropdownDealerListByState(agencyDealerListByStateList);
          }),
        });
  }

  List<DropdownMenuItem<DataListByState>> buildDropdownDealerListByState(
      List<DataListByState> agencyDealerListByStateList) {
    List<DropdownMenuItem<DataListByState>> items = List();
    for (DataListByState project in agencyDealerListByStateList) {
      items.add(
        DropdownMenuItem(
          value: project,
          child: Text(project.dealerName),
        ),
      );
    }
    return items;
  }

  void getBranch(List<int> selectedDealerListByState) {
    userSearchBranch.clear();
    for (int x in selectedDealerListByState.toList()) {
      print("getData ${agencyDealerListByStateList[x].dealerCode}");
      setState(() {
        userSearchBranch.add(agencyDealerListByStateList[x].dealerCode);
      });
    }
    if (userSearchBranch != null) CallBranch(userSearchBranch);
  }

  void getEmpData(List<int> selectedEmployee) {
    for (int x in selectedEmployee.toList()) {
      print("getData ${agencyEmployeeList[x].userName}");
      setState(() {
        empData.add(agencyEmployeeList[x].userId);
      });
    }
  }

  void getTractor(List<int> selectedTractor) {
    for (int x in selectedTractor.toList()) {
      print("getData ${agencyTractorList[x].modelCode}");
      setState(() {
        tractorData.add(agencyTractorList[x].modelCode);
      });
    }
  }

  void getBranchData(List<int> selectedBranch) {
    Map<String, String> map = Map();
    for (int x in selectedBranch.toList()) {
      print("getData ${agencyBranchList[x].dealerCode}");
      setState(() {
        map["dealerCode"] = agencyBranchList[x].dealerCode;
        map["dealerBranchCode"] = agencyBranchList[x].dealerBranchCode;
        selectedBranchArray.add(map);
      });
    }
  }

  void CallBranch(List<String> userSearchBranch) {
    Dialogs.showLoadingDialog(context);
    var dealerJson = {"dealerList": userSearchBranch};
    print("getDelaerJson $dealerJson");
    agencyBranch = APICall.postJsonData1(Constant.dealerBranchs, dealerJson);
    agencyBranch.then((value) => {
          restBranch = value["dataList"] as List,
          this.setState(() {
            if (restBranch != null)
              agencyBranchList = restBranch
                  .map<BranchDataList>((json) => BranchDataList.fromJson(json))
                  .toList();
            if (agencyBranchList != null) {
              _dropdownMenuItemsBranch = buildDropdownBranch(agencyBranchList);
            }
          }),
          Navigator.pop(context),
        });
  }

  List<DropdownMenuItem<BranchDataList>> buildDropdownBranch(
      List<BranchDataList> agencyBranchList) {
    List<DropdownMenuItem<BranchDataList>> items = List();
    for (BranchDataList project in agencyBranchList) {
      items.add(
        DropdownMenuItem(
          value: project,
          child: Text(project.dealerBranchName),
        ),
      );
    }
    return items;
  }

  Future getEmployee() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString('userId');
    //    Dialogs.showLoadingDialog(context);
    var agencyEmpJson = {"userId": "6394"};
    agencyEmployeeResponce =
        APICall.postJsonData(Constant.agencyemployees, agencyEmpJson);
    agencyEmployeeResponce.then((value) => {
          restEmp = value["dataList"] as List,
          print("getemployeeData ${restEmp}"),
          if (restEmp.length > 0)
            {
              agencyEmployeeList = restEmp
                  .map<employeeDataList>(
                      (json) => employeeDataList.fromJson(json))
                  .toList(),
              if (agencyEmployeeList != null)
                {
                  _dropdownMenuEmployee =
                      buildDropdownEmployee(agencyEmployeeList)
                }
            }
        });
  }

  List<DropdownMenuItem<employeeDataList>> buildDropdownEmployee(
      List<employeeDataList> agencyEmployeeList) {
    List<DropdownMenuItem<employeeDataList>> items = List();
    for (employeeDataList project in agencyEmployeeList) {
      items.add(
        DropdownMenuItem(
          value: project,
          child: Text(project.userName),
        ),
      );
    }
    return items;
  }

  void onSubmit() {
    if (campNameController.text.length == 0) {
      Toast.show("Please Enter Campaign Name", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
    } else if (selectedState.length == 0) {
      Toast.show("Please Select States", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
    } else if (selectedSource == null) {
      Toast.show("Please Select Source", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
    } else if (selectCamp == null) {
      Toast.show("Please Select Campaign Type", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
    } else if (selectedTractor.length == 0) {
      Toast.show("Please Select Tractor Model", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
    } else if (selectedDealerListByState.length == 0) {
      Toast.show("Please Select Dealers", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
    } else if (selectedBranch.length == 0) {
      Toast.show("Please Select Branch", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
    } else if (selectedEmployee.length == 0) {
      Toast.show("Please Select Employee", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
    } else if (_textStartdate.text.length == 0) {
      Toast.show("Please Select Start Date", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
    } else if (_textEnddate.text.length == 0) {
      Toast.show("Please Select End Date", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
    } else {
      _onSubmitCamp();
    }
  }

  Future<bool> _onSubmitCamp() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Confirmation'),
            content: Text('Do you want to submit the Campaign ?'),
            actions: <Widget>[
              FlatButton(
                child: Text('NO'),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              FlatButton(
                child: Text('YES'),
                onPressed: () {
                  Navigator.of(context).pop(false);
                  callSubmit();
                },
              ),
            ],
          );
        });
  }

  void callSubmit() async {
    Toast.show("Submit Data Successfully", context,
        duration: Toast.LENGTH_LONG, gravity: Toast.TOP);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString('userId');
    final dateFormatter1 = DateFormat('yyyy/MM/dd');

    DateTime dateTime1 = DateTime.parse(_textStartdate.text);
    DateTime dateTime2 = DateTime.parse(_textEnddate.text);
    String StartDate = dateFormatter1.format(dateTime1);
    String EndDate = dateFormatter1.format(dateTime2);
    Dialogs.showLoadingDialog(context);

    var agencySaveJson = {
      "campaignName": campNameController.text,
      "userId": userId,
      "campaignCode": "",
      "categoryCode": SourceId,
      "modeCode": campType,
      "dealerList": userSearchBranch,
      "modelList": tractorData,
      "dealerBranchList": selectedBranchArray,
      "empList": empData,
      "startDate": StartDate,
      "endDate": EndDate,
      "remark": remarkController.text,
      "flag": "I",
      "closeDate": "",
    };
    saveAgencyData = APICall.postJsonData1(
        Constant.closeUpdateSaveCampaignData, agencySaveJson);
    saveAgencyData.then((value) => {
          Navigator.pop(context),
          saveCampagin = new SaveCampagin.fromJson(value),
          if (saveCampagin != null)
            {
              if (saveCampagin.code == "200")
                {
                  print("${saveCampagin.message}"),
                }
              else
                {
                  print("${saveCampagin.message}"),
                }
            }
        });
  }
}
