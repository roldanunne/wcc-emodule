import 'package:auto_size_text_plus/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:wcc_emodule/module/global/app_theme.dart'; 
import 'package:wcc_emodule/module/home/controllers/home_ctrl.dart'; 
import 'package:date_format/date_format.dart';
import 'package:wcc_emodule/module/main/controllers/main_ctrl.dart';
import 'package:wcc_emodule/routes/app_routes.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
 
    MainController mainCtrl = Get.find();
    HomeController ctrl = Get.find(); 

    ctrl.context = context; 

    return Obx(() => Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        toolbarHeight: 100, // Set this height
        flexibleSpace: Container( 
          padding: const EdgeInsets.symmetric(horizontal:10.0, vertical: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 28), 
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/logo.png",
                    width: 50.0,
                  ),
                  const SizedBox(width: 5), 
                  AutoSizeText(
                    'NAVIGATIONAL TRAINING',
                    style: AppTheme.dynamicStyle(
                      color: AppTheme.primary, 
                      size:20.0, 
                      weight: FontWeight.w700, 
                      shadow: [ 
                        const Shadow(
                          color: Colors.grey,      // Choose the color of the shadow
                          blurRadius: 3.0,          // Adjust the blur radius for the shadow effect
                          offset: Offset(0.5, 1.0), // Set the horizontal and vertical offset for the shadow
                        ),
                      ]),
                    maxLines: 1,
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: <Widget>[ 
          PopupMenuButton( 
            icon: const Icon(Icons.menu, size:30, color:AppTheme.red),
            itemBuilder: (context){
              return [
                  const PopupMenuItem<int>(
                    value: 0,
                    child: Row( 
                      children: [
                        Icon(Icons.person),
                        Text("Profile"),
                      ]
                    )
                  ),
                  const PopupMenuItem<int>(
                    value: 1,
                    child: Row( 
                      children: [
                        Icon(Icons.key),
                        Text("Password"),
                      ]
                    )
                  ),
                  const PopupMenuItem<int>(
                    value: 2,
                    child: Row( 
                      children: [
                        Icon(Icons.sync),
                        Text("Sync"),
                      ]
                    ),
                  ),
                  const PopupMenuItem<int>(
                    value: 3,
                    child: Row( 
                      children: [
                        Icon(Icons.logout),
                        Text("Logout"),
                      ]
                    ),
                  ),
                ];
            },
            onSelected:(value){
              if(value == 0){
                Get.toNamed(Routes.HOME_INFO);
              }else if(value == 1){ 
                Get.offAllNamed(Routes.PASSWORD_CHANGE);
              }else if(value == 2){ 
                mainCtrl.syncData();
              }else if(value == 3){
                ctrl.storage.erase(); 
                Get.offAllNamed(Routes.LOGIN);
              }
            }
          ),

        ],
        backgroundColor: AppTheme.white,
        shadowColor: AppTheme.grey,
        elevation: 3.0,
        leading: null,
        systemOverlayStyle: SystemUiOverlayStyle.dark, 
      ),
      backgroundColor: AppTheme.background,
      body: LoadingOverlay( 
        isLoading: ctrl.isLoading.value,
        opacity: 0.5,
        progressIndicator: const CircularProgressIndicator(),
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[  
                Container(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Bookmark List",
                        style: AppTheme.dynamicStyle(color:AppTheme.black, size:18.0, weight: FontWeight.w600)
                      ),
                      const Divider(color: AppTheme.black, height: 10, thickness: 0.5),  
                      // Scrolling Page Area
                      if(ctrl.hasBookmarked.value)
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: ctrl.lessonDataList.length,
                        padding: const EdgeInsets.only(top:0, bottom: 50),
                        itemBuilder: (_, i){
                          var v = ctrl.lessonDataList[i]; 
                          return GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
                              margin: const EdgeInsets.symmetric(vertical: 6.0),
                              decoration: AppTheme.containerBoxDecoration(borderRadius: 12.0),
                              height: 100,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  AutoSizeText(
                                     v.title,
                                    style: AppTheme.dynamicStyle(color:AppTheme.black, size:18.0, weight: FontWeight.w600),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis
                                  ),
                                  Text(
                                    formatDate(v.createdAt, [MM, ' ', d, ' ', yy]),
                                    style: AppTheme.dynamicStyle(color:AppTheme.grey, size:14.0, weight: FontWeight.w500)
                                  ),
                                ],
                              ),
                            ),
                            onTap: () async { 
                              ctrl.lessonData = v; 
                              Get.toNamed(Routes.BOOKMARK_DETAILS);
                            },
                          );
                        }
                      ),
                      if(!ctrl.hasBookmarked.value)
                      Container(
                        padding: const EdgeInsets.only(bottom: 50),
                        child: Text(
                          "No Bookmark List",
                          style: AppTheme.dynamicStyle(color:AppTheme.red, size:16.0, weight: FontWeight.w400)
                        ),
                      ),
                    ],
                  ),
                ),  
                const SizedBox(height: 15),
                Container(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Taken Quiz",
                        style: AppTheme.dynamicStyle(color:AppTheme.black, size:18.0, weight: FontWeight.w600)
                      ),
                      const Divider(color: AppTheme.black, height: 10, thickness: 0.5),  
                      // Scrolling Page Area
                      if(mainCtrl.takeQuizModelList.isNotEmpty)
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: mainCtrl.takeQuizModelList.length,
                        padding: const EdgeInsets.only(top:0, bottom: 50),
                        itemBuilder: (_, i){
                          var v = mainCtrl.takeQuizModelList[i]; 
                          return GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
                              margin: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
                              color: null,
                              decoration: AppTheme.containerBoxDecoration(borderRadius: 12.0),
                              // height: 100,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                     v.title,
                                    style: AppTheme.dynamicStyle(color:AppTheme.black, size:16.0, weight: FontWeight.w400)
                                  ), 
                                  Text(
                                    "Total Question: ${v.question}",
                                    style: AppTheme.dynamicStyle(color:AppTheme.black, size:12.0, weight: FontWeight.w400)
                                  ),
                                  Text(
                                    "Score: ${v.score}",
                                    style: AppTheme.dynamicStyle(color:AppTheme.black, size:12.0, weight: FontWeight.w400)
                                  ),
                                  Text(
                                    "Remark: ${v.result}",
                                    style: AppTheme.dynamicStyle(color:AppTheme.black, size:12.0, weight: FontWeight.w400)
                                  ), 
                                  Text(
                                    "Date Taken: ${formatDate(v.createdAt, [d, ' ', M, ' ', yy,' at ', h,':',nn,' ',am])}",
                                    style: AppTheme.dynamicStyle(color:AppTheme.black, size:12.0, weight: FontWeight.w400)
                                  ),
                                ],
                              ),
                            ),
                            onTap: () async { 
                            },
                          );
                        }
                      ),
                      if(mainCtrl.takeQuizModelList.isEmpty)
                      Container(
                        padding: const EdgeInsets.only(bottom: 50),
                        child: Text(
                          "No taken quiz",
                          style: AppTheme.dynamicStyle(color:AppTheme.red, size:16.0, weight: FontWeight.w400)
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      )
    ));

  }

}
