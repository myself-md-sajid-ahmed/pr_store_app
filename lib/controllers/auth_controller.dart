import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pr_store_app/models/user.dart';
import 'package:http/http.dart' as http;

import '../global_variables.dart';
import '../services/manage_http_responses.dart';

import 'dart:convert';

import '../views/screens/authentication_screen/login_screen.dart';
import '../views/screens/main_screen.dart';

class AuthController {
  //this future is because the function will take some time to execute.
  //void is because we won't be returning something.
  //when ever you use the future , you have to use the async within it.

  Future<void> signUpUsers({
    //And the first required field is going to be context,
    // because we will be sending the user snackbar or
    // navigating the user to other screen.
    required context,
    required String fullName,
    required String email,
    required String password,
  }) async {
    try {
      //First we can initialize the user model.
      //over here we can also create a variable to store the initialization.
      User user = User(
        id: '',
        fullName: fullName,
        email: email,
        state: '',
        city: '',
        locality: '',
        password: password,
        token: '',
      );
      //Default, it is going to be an empty string,
      // but in the future the user can update their state city.

      //we can go ahead and interact with the sign up API.
      //remember, the data will be sent to the server in JSON format.

      http.Response response = await http.post(
        Uri.parse('$uri/api/signup'),
        body:
            user.toJson(), //convert the user object to json for the request body
        headers: <String, String>{
          //set the headers for the request.
          'Content-Type':
              'application/json; charset=UTF-8', //specify the context type as json.
        },
      );

      manageHttpResponse(
        response: response,
        context: context,
        onSuccess: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
          );
          showSnackBar(context, 'Account has been create for you');
        },
      );
    } catch (e) {
      print('Signup Error: $e');
      showSnackBar(context, 'An unexpected error occurred');
    }
  }

  //signin users funcitons

  Future<void> signInUsers({
    required context,
    required String email,
    required String password,
  }) async {
    try {
      //jason dot encode and this will convert the map we are about to have into JSON string
      http.Response response = await http.post(
        Uri.parse('$uri/api/signin'),
        body: jsonEncode({
          'email': email, //include the email in the request body,
          'password': password, //include the password in the request body,
        }),
        headers: <String, String>{
          //this will set the header
          'Content-Type':
              'application/json; charset=UTF-8', //specify the context type as json.'
        },
      );

      //handle the response using the manage httpresponse
      manageHttpResponse(
        response: response,
        context: context,
        onSuccess: () {
          //Some skew and immediately we are successfully signed in, then it will take us to the main screen
          // And also we are disabling the previous root so that we won't be able to go back from the main screen
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const MainScreen()),
            (route) => false,
          );
          showSnackBar(context, 'Logged In Successfully');
        },
      );
    } catch (e) {
      print("Error: $e");
    }
  }
}
