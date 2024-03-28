import 'package:flutter/material.dart';
import 'package:get/get.dart'; 
import 'package:loading_overlay/loading_overlay.dart';
import 'package:wcc_emodule/module/global/app_theme.dart';
import 'package:wcc_emodule/module/global/gbl_fn.dart'; 
import 'package:wcc_emodule/module/login/controllers/login_ctrl.dart';  

class PasswordPage extends StatelessWidget {
  const PasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
 
    LoginController ctrl = Get.find();

    final formKey = GlobalKey<FormState>();

    ctrl.studIdCtrlEdit.text = ctrl.mainCtrl.apiService.userModel.idNo.toString();
    
    return Scaffold(
      backgroundColor: AppTheme.white,
      body: Obx(() => LoadingOverlay(
        isLoading: ctrl.isLoading.value,
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

                      Text(
                        "Change Password",
                        style: AppTheme.dynamicStyle(color:AppTheme.black, size:18.0)
                      ),
                      
                      // Student Id
                      TextFormField(
                        controller: ctrl.studIdCtrlEdit,
                        decoration: AppTheme.dynamicInputDecoration(label:'Student ID', textColor: AppTheme.black),
                        style: AppTheme.dynamicStyle(color: AppTheme.black, size:16.0),
                        readOnly: true,
                      ),
                      const SizedBox(height: 15),
                      
                      // Password
                      TextFormField(
                        controller: ctrl.passwordCtrlEdit,
                        decoration: AppTheme.dynamicInputDecoration(
                          label:'Password', 
                          textColor: AppTheme.black,
                          suffixIcon: IconButton(
                            onPressed: () {
                              ctrl.isObscure.value = !ctrl.isObscure.value;
                            },
                            icon: Icon((ctrl.isObscure.value)
                              ? Icons.visibility
                              : Icons.visibility_off,
                              size: 16.0
                            ),
                            color: AppTheme.whiteSmoke,
                          ),
                        ),
                        style: AppTheme.dynamicStyle(color: AppTheme.black, size:16.0),
                        enableSuggestions: false,
                        obscureText: ctrl.isObscure.value,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                      ),
                      
                      // Password
                      TextFormField(
                        controller: ctrl.repasswordCtrlEdit,
                        decoration: AppTheme.dynamicInputDecoration(
                          label:'Confirm Password', 
                          textColor: AppTheme.black,
                          suffixIcon: IconButton(
                            onPressed: () {
                              ctrl.isObscure1.value = !ctrl.isObscure1.value;
                            },
                            icon: Icon((ctrl.isObscure1.value)
                              ? Icons.visibility
                              : Icons.visibility_off,
                              size: 16.0
                            ),
                            color: AppTheme.whiteSmoke,
                          ),
                        ),
                        style: AppTheme.dynamicStyle(color: AppTheme.black, size:16.0),
                        enableSuggestions: false,
                        obscureText: ctrl.isObscure1.value,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Please confirm password';
                          }
                          return null;
                        },
                      ),
                      const Spacer(),

                      // Submit
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
                                if (!formKey.currentState!.validate()) {
                                  GblFn.showSnackbar("Error", "Your password is incorrect.",'error');
                                } else {
                                  ctrl.submitPassword();
                                }  
                              }, 
                              child: Text(
                                "Submit",
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
