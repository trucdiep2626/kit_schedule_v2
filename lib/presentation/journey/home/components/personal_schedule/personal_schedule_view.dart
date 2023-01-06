import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kit_schedule_v2/common/common_export.dart';
import 'package:kit_schedule_v2/common/utils/date_time_format.dart';
import 'package:kit_schedule_v2/domain/models/personal_schedule_model.dart';
import 'package:kit_schedule_v2/presentation/journey/home/components/personal_schedule/personal_schedule_item.dart';
import 'package:kit_schedule_v2/presentation/journey/home/home_controller.dart';
import 'package:kit_schedule_v2/presentation/journey/todo/todo_controller.dart';
import 'package:kit_schedule_v2/presentation/theme/export.dart';

class PersonalScheduleWidget extends GetView<HomeController> {
  const PersonalScheduleWidget({Key? key, required this.selectedDate})
      : super(key: key);

  final DateTime selectedDate;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      List<PersonalScheduleModel>? personalSchedulesOfDay =
          (controller.personalSchedule.value)
              .where((element) =>
                  element.date == DateTimeFormatter.formatDate(selectedDate))
              .toList();
      return Card(
        semanticContainer: true,
        color: AppColors.blue100,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        elevation: 5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(height: 8.sp),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('Ghi chú',
                    style: ThemeText.bodySemibold.s16.blue800),
                Container(
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: AppColors.blue800),
                    margin: const EdgeInsets.only(left: 4),
                    padding: const EdgeInsets.all(5),
                    child: Text(
                      '${personalSchedulesOfDay.length}',
                      style: ThemeText.bodyRegular,
                    ))
              ],
            ),
            Expanded(
                child: personalSchedulesOfDay.isNotEmpty
                    ? ListView.builder(
                        shrinkWrap: true,
                        itemCount: personalSchedulesOfDay.length,
                        itemBuilder: (context, index) {
                          PersonalScheduleModel todo =
                              personalSchedulesOfDay[index];
                          return InkWell(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (dialogContext) =>
                                        toDoDetailsDialog(context, todo));
                              },
                              child: PersonalScheduleElementWidget(
                                todo: todo,
                              ));
                        })
                    : Align(
                        alignment: Alignment.center,
                        child: Text('Không có dữ liệu',
                            style: ThemeText.bodyRegular.blue800,),
                      ))
          ],
        ),
      );
    });
  }

  Widget toDoDetailsDialog(
      BuildContext context, PersonalScheduleModel toDoItem) {
    return SimpleDialog(
        titlePadding: const EdgeInsets.all(0),
        title: Container(
          padding: EdgeInsets.all(8.sp),
          width: MediaQuery.of(context).size.width,
          color: AppColors.blue900,
          child: Text(
            'Chi tiết',
            style: ThemeText.bodySemibold
                .copyWith(color: AppColors.bianca, fontSize: 18.sp),
          ),
        ),
        children: [
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: 16.sp,
              //vertical: WidgetsConstants.paddingVertical
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDetailInfo(context, title: toDoItem.name ?? '', info: ''),
                _buildDetailInfo(context,
                    title: 'Thời gian: ', info: toDoItem.timer ?? ''),
                _buildDetailInfo(context,
                    title: 'Ghi chú: ', info: toDoItem.note ?? ''),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              padding: EdgeInsets.symmetric(horizontal: 16.sp),
              onPressed: () {
                //  debugPrint(toDoItem.id);
                Get.back();
                debugPrint('=========1');
                Get.find<TodoController>().getPersonalSchedule(toDoItem);
                debugPrint('=========2');
                Get.toNamed(AppRoutes.todo);
                debugPrint('=========3');
                //     ?.then((value) async {
                //   if (value != null) {
                //     await controller.getPersonalScheduleLocal();
                //   }
                // });
              },
              icon: const Icon(Icons.edit),
              color: AppColors.blue900,
            ),
          )
        ]);
  }

  Widget _buildDetailInfo(BuildContext context,
      {required String title, required String info}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.sp),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: RichText(
          text: TextSpan(
            text: title,
            style: ThemeText.bodySemibold
                .copyWith(color: AppColors.blue900, fontSize: 16.sp),
            children: <TextSpan>[
              TextSpan(
                  text: info,
                  style: ThemeText.bodySemibold.copyWith(
                      color: AppColors.blue900,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.normal)),
            ],
          ),
        ),
      ),
    );
  }

  // String getTime(PersonalScheduleEntities item) {
  //   String str = '';
  //   if (item.timer != null) str = str + (item.timer as String) + ' ';
  //   if (item.date != null)
  //     str += DateFormat('dd/MM/yyyy').format(
  //         DateTime.fromMillisecondsSinceEpoch(int.parse(item.date as String)));
  //   return str;
  // }
}
