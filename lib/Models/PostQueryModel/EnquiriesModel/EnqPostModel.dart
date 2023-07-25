// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';

class EnqPostModal {
  String? exception;
  int?stcode;
  String? CardCode;
  Error? error ;

  EnqPostModal({
      this.exception,
      required this.stcode,
      required this.CardCode,
      this.error
      });
  factory EnqPostModal.fromJson(Map<String, dynamic> jsons,int stcode) {
      return EnqPostModal(
        stcode: stcode,
        exception:null,
        CardCode:jsons["CardCode"],
        error: null
      );
  }

  factory EnqPostModal.error(String jsons,int stcode) {
    return EnqPostModal(
        stcode: stcode,
        exception:jsons,
        CardCode:null,
        error: null
        );
  }

   factory EnqPostModal.issue(Map<String, dynamic> jsons, int stcode) {
    return EnqPostModal(
        stcode: stcode,
        exception:null,
        CardCode:null,
        error: jsons==null?null: Error.fromJson(jsons['error']),
        );
  }

  //json==null?null: Error.fromJson(json['error']),
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
