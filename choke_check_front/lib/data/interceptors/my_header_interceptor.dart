import 'dart:async';
import 'dart:io';

import 'package:chopper/chopper.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

@immutable
// ignore: must_be_immutable
class MyHeaderInterceptor implements RequestInterceptor {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<String> getToken() async {
    SharedPreferences prefs = await _prefs;
    return 'Bearer ${prefs.getString('bearer_token')}';
  }

  @override
  Future<Request> onRequest(Request request) async {
    // if(request.multipart){
    //   return applyHeaders(request,{
    //     'Authorization': await getToken(),
    //     'Content-Type': 'multipart/form-data',
    //     'Accept': '*/*',
    //   });
    // }
    return applyHeader(
        request, HttpHeaders.authorizationHeader, await getToken());
  }
}
