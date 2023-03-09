import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kit_schedule_v2/common/common_export.dart';
import 'package:kit_schedule_v2/presentation/journey/todo/components/todo_form_widget.dart';
import 'package:kit_schedule_v2/presentation/journey/todo/todo_controller.dart';
import 'package:kit_schedule_v2/presentation/theme/export.dart';
import 'package:kit_schedule_v2/presentation/widgets/app_dialog.dart';
import 'package:kit_schedule_v2/presentation/widgets/loading_widget.dart';
import 'package:kit_schedule_v2/presentation/widgets/warning_dialog.dart';

class TodoPage extends GetView<TodoController> {
  const TodoPage({Key? key}) : super(key: key);

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
    controller.context = context;
    return WillPopScope(
      onWillPop: () async {
        controller.resetData();
        return true;
      },
      child: Scaffold(
        backgroundColor: AppColors.bianca,
        // appBar:
        // widget.personalSchedule == null
        //     ? null
        //     :
        // AppBar(
        //   elevation: 0,
        //   backgroundColor: Colors.transparent,
        //   leading: BackButton(
        //     color: AppColors.blue900,
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
        //           color: AppColors.blue900,
        //           size: ToDoConstants.iconSize,
        //         ))
        //   ],
        // ),
        body: Stack(
          fit: StackFit.expand,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: 16.sp,
                  right: 16.sp,
                  top: Get.mediaQuery.padding.top + 16.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // SizedBox(
                  //   height: 10.h,
                  // ),
                  Obx(() => Row(
                        children: [
                          Expanded(
                            child: Text(
                              controller.personalSchedule.value == null
                                  ? 'Tạo ghi chú'
                                  : 'Sửa ghi chú',
                              style: ThemeText.bodySemibold.s18,
                            ),
                          ),
                          controller.personalSchedule.value == null
                              ? const SizedBox.shrink()
                              : IconButton(
                                  onPressed: () => warningDialog(
                                      name: controller
                                              .personalSchedule.value?.name ??
                                          '',
                                      context: context,
                                      //    isSynch: true,
                                      btnOk: () async =>
                                          await _bntOkDialogOnPress(),
                                      btnCancel: () => Get.back()),
                                  icon: Icon(
                                    Icons.delete,
                                    color: AppColors.blue900,
                                    size: 24.sp,
                                  ))
                        ],
                      )),

                  SizedBox(
                    height: 16.h,
                  ),
                  const Expanded(
                    child: SingleChildScrollView(
                      child: TodoFormWidget(),
                    ),
                  ),
                ],
              ),
            ),
            Obx(() => Positioned(
                  left: 0,
                  right: 0,
                  bottom: 10.sp,
                  child: controller.isKeyboard.value
                      ? const SizedBox()
                      : Container(
                          margin: EdgeInsets.symmetric(horizontal: 16.sp),
                          child: controller.rxTodoLoadedType.value ==
                                  LoadedType.start
                              ? const LoadingWidget()
                              : GestureDetector(
                                  onTap:
                                      //() {},
                                      () async => await (controller
                                                  .personalSchedule.value ==
                                              null
                                          ? _setOnClickSaveButton(context)
                                          : _setOnClickUpdateButton(context)),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: AppColors.blue900,
                                      boxShadow: [
                                        BoxShadow(
                                          color: AppColors.charade
                                              .withOpacity(0.3),
                                          blurRadius: 5,
                                          spreadRadius: 1,
                                          offset: const Offset(
                                            0,
                                            3,
                                          ),
                                        )
                                      ],
                                    ),
                                    width: double.infinity,
                                    alignment: Alignment.center,
                                    padding:
                                        EdgeInsets.symmetric(vertical: 12.sp),
                                    child: Text(
                                      'Lưu',
                                      style: ThemeText.bodySemibold.copyWith(
                                          color: AppColors.bianca,
                                          fontSize: 18.sp),
                                    ),
                                  ),
                                ),
                        ),
                )),
          ],
        ),
        //   ),
      ),
    );
  }

  _setOnClickSaveButton(BuildContext context) async {
    FocusScope.of(context).requestFocus(FocusNode());

    await controller.createTodo();
  }

  _setOnClickUpdateButton(BuildContext context) async {
    FocusScope.of(context).requestFocus(FocusNode());

    await controller.updateTodo();
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
  //                   style: ThemeText.bodySemibold.copyWith(
  //                       color: Colors.black54, fontWeight: FontWeight.normal),
  //                   children: [
  //                     TextSpan(
  //                         text: AppLocalizations.of(context)!.delete,
  //                         style: ThemeText.bodySemibold.copyWith(
  //                           color: AppColor.errorColor,
  //                         )),
  //                   ]),
  //             ),
  //             Text(
  //               '${this.widget.personalSchedule!.name}?',
  //               style: ThemeText.bodySemibold.copyWith(
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
  //                 color: AppColor.charade.withOpacity(0.3),
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
  //                   color: AppColor.bianca, fontWeight: FontWeight.bold),
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
  //                 color: AppColor.charade.withOpacity(0.3),
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
  //                       color: AppColor.bianca,
  //                       fontWeight: FontWeight.bold)),
  //             ),
  //           ),
  //         ),
  //       )).show();
  // }

  _bntOkDialogOnPress() async {
    Get.back();
    await controller.deleteTodo();
    // debugPrint(widget.personalSchedule!.id);
    // BlocProvider.of<TodoBloc>(context)
    //   ..add(DetelePersonalScheduleOnPressEvent(widget.personalSchedule!));
    debugPrint('delete to do');
  }
}
