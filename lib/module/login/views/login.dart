import 'package:flutter/material.dart';
import 'package:get/get.dart'; 
import 'package:loading_overlay/loading_overlay.dart';
import 'package:wcc_emodule/module/global/app_theme.dart';
import 'package:wcc_emodule/module/global/gbl_fn.dart'; 
import 'package:wcc_emodule/module/login/controllers/login_ctrl.dart';
import 'package:wcc_emodule/routes/app_routes.dart';  

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
 
    LoginController loginCtrl = Get.find();

    final formKey = GlobalKey<FormState>();

    return Scaffold(
      backgroundColor: AppTheme.white,
      body: Obx(() => LoadingOverlay(
        isLoading: loginCtrl.isLoading.value,
        opacity: 0.5,
        progressIndicator: const CircularProgressIndicator(),
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Container(
                margin: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      const Spacer(),
                      const SizedBox(height: 40),
                      // Header
                      Center(
                        child: Image.asset(
                          "assets/images/logo-dark.png",
                          fit: BoxFit.fill,
                          width: 200,
                        ),
                      ),
                      const SizedBox(height: 20),
                      
                      // Student Id
                      TextFormField(
                        controller: loginCtrl.studIdCtrl,
                        decoration: AppTheme.dynamicInputDecoration(label:'Student ID', textColor: AppTheme.black),
                        style: AppTheme.dynamicStyle(color: AppTheme.black, size:16.0),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your Student Id';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),
                      
                      // Password
                      TextFormField(
                        controller: loginCtrl.passwordCtrl,
                        decoration: AppTheme.dynamicInputDecoration(
                          label:'Password', 
                          textColor: AppTheme.black,
                          suffixIcon: IconButton(
                            onPressed: () {
                              loginCtrl.isObscure.value = !loginCtrl.isObscure.value;
                            },
                            icon: Icon((loginCtrl.isObscure.value)
                              ? Icons.visibility
                              : Icons.visibility_off,
                              size: 16.0
                            ),
                            color: AppTheme.whiteSmoke,
                          ),
                        ),
                        style: AppTheme.dynamicStyle(color: AppTheme.black, size:16.0),
                        enableSuggestions: false,
                        obscureText: loginCtrl.isObscure.value,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Checkbox(
                            value: loginCtrl.isAgreed.value,
                            activeColor: AppTheme.purple,
                            onChanged: (value) {
                              loginCtrl.isAgreed.value = value ?? false;
                            },
                          ),
                          TextButton(
                            child: Text(
                              "I agree to Terms & Conditions",
                              style: AppTheme.dynamicStyle(color: AppTheme.blueLink, size:14.0)
                            ),
                            onPressed: () {
                              Get.toNamed(Routes.TERMS);
                            },
                          ),
                        ]
                      ),
                      const Spacer(),

                      // Login
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
                                if (!loginCtrl.isAgreed.value) {
                                  GblFn.showSnackbar("Error", "Please accept the Terms and Conditions.",'error');
                                } else if (!formKey.currentState!.validate()) {
                                  GblFn.showSnackbar("Error", "Your user ID or password is incorrect.",'error');
                                } else {
                                  loginCtrl.submitLogin();
                                }  
                              }, 
                              child: Text(
                                "Login",
                                style: AppTheme.dynamicStyle(color: AppTheme.white, size:18.0, weight:FontWeight.w700)
                              ),
                            ), 
                            const SizedBox(height: 35),
                          ],
                        )
                      )
                    ],
                  )
                )
              )
            )
          ]
        )
      )),
    );

  }

}
