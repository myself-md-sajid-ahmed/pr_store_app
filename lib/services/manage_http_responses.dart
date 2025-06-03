import 'dart:convert'; //লাইব্রেরি ইমপোর্ট করা হয়েছে, যা JSON encode/decode করার জন্য দরকার হয়। আমরা json.decode() ব্যবহার করবো।
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

//একটি ফাংশন যা HTTP রেসপন্স হ্যান্ডল করে
void manageHttpResponse({
  required http.Response response, //the HTTp response form the request
  required BuildContext context,

  //The context is to show snackbar
  //যদি HTTP রেসপন্স সফল হয় (200 বা 201), তাহলে এই কলব্যাক ফাংশনটি চালানো হবে।
  required VoidCallback
      onSuccess,//the callback to execute on a successfull response

}) {
  //Switch statement to handle different http status codes
  switch (response.statusCode) {
    case 200: //status code 200 indicates a successful request
      onSuccess();
      break;

    case 400: //status code 400 indicates bad request
      showSnackBar(context, json.decode(response.body)['msg']);
      break;

    case 500://status code 500 indicates a server error
      showSnackBar(context, json.decode(response.body)['error']);
      break;

    case 201://status code 201 indicates a resource created successfully
      onSuccess();
      break;
  }
}

  void showSnackBar(BuildContext context, String title){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(title),
      ),
    );
  }
