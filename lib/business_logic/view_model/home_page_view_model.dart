import 'package:flutter/material.dart';
import 'package:prag_tech_demo/business_logic/model/user.dart';
import 'package:prag_tech_demo/services/api_service.dart';
import 'package:prag_tech_demo/utils/response_type.dart';

class HomePageViewModel extends ChangeNotifier {
  List<dynamic> _userListResponse = [];
  Response<dynamic> userListUseCase = Response<dynamic>();
  List<bool> likesList =[];

  void _setUserListUseCase(Response response) {
    userListUseCase = response;
    notifyListeners();
  }

  callUserApi() async {
    _setUserListUseCase(Response.loading<List<dynamic>>());
    try {
      _userListResponse =
          (await Api.userDataApi()).map((data) => User.fromJson(data)).toList();

      _setUserListUseCase(Response.complete<List<dynamic>>(_userListResponse));
    } catch (exception) {
      _setUserListUseCase(Response.error<List<dynamic>>(exception.toString()));
    }
  }

  onClickLike(bool isLike) {
    isLike = !isLike;
    likesList.add(isLike);
    print("likes notify");
    notifyListeners();
  }
}
