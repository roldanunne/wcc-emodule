import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:wcc_emodule/module/global/app_theme.dart';
import 'package:wcc_emodule/module/login/controllers/login_ctrl.dart';  

class TermsPage extends StatelessWidget {
  const TermsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    LoginController loginCtrl = Get.find();

    return Scaffold(
      backgroundColor: AppTheme.white,
      body: Obx(() => LoadingOverlay(
        isLoading: loginCtrl.isLoading.value,
        opacity: 0.5,
        progressIndicator: const CircularProgressIndicator(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 70),
            // Header
            Center(
              child: Image.asset(
                "assets/images/logo-dark.png",
                fit: BoxFit.fill,
                width: 200,
              ),
            ),
            const SizedBox(height: 20), 
                 
            // Scrolling Page Area
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  color: AppTheme.white,
                  margin: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[ 
                      HtmlWidget(
                        loginCtrl.termsdata.value,
                      ),
                      const SizedBox(height: 30), 

                      // Back
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            ElevatedButton( 
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(double.maxFinite, 50),
                                primary: AppTheme.primary,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                              ),
                              onPressed: () async {
                                Get.back();
                              }, 
                              child: Text(
                                "Back",
                                style: AppTheme.dynamicStyle(color: AppTheme.white, size:18.0, weight:FontWeight.w700)
                              ),
                            ), 
                            const SizedBox(height: 35),
                          ],
                        )
                      )
                    ],
                  ),
                ),
              ),
            ),  
          ]
        ))
      )
    );

  }

}
