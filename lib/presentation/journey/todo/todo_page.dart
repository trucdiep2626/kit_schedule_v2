import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:kit_schedule_v2/common/common_export.dart';
import 'package:kit_schedule_v2/common/utils/date_time_format.dart';
import 'package:kit_schedule_v2/common/utils/export.dart';
import 'package:kit_schedule_v2/presentation/journey/personal/personal_controller.dart';
import 'package:kit_schedule_v2/presentation/journey/todo/components/cupertino_rounded_datepicker_widget.dart';
import 'package:kit_schedule_v2/presentation/journey/todo/components/todo_form_widget.dart';
import 'package:kit_schedule_v2/presentation/journey/todo/todo_controller.dart';
import 'package:kit_schedule_v2/presentation/theme/export.dart';
import 'package:kit_schedule_v2/presentation/widgets/loading_widget.dart';

class TodoPage extends GetView<TodoController> {
  //
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   // if (widget.personalSchedule != null) {
  //   //   debugPrint(DateTime.utc(DateTime.now().year, DateTime.now().month,
  //   //       DateTime.now().day, 0, 0, 0, 0)
  //   //       .millisecondsSinceEpoch
  //   //       .toString());
  //   //   debugPrint(widget.personalSchedule!.id);
  //   //   _nameController.text = widget.personalSchedule!.name!;
  //   //   _noteController.text = widget.personalSchedule!.note!;
  //   // }
  //
  //   //super.initState();
  // }
  //
  // @override
  // void dispose() {
  //   super.dispose();
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondColor,
      // appBar:
      // widget.personalSchedule == null
      //     ? null
      //     :
      // AppBar(
      //   elevation: 0,
      //   backgroundColor: Colors.transparent,
      //   leading: BackButton(
      //     color: AppColors.personalScheduleColor2,
      //   ),
      //   actions: <Widget>[
      //     IconButton(
      //         onPressed: () => warningDialog(
      //             name: widget.personalSchedule!.name,
      //             context: context,
      //             isSynch: true,
      //             btnOk: _bntOkDialogOnPress,
      //             btnCancel: (context) {
      //               Navigator.pop(context);
      //             }),
      //         icon: Icon(
      //           Icons.delete,
      //           color: AppColors.personalScheduleColor2,
      //           size: ToDoConstants.iconSize,
      //         ))
      //   ],
      // ),
      body: SafeArea(
          child:
              // BlocListener<TodoBloc, TodoState>(
              //   listener: (context, state) {
              //     if (state is TodoSuccessState) {
              //       if (widget.personalSchedule == null) {
              //         _noteController.text = "";
              //         _nameController.text = "";
              //       } else {
              //         Navigator.pop(context, 'ok');
              //       }
              //     } else if (state is TodoFailureState) {}
              //   },
              //   child: BlocBuilder<TodoBloc, TodoState>(builder: (context, state) {
              //    return
              Stack(
        fit: StackFit.expand,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  'Tạo ghi chú',
                  // widget.personalSchedule == null
                  //     ? AppLocalizations.of(context)!.createTodo
                  //     : AppLocalizations.of(context)!.editTodo,
                  style: ThemeText.headerStyle2.copyWith(fontSize: 18.sp),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child:  TodoFormWidget(

                     ),
                  ),
                ),
              ],
            ),
          ),
         Obx(()=>  Positioned(
           left: 0,
           right: 0,
           bottom: 10.sp,
           child: controller.isKeyboard.value
               ? SizedBox()
               : Container(
             margin: EdgeInsets.symmetric(horizontal: 16.sp),
             child: controller.rxTodoLoadedType.value == LoadedType.start
                 ? Container(
               child: LoadingWidget(),
             )
                 : GestureDetector(
               onTap: () {},
               // widget.personalSchedule == null
               //     ? _setOnClickSaveButton
               //     : _setOnClickUpdateButton,
               child: Container(
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(20),
                   color: AppColors.personalScheduleColor2,
                   boxShadow: [
                     BoxShadow(
                       color:
                       AppColors.primaryColor.withOpacity(0.3),
                       blurRadius: 5,
                       spreadRadius: 1,
                       offset: Offset(
                         0,
                         3,
                       ),
                     )
                   ],
                 ),
                 width: double.infinity,
                 alignment: Alignment.center,
                 padding: EdgeInsets.symmetric(vertical: 12.sp),
                 child: Text(
                   'Lưu',
                   style: ThemeText.titleStyle.copyWith(
                     color: AppColors.secondColor,
                   ),
                 ),
               ),
             ),
           ),
         )),
        ],
      )
          //;
          //       }),
          ),
      //   ),
    );
  }



  _setOnClickSaveButton(BuildContext context) {
    FocusScope.of(context).requestFocus(new FocusNode());
    if (controller.formKey.currentState!.validate()) {
      // BlocProvider.of<TodoBloc>(context)
      //   ..add(CreatePersonalScheduleOnPressEvent(
      //       _nameController.text.trim(), _noteController.text.trim()));
    }
  }

  _setOnClickUpdateButton(BuildContext context) {
    FocusScope.of(context).requestFocus(new FocusNode());
    if (controller.formKey.currentState!.validate()) {
      // debugPrint(
      //     '>>>>>>>>>>>.id: ' + (this.widget.personalSchedule!.id as String));
      // BlocProvider.of<TodoBloc>(context)
      //   ..add(
      //     UpdatePersonalScheduleOnPressEvent(
      //         this.widget.personalSchedule!.id as String,
      //         _nameController.text.trim(),
      //         _noteController.text.trim(),
      //         widget.personalSchedule!.createAt!),
      //   );
    }
  }

  // _waitingDeleteDialog() {
  //   AwesomeDialog(
  //       context: context,
  //       dialogType: DialogType.WARNING,
  //       animType: AnimType.BOTTOMSLIDE,
  //       body: Padding(
  //         padding: EdgeInsets.symmetric(horizontal: 10.w),
  //         child: Column(
  //           children: [
  //             RichText(
  //               textAlign: TextAlign.center,
  //               text: TextSpan(
  //                   text: AppLocalizations.of(context)!.doYouWant,
  //                   style: ThemeText.titleStyle.copyWith(
  //                       color: Colors.black54, fontWeight: FontWeight.normal),
  //                   children: [
  //                     TextSpan(
  //                         text: AppLocalizations.of(context)!.delete,
  //                         style: ThemeText.titleStyle.copyWith(
  //                           color: AppColor.errorColor,
  //                         )),
  //                   ]),
  //             ),
  //             Text(
  //               '${this.widget.personalSchedule!.name}?',
  //               style: ThemeText.titleStyle.copyWith(
  //                 color: Colors.black54,
  //                 fontWeight: FontWeight.normal,
  //               ),
  //               overflow: TextOverflow.ellipsis,
  //               maxLines: 3,
  //             )
  //           ],
  //         ),
  //       ),
  //       btnOk: GestureDetector(
  //         onTap: () => _bntOkDialogOnPress(context),
  //         child: Container(
  //           decoration: BoxDecoration(
  //             borderRadius: BorderRadius.circular(20),
  //             color: AppColor.fourthColor,
  //             boxShadow: [
  //               BoxShadow(
  //                 color: AppColor.primaryColor.withOpacity(0.3),
  //                 blurRadius: 5,
  //                 spreadRadius: 1,
  //                 offset: Offset(
  //                   0,
  //                   3,
  //                 ),
  //               )
  //             ],
  //           ),
  //           alignment: Alignment.center,
  //           child: Padding(
  //             padding: EdgeInsets.symmetric(
  //                 vertical: ToDoConstants.paddingVertical,
  //                 horizontal: ToDoConstants.paddingHorizontal),
  //             child: Text(
  //               AppLocalizations.of(context)!.yes,
  //               style: ThemeText.buttonLabelStyle.copyWith(
  //                   color: AppColor.secondColor, fontWeight: FontWeight.bold),
  //             ),
  //           ),
  //         ),
  //       ),
  //       btnCancel: GestureDetector(
  //         onTap: () => Navigator.of(context).pop(),
  //         child: Container(
  //           decoration: BoxDecoration(
  //             borderRadius: BorderRadius.circular(20),
  //             color: AppColor.errorColor,
  //             boxShadow: [
  //               BoxShadow(
  //                 color: AppColor.primaryColor.withOpacity(0.3),
  //                 blurRadius: 5,
  //                 spreadRadius: 1,
  //                 offset: Offset(
  //                   0,
  //                   3,
  //                 ),
  //               )
  //             ],
  //           ),
  //           alignment: Alignment.center,
  //           child: Padding(
  //             padding: EdgeInsets.symmetric(
  //                 vertical: ToDoConstants.paddingVertical,
  //                 horizontal: ToDoConstants.paddingHorizontal),
  //             child: FittedBox(
  //               child: Text(AppLocalizations.of(context)!.no,
  //                   style: ThemeText.buttonLabelStyle.copyWith(
  //                       color: AppColor.secondColor,
  //                       fontWeight: FontWeight.bold)),
  //             ),
  //           ),
  //         ),
  //       )).show();
  // }

  _bntOkDialogOnPress(BuildContext context) {
    Get.back();
    // debugPrint(widget.personalSchedule!.id);
    // BlocProvider.of<TodoBloc>(context)
    //   ..add(DetelePersonalScheduleOnPressEvent(widget.personalSchedule!));
    debugPrint('delete to do');
  }
}
