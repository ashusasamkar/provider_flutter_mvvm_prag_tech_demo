import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prag_tech_demo/business_logic/model/user.dart';
import 'package:prag_tech_demo/business_logic/view_model/home_page_view_model.dart';
import 'package:prag_tech_demo/services/api_service.dart';
import 'package:prag_tech_demo/utils/error_screen.dart';
import 'package:prag_tech_demo/utils/loading_screen.dart';
import 'package:prag_tech_demo/utils/response_state.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomePageViewModel viewModel = HomePageViewModel();
  int _totalLikes = 0;


  @override
  void initState() {
    viewModel.callUserApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Show total count"),
      ),
      body: ChangeNotifierProvider<HomePageViewModel>(
        create: (BuildContext context) => viewModel,
        child:
            Consumer<HomePageViewModel>(builder: (context, viewModel, child) {
          switch (viewModel.userListUseCase.state) {
            case ResponseState.LOADING:
              return LoadingScreen();
              break;
            case ResponseState.ERROR:
              return ErrorScreen(msg: viewModel.userListUseCase.exception!);
              break;
            case ResponseState.COMPLETE:
              return _getHomeScreenView(
                  viewModel.userListUseCase.data, context);
              break;
          }
          return Container();
        }),
      ),
    );
  }

  Widget _getHomeScreenView(
      List<dynamic> userList, var context) {

    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.all(10),
      child: ListView.builder(
        itemCount: userList.length,
        itemBuilder: (context, index) {
          var isLiked = userList[index].like;
          return Column(
            children: [
              ListTile(
                title: Text(userList[index].name!),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(userList[index].email),
                    Text(userList[index].phone),
                  ],
                ),
                trailing: IconButton(
                  onPressed: () {
                    print("on click like");
                    viewModel.onClickLike(!isLiked);
                  },
                  icon: Icon(
                    Icons.thumb_up,
                    color: isLiked ? Colors.blue : Colors.grey,
                  ),
                ),
              ),
              Divider(),
            ],
          );
        },
      ),
    );
  }
}
