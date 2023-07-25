import 'dart:convert';

const String tableOpenLead = " OpenLeadT";
class OpenLeadColumn{
  static const String FollowupDate = "FollowupDate";
  static const String LeadDocEntry = "LeadDocEntry";
  static const String LeadDocNum = "LeadDocNum";
  static const String FollowupEntry = "FollowupEntry";
  static const String Phone = "Phone";
  static const String Customer = "Customer";
  static const String CreateDate = "CreateDate";
  static const String LastFollowupDate = "LastFollowupDate";
  static const String DocTotal = "DocTotal";
  static const String Quantity = "Quantity";
  static const String Product = "Product";
  static const String LastFollowupStatus = "LastFollowupStatus";
  static const String LastFollowup_Feedback = "LastFollowup_Feedback";
  static const String CustomerInitialIcon = "CustomerInitialIcon";
  static const String Followup_Due_Type = "Followup_Due_Type";
  static const String ItemCode = "ItemCode";
  static const String Brand = "Brand";
  static const String GroupProperty = "GroupProperty";
  static const String GroupSegment = "GroupSegment";
  static const String Division = "Division";
  static const String Branch = "Branch";
  static const String SalesExecutive = "SalesExecutive";
  static const String BranchManager = "BranchManager";
  static const String RegionalManager = "RegionalManager";
}
class OpenLeadModel {
  List<OpenLeadData>? openLeadData;
  String? message;
  bool? status;
  String? exception;
  int? stcode;
  OpenLeadModel(
      {required this.openLeadData,
      required this.message,
      required this.status,
      this.exception,
      required this.stcode});
  factory OpenLeadModel.fromJson(Map<String, dynamic> jsons, int stcode) {
    if (jsons["data"] != null) {
      var list = json.decode(jsons["data"]) as List;
      List<OpenLeadData> dataList =
          list.map((data) => OpenLeadData.fromJson(data)).toList();
      return OpenLeadModel(
          openLeadData: dataList,
          message: jsons["msg"],
          status: jsons["status"],
          stcode: stcode,
          exception: null);
    } else {
      return OpenLeadModel(
          openLeadData: null,
          message: jsons["msg"],
          status: jsons["status"],
          stcode: stcode,
          exception: null);
    }
  }

  factory OpenLeadModel.error(String jsons, int stcode) {
    return OpenLeadModel(
        openLeadData: null,
        message: null,
        status: null,
        stcode: stcode,
        exception: jsons);
  }
}
class OpenLeadData {
  String? FollowupDate;
  int? LeadDocEntry;
  int? LeadDocNum;
  int? FollowupEntry;
  String? Phone;
  String? Customer;
  String? CreateDate;
  String? LastFollowupDate;
  double? DocTotal;
  String?Quantity;
  String? Product;
  String? LastFollowupStatus;
  String? LastFollowup_Feedback;
  String? CustomerInitialIcon;
  String? Followup_Due_Type;
  String? ItemCode;
  String? Brand;
  String? GroupProperty;
  String? GroupSegment;
  String? Division;
  String? Branch;
  String? SalesExecutive;
  String? BranchManager;
  String? RegionalManager;
  
  OpenLeadData({
    required this.FollowupDate,
    required this.LeadDocEntry,
    required this.LeadDocNum,
    required this.FollowupEntry,
    required this.Phone,
    required this.Customer,
    required this.CreateDate,
    required this.LastFollowupDate,
    required this.DocTotal,
    required this.Quantity,
    required this.Product,
    required this.LastFollowupStatus,
    required this.CustomerInitialIcon,
    required this.Followup_Due_Type,
    required this.ItemCode,
    required this.Brand,
    required this.GroupProperty,
    required this.GroupSegment,
    required this.Division,
    required this.Branch,
    required this.SalesExecutive,
    required this.BranchManager,
    required this.RegionalManager,
    required this.LastFollowup_Feedback
  });

  factory OpenLeadData.fromJson(Map<String, dynamic> json) => OpenLeadData(
        FollowupDate: json['FollowupDate'] ?? '',
        LeadDocNum: json['LeadDocNum'] ?? 0,
        FollowupEntry: json['FollowupEntry'] ?? "",
        Phone: json['Phone'] ?? "",
        Customer: json['Customer'] ?? "",
        CreateDate: json['CreateDate'] ?? "",
        LastFollowupDate: json['LastFollowupDate'] ?? "",
        DocTotal: json['DocTotal'] ?? 0, 
        Quantity: json['Quantity'] ?? "", 
        LeadDocEntry: json['LeadDocEntry'] ?? 0, 
        Product: json['Product'] ?? "", 
        LastFollowupStatus: json['LastFollowupStatus'] ?? "", 
        CustomerInitialIcon: json['CustomerInitialIcon'] ?? "", 
        Followup_Due_Type: json['Followup_Due_Type'] ?? "", 
        ItemCode: json['ItemCode'] ?? "", 
        Brand: json['Brand'] ?? "", 
        GroupProperty: json['Group Property'] ?? "", 
        GroupSegment: json['Group Segment'] ?? "", 
        Division: json['Division'] ?? "", 
        Branch: json['Branch'] ?? "", 
        SalesExecutive: json['Sales Executive'] ?? "",
        BranchManager: json['Branch Manager'] ?? "",
        RegionalManager: json['Regional Manager'] ?? "",
        LastFollowup_Feedback: json['LastFollowup_Feedback'] ?? "",

      );

  Map<String, Object?> toMap() => {
        OpenLeadColumn.Branch: Branch,
        OpenLeadColumn.BranchManager: BranchManager,
        OpenLeadColumn.Brand: Brand,
        OpenLeadColumn.CreateDate: CreateDate,
        OpenLeadColumn.Customer: Customer,
        OpenLeadColumn.CustomerInitialIcon: CustomerInitialIcon,
        OpenLeadColumn.Division: Division,
        OpenLeadColumn.DocTotal: DocTotal,
        OpenLeadColumn.FollowupDate:FollowupDate,
        OpenLeadColumn.FollowupEntry:FollowupEntry,
        OpenLeadColumn.Followup_Due_Type:Followup_Due_Type,
        OpenLeadColumn.GroupProperty:GroupProperty,
        OpenLeadColumn.GroupSegment:GroupSegment,
        OpenLeadColumn.ItemCode:ItemCode,
        OpenLeadColumn.LastFollowupDate:LastFollowupDate,
        OpenLeadColumn.LastFollowupStatus:LastFollowupStatus,
        OpenLeadColumn.LastFollowup_Feedback:LastFollowup_Feedback,
        OpenLeadColumn.LeadDocEntry:LeadDocEntry,
        OpenLeadColumn.LeadDocNum:LeadDocNum,
        OpenLeadColumn.Phone:Phone,
        OpenLeadColumn.Product:Product,
        OpenLeadColumn.Quantity:Quantity,
        OpenLeadColumn.RegionalManager:RegionalManager,
        OpenLeadColumn.SalesExecutive:SalesExecutive,
      };
}
