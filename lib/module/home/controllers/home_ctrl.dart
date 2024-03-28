import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:wcc_emodule/module/emodule/models/emodule_model.dart';
import 'package:wcc_emodule/module/global/api_service.dart';
import 'package:wcc_emodule/module/main/controllers/main_ctrl.dart'; 
import 'package:wcc_emodule/module/dashboard/controllers/dashboard_ctrl.dart';  

class HomeController extends GetxController {

  final storage = GetStorage();
  late BuildContext context;

  MainController mainCtrl = Get.find();
  DashboardController dashCtrl = Get.find();  
  ApiService apiService = Get.find(); 

  var isLoading = false.obs;
  var isCollapsed = false.obs;

  RxList<LessonList> lessonDataList = <LessonList>[].obs; 
  var hasBookmarked = false.obs;
  late LessonList lessonData; 

  @override
  Future<void> onInit() async {
    debugPrint("==> HomeController");
    loadInitialized();
    super.onInit();
  }
  
  @override
  Future<void> onClose() async {
    super.onClose();
  }

  loadInitialized() async {
    loadBookmarked();
  } 

  loadBookmarked(){ 
    hasBookmarked.value = false;
    if(storage.hasData('bookmarked_data') && storage.read('bookmarked_data').isNotEmpty) {
      lessonDataList.assignAll(lessonListFromJson(storage.read('bookmarked_data'))); 
      lessonDataList.refresh();
      if(lessonDataList.isNotEmpty) {
        hasBookmarked.value = true;
      } 
    }
  }
   
  unbookmarkLesson(data) async {  
    Get.dialog(
      AlertDialog(
        title: const Text('Are you sure?'),
        content: const Text('Do you want to remove this lesson in bookmarked?'),
        actions: [
          TextButton(
            child: const Text("Yes"),
            onPressed: () {
              RxList<LessonList> lessonDataList = <LessonList>[].obs; 
              if(storage.hasData('bookmarked_data') && storage.read('bookmarked_data').isNotEmpty) {
                lessonDataList.assignAll(lessonListFromJson(storage.read('bookmarked_data')));
                RxList<LessonList> matches = <LessonList>[].obs; 
                matches.addAll(lessonDataList);
                matches.retainWhere((s) => s.id!=data.id); 
                 
                storage.write('bookmarked_data', lessonListToJson(matches)); 
                loadBookmarked();
                Get.back();
                Get.back();
              } 
            }
          ),
          TextButton(
            child: const Text("Cancel"),
            onPressed: () => Get.back(),
          ),
        ],
      ),
    );
    
  }

  
  // Widget contactBottomSheet(title, data) {
  //   var id = 0;
  //   if(title!='Add'){ 
  //     id = data.id;
  //     nameCtrl.text = data.name;
  //     numberCtrl.text = data.contact;
  //   }
  //   return Container(
  //     padding: EdgeInsets.all(20.0),
  //     child: Column(
  //       mainAxisSize: MainAxisSize.min,
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: <Widget>[
  //         Row(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Expanded(
  //               child: Text(
  //                 title+" Contact",
  //                 style: AppTheme.dynamicStyle(color:AppTheme.greyDark, size:18.0, weight:FontWeight.w600)
  //               ),
  //             ),
  //             GestureDetector(
  //               behavior: HitTestBehavior.translucent,
  //               child: Icon(Icons.close, color: AppTheme.black),
  //               onTap: () {
  //                 Get.back();
  //               },
  //             ),
  //           ],
  //         ),
  //         SizedBox(height: 25),
          
  //         // Subject  
  //         TextFormField(
  //           controller: nameCtrl,
  //           textCapitalization: TextCapitalization.sentences,
  //           keyboardType: TextInputType.name,
  //           decoration: InputDecoration(
  //             hintText: 'Name',
  //             hintStyle: AppTheme.dynamicStyle(color: AppTheme.whiteOff, size:16.0),
  //             border: OutlineInputBorder(
  //               borderSide: BorderSide(
  //                 color: AppTheme.whiteBlur,
  //                 width: 1,
  //               ),
  //             ),
  //           ),
  //           style: AppTheme.dynamicStyle(color: AppTheme.black, size:16.0), 
  //         ),
  //         SizedBox(height: 20),
          
  //         // Number  
  //         TextFormField(
  //           controller: numberCtrl,
  //           textCapitalization: TextCapitalization.sentences,
  //           keyboardType: TextInputType.phone,
  //           decoration: InputDecoration(
  //             hintText: 'Number',
  //             hintStyle: AppTheme.dynamicStyle(color: AppTheme.whiteOff, size:16.0),
  //             border: OutlineInputBorder(
  //               borderSide: BorderSide(
  //                 color: AppTheme.whiteBlur,
  //                 width: 1,
  //               ),
  //             ),
  //           ),
  //           style: AppTheme.dynamicStyle(color: AppTheme.black, size:16.0), 
  //         ),
  //         SizedBox(height: 30),

  //         Align(
  //           alignment: Alignment.bottomCenter,
  //           child: ElevatedButton( 
  //             child: Text(
  //               "Save",
  //               style: AppTheme.dynamicStyle(color: AppTheme.white, size:18.0, weight:FontWeight.w700)
  //             ),
  //             style: ElevatedButton.styleFrom(
  //               minimumSize: Size(double.maxFinite, 50),
  //               primary: AppTheme.purple,
  //               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
  //             ),
  //             onPressed: () async {
  //               if(nameCtrl.text.isEmpty) { 
  //                 GblFn.showSnackbar("Oops", "Please enter name!",'error');
  //               } else if(numberCtrl.text.isEmpty) { 
  //                 GblFn.showSnackbar("Oops", "Please enter number!",'error');
  //               } else { 
  //                 if(title=='Add'){
  //                   submitUserContact();
  //                 } else {
  //                   updateUserContact(id);
  //                 }
  //               }
  //             },
  //           )
  //         ), 
  //         SizedBox(height: 15),
  //       ],
  //     ),
  //   );
  // }

  //-------------------------------------------------------------------------
  //Start Emergency Call
 

  // updateUserContact(id) async {  
  //   try {
  //     isLoading.value = true;
  //     var data =  {
  //       "id": id.toString(),
  //       "user_id": apiService.userModel.id.toString(),
  //       "name": nameCtrl.text,
  //       "contact": numberCtrl.text
  //     };
  //     var res = await apiService.postData('/update-user-contact', data); 
  //     if (res.statusCode == 200 && res.data.toString()=='_exist_contact') {  
  //       GblFn.showSnackbar("Oops", "This contact already exist!",'error');
  //     } else if (res.statusCode == 200 && res.data.toString()=='_error') {  
  //       GblFn.showSnackbar("Oops", "Cannot save this contact, please try again!",'error');
  //     } else {  
  //       storage.write('usercontact', res.data.toString());
  //       mainCtrl.userContactList.assignAll(userContactModelFromJson(res.data.toString()));
  //       mainCtrl.userContactList.refresh();
  //       nameCtrl.clear();
  //       numberCtrl.clear();

  //       Get.back();
  //     } 
  //   } catch (e) {
  //     print(e.toString());
  //   } finally {
  //     isLoading.value = false;
  //   }
  // } 

  
} 
