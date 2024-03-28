import 'package:auto_size_text_plus/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:wcc_emodule/module/global/api_service.dart';
import 'package:wcc_emodule/module/global/app_theme.dart';
import 'package:wcc_emodule/module/home/controllers/info_ctrl.dart';
import 'package:wcc_emodule/module/main/controllers/main_ctrl.dart';
import 'package:wcc_emodule/routes/app_routes.dart'; 

class InfoPage extends StatelessWidget {
  const InfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    InfoController infoCtrl = Get.find();
    ApiService apiService = Get.find(); 

    infoCtrl.context = context;

    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        toolbarHeight: 100, // Set this height
        flexibleSpace: Container( 
          color: Colors.transparent,
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
                    'Profile',
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
        backgroundColor: AppTheme.white,
        shadowColor: AppTheme.grey,
        elevation: 3.0,
        leading: null,
        systemOverlayStyle: SystemUiOverlayStyle.dark, 
      ),
      backgroundColor: AppTheme.white,
      body: Obx(() => LoadingOverlay(
        isLoading: infoCtrl.isLoading.value,
        opacity: 0.5,
        progressIndicator: const CircularProgressIndicator(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SingleChildScrollView(
              child: Container(
                color: AppTheme.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(height: 10),
                    GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(20, 15, 5, 15),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.arrow_back, size:28, color: AppTheme.red),
                            const SizedBox(width: 5),
                            Text(
                              "Back Home",
                              style: AppTheme.dynamicStyle(color:AppTheme.red, size:16.0, weight: FontWeight.w600)
                            ),
                          ],
                        ),

                      ),
                      onTap: () {  
                        Get.back();
                      },
                    ),
                    const Divider(color: AppTheme.black, height: 10, thickness: 0.5), 
                    const SizedBox(height: 10), 
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Name",
                            style: AppTheme.dynamicStyle(color:AppTheme.black, size:12.0)
                          ),
                          Text(
                            '${apiService.userModel.fname} ${apiService.userModel.lname}',
                            style: AppTheme.dynamicStyle(color:AppTheme.primary, size:16.0, weight: FontWeight.w600)
                          ), 
                        ],
                      ),
                    ),
                    const Divider(color: AppTheme.black, height: 10, thickness: 0.5),  
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "User ID",
                            style: AppTheme.dynamicStyle(color:AppTheme.black, size:12.0)
                          ),
                          Text(
                            apiService.userModel.idNo,
                            style: AppTheme.dynamicStyle(color:AppTheme.primary, size:16.0, weight: FontWeight.w600)
                          ), 
                        ],
                      ),
                    ),
                    const Divider(color: AppTheme.black, height: 10, thickness: 0.5), 
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Email",
                            style: AppTheme.dynamicStyle(color:AppTheme.black, size:12.0)
                          ),
                          Text(
                            apiService.userModel.email,
                            style: AppTheme.dynamicStyle(color:AppTheme.primary, size:16.0, weight: FontWeight.w600)
                          ), 
                        ],
                      ),
                    ),
                    const Divider(color: AppTheme.black, height: 10, thickness: 0.5), 
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Mobile",
                            style: AppTheme.dynamicStyle(color:AppTheme.black, size:12.0)
                          ),
                          Text(
                            apiService.userModel.mobile,
                            style: AppTheme.dynamicStyle(color:AppTheme.primary, size:16.0, weight: FontWeight.w600)
                          ), 
                        ],
                      ),
                    ),
                    const Divider(color: AppTheme.black, height: 10, thickness: 0.5), 
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Gender",
                            style: AppTheme.dynamicStyle(color:AppTheme.black, size:12.0)
                          ),
                          Text(
                            apiService.userModel.gender,
                            style: AppTheme.dynamicStyle(color:AppTheme.primary, size:16.0, weight: FontWeight.w600)
                          ), 
                        ],
                      ),
                    ), 
                    const Divider(color: AppTheme.black, height: 10, thickness: 0.5),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Address",
                            style: AppTheme.dynamicStyle(color:AppTheme.black, size:12.0)
                          ),
                          Text(
                            apiService.userModel.address,
                            style: AppTheme.dynamicStyle(color:AppTheme.primary, size:16.0, weight: FontWeight.w600)
                          ), 
                        ],
                      ),
                    ), 
                    const Divider(color: AppTheme.black, height: 10, thickness: 0.5), 
                    const SizedBox(height: 15),

                    GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(20, 15, 5, 15),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Log Out",
                              style: AppTheme.dynamicStyle(color:AppTheme.red, size:16.0, weight: FontWeight.w600)
                            ),
                            const SizedBox(width: 10),
                            const Icon(Icons.logout, size:28, color: AppTheme.red),
                          ],
                        ),

                      ),
                      onTap: () {  
                        // infoCtrl.storage.remove("userdata"); 
                        infoCtrl.storage.erase(); 
                        Get.offAllNamed(Routes.LOGIN);
                      },
                    ),
                    const SizedBox(height: 15),
                  ], 
                ), 
              ), 
            )
                       
          ]
        ))
      )
    );

  }

}
