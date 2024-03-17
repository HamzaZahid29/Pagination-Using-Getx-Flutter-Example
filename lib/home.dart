import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'apihandles.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ApiHandlerController apiHandlerController = Get.put(ApiHandlerController());
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    // TODO: implement initState
    scrollController.addListener(() {
      if(scrollController.position.maxScrollExtent == scrollController.offset){
        print('emthod called'
        );
        apiHandlerController.fetchMoreData();
      }
    });
    apiHandlerController.fetchPosts();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(
          'Pagination',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: Colors.grey.shade900
          ),
        ),
      ),
       body:  Obx(
              () => ListView.builder(
            controller: scrollController,
            itemCount: apiHandlerController.postsList.length + 1,
            itemBuilder: (BuildContext context, int index) {
             if(index < apiHandlerController.postsList.length){
               return ListTile(
                 leading: CircleAvatar(
                   backgroundColor: Colors.deepPurpleAccent,
                   child: Text(
                     apiHandlerController.postsList[index].Id.toString(),
                     style: TextStyle(
                       color: Colors.grey.shade800,
                       fontWeight: FontWeight.w500,
                       fontSize: 20,
                     ),
                   ),
                 ),
                 title: Text(apiHandlerController.postsList[index].title,
                 style: TextStyle(
                   color: Colors.deepPurpleAccent,
                   fontWeight: FontWeight.w500,
                   fontSize: 22
                 ),
                 ),
                 subtitle: Text(apiHandlerController.postsList[index].body),

               );
             }else{
               return apiHandlerController.isMoreDataFetching.value ? Padding(
                 padding: const EdgeInsets.all(20.0),
                 child: Center(child: CircularProgressIndicator()),
               ): Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Container(
                   decoration: BoxDecoration(
                     color: Colors.deepPurpleAccent,
                     borderRadius: BorderRadius.circular(28),
                   ),
                   child: Padding(
                     padding: const EdgeInsets.all(18.0),
                     child: Text('no more data', style: TextStyle(
                       color: Colors.white,
                       fontSize: 16,
                     ),),
                   ),
                 ),
               );
             }
            },
          ),
        )
    );
  }
}
