import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:kit_schedule_v2/common/utils/date_time_format.dart';
import 'package:kit_schedule_v2/common/utils/export.dart';
import 'package:kit_schedule_v2/domain/models/personal_schedule_model.dart';
import 'package:kit_schedule_v2/presentation/journey/home/components/personal_schedule/personal_schedule_item.dart';
import 'package:kit_schedule_v2/presentation/journey/home/home_controller.dart';
import 'package:kit_schedule_v2/presentation/theme/export.dart';

class PersonalScheduleWidget extends  GetView<HomeController> {
  const PersonalScheduleWidget({Key? key,required this.selectedDate}) : super(key: key);

  final DateTime selectedDate;

  @override
  Widget build(BuildContext context) {
    List<PersonalScheduleModel>? personalSchedulesOfDay = (controller.personalSchedule.value)
        .where((element) =>
    element.date == DateTimeFormatter.formatDate(selectedDate))
        .toList();
    return Card(
      semanticContainer: true,
//      color: Color(0xffFCFAF3),
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
                  style: ThemeText.titleStyle.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.blue800,
                  )),
              Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.blue800),
                  margin: const EdgeInsets.only(left: 4),
                  padding: const EdgeInsets.all(5),
                  child: Text(
                    personalSchedulesOfDay != null
                        ? '${personalSchedulesOfDay.length}'
                        : '0',
                    style: ThemeText.numberStyle,
                  ))
            ],
          ),
          Expanded(
              child: personalSchedulesOfDay != null
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
                          style: ThemeText.textStyle.copyWith(
                              color: AppColors.blue800)),
                    ))
        ],
      ),
    );
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
            style: ThemeText.titleStyle.copyWith(color: AppColors.bianca),
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
                Padding(
                  padding: EdgeInsets.only(bottom: 8.sp),
                  child: Text(
                      toDoItem.name != null ? toDoItem.name as String : '',
                      style: ThemeText.titleStyle2
                          .copyWith(color: AppColors.blue900)),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 8.sp),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: RichText(
                      text: TextSpan(
                        text: 'Thời gian: ',
                        style: ThemeText.titleStyle2
                            .copyWith(color: AppColors.blue900),
                        children: <TextSpan>[
                          TextSpan(
                              text: '',
                              //getTime(toDoItem),
                              style: ThemeText.titleStyle2.copyWith(
                                  color: AppColors.blue900,
                                  fontWeight: FontWeight.normal)),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 8.sp),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: RichText(
                      text: TextSpan(
                        text: 'Ghi ch: ',
                        style: ThemeText.titleStyle2
                            .copyWith(color: AppColors.blue900),
                        children: <TextSpan>[
                          TextSpan(
                              text: toDoItem.note ?? '',
                              style: ThemeText.titleStyle2.copyWith(
                                  color: AppColors.blue900,
                                  fontWeight: FontWeight.normal)),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              padding: EdgeInsets.symmetric(horizontal: 16.sp),
              onPressed: () {
                debugPrint(toDoItem.id);
                Navigator.pop(context);
                Navigator.pushNamed(context, '/todo-detail',
                        arguments: toDoItem)
                    .then((value) {
                  if (value != null) {
                    // BlocProvider.of<CalendarBloc>(context)
                    //     .add(GetAllScheduleDataEvent());
                  }
                });
              },
              icon: const Icon(Icons.edit),
              color: AppColors.blue900,
            ),
          )
        ]);
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
