// ignore_for_file: file_names
const String tableEnqType = "EnqType";

class EnqTypeDBModel {
  static const String code = "Code";
  static const String name = "Name";
}

// reffers table

const String tableEnqReffers = "EnqRefferes";

class EnqReffersDBModel {
  static const String code = "Code";
  static const String name = "Name";
}

const String tableUserList = "UserList";

class UserListDBModel {
  // static const String userKey = "UserKey";
  // static const String userCode = "UserCode";
  static const String userName = "UserName";
  static const String salesEmpID = "SalesEmpID";
  // static const String employeeID = "EmployeeID";
  static const String color = "Color";
}

const String tableOfferZone = "OfferZone";

class OfferZoneColumns {
  static const String item = "Item";
  static const String discoutDetails = "DiscountDetails";
  static const String offerZoneId = "OfferID";
  static const String itemCode = "ItemCode";
  static const String offerName = "OfferName";
  static const String offerDetails = "OfferDetails";
  static const String incentive = "Incentive";
  static const String validTill = "ValidTill";
}

const String tableLeadStatusReason = "LeadStatusReason";

class LeadStatusReason {
  static const String code = "Code";
  static const String name = "Name";
  static const String statusType = "StatusType";
}

const String tableNotification = "Notification";

class Notification {
  static const String docEntry= "DocEntry";
  static const String title = "Title";
  static const String imgurl = "ImgUrl";
  static const String description= "Description";
  static const String receiveTime = "ReceiveTime";
  static const String seenTime = "SeenTime";
  static const String naviScn= "NavigateScreen";
}
