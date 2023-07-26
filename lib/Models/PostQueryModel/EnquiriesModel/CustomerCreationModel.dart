
// ignore_for_file: omit_local_variable_types


// ignore_for_file: omit_local_variable_types

class NewCustomerEnqValue{
String? CardCode;
String ?CardName;
 int? stcode;
 Error? error ;
String?exception;
String ?odatametadata;
NewCustomerEnqValue({
  this.CardCode,
  this.CardName,
this.error,
required this.stcode,
this.exception,
this.odatametadata
});

 factory NewCustomerEnqValue.fromJson(Map<String, dynamic> jsons,int stcode) {      

    return NewCustomerEnqValue(
      CardCode: jsons['CardCode'].toString(), 
      CardName: jsons['CardName'].toString(),
      odatametadata: jsons['odata.metadata'].toString(),
       stcode: stcode, 
       error:null,
       exception: null
       );
 }

   factory NewCustomerEnqValue.issue(Map<String, dynamic>? json,int? stcode) {
      return NewCustomerEnqValue(
        CardCode:null,
        CardName: null,
       odatametadata: null,
       stcode:stcode,
       error:json==null?null: Error.fromJson(json['error']),
       exception: null
          );
  }

     factory NewCustomerEnqValue.exception(String exp,int? stcode) {
      return NewCustomerEnqValue(
        CardCode:null,
        CardName: null,
       odatametadata: null,
       stcode:stcode,
       error:null,
       exception: exp
          );
  }
}

class Error{
  int? code;
  Message?message;
 Error({
   this.code,
  this.message
 });

  factory Error.fromJson(dynamic jsons) {
    return Error(
      code: jsons['code']as int,
     message: Message.fromJson(jsons['message']),
       );
 }
}

 class Message{
  String ?lang;
  String ? value; 
 Message({
   this.lang,
   this.value,
 });

  factory Message.fromJson(dynamic jsons) {
    return Message(
    //  groupCode: jsons['GroupCode'] as int, 
      lang: jsons['lang']as String,
      value: jsons['value'] as String,
   
       );
 }
 }

