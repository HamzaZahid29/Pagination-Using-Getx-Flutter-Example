import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:paginationpractice/datamodel.dart';

class ApiHandlerController extends GetxController{
  RxInt numberofPage = 1.obs;
  int post = 12;
  var postsList = <DataModel>[].obs;
  RxBool isMoreDataFetching = true.obs;

  Future<void> fetchPosts() async{
     try{
       var response = await Dio().get('https://jsonplaceholder.typicode.com/posts?_limit=$post&_page=$numberofPage');
       if(response.statusCode == 200){
         postsList.assignAll(
             (response.data as List).map((e) => DataModel.fromJson(e)).toList()
         );
       }
     }catch(e){
       print(e.toString());
     }
  }
  Future<void> fetchMoreData() async{
    try{
      numberofPage.value += 1;
      var response = await Dio().get('https://jsonplaceholder.typicode.com/posts?_limit=$post&_page=$numberofPage');
      if(response.statusCode == 200){
        var tempList = <DataModel >[];
        tempList.assignAll(
            (response.data as List).map((e) => DataModel.fromJson(e)).toList()
        );
        if(tempList.length<post){
          isMoreDataFetching(false);
        }
        postsList + tempList;

      }
    }catch(e){
        print('error while fetching more posts ${e.toString()}');
    }
  }
}