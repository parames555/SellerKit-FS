class PatchExCus
{
  String? CardCode;
  String? CardName;
  String? CardType;
  String? U_Address1;
  String? U_Address2;
  String? U_City;
  String? U_Pincode;
  String? U_State;
  String? U_Country;
  String? U_Facebook;
  String? U_EMail;
  String? U_Type;


  PatchExCus({
this.CardCode,
this.CardName,
this.CardType,
this.U_Address1,
this.U_Address2,
this.U_City,
this.U_Country,
this.U_EMail,
this.U_Facebook,
this.U_Pincode,
this.U_State,
this.U_Type

  });

}


class PostEnq
{
  String? CardCode;
  String? Activity;
  int? ActivityType;
  String? U_Lookingfor;
  String? U_PotentialValue;
  String? U_AssignedTo;
  String? U_EnqStatus;
  String? U_EnqRefer;
  int? assignedtoslpCode;


  PostEnq({
this.CardCode,
this.Activity,
this.ActivityType,
this.U_Lookingfor,
this.U_PotentialValue,
this.U_AssignedTo,
this.U_EnqStatus,
this.U_EnqRefer,
this.assignedtoslpCode
  });

}
