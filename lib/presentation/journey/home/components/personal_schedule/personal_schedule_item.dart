import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kit_schedule_v2/common/constants/theme_border.dart';
import 'package:kit_schedule_v2/common/utils/export.dart';
import 'package:kit_schedule_v2/domain/models/personal_schedule_model.dart';
import 'package:kit_schedule_v2/presentation/theme/export.dart';

class PersonalScheduleElementWidget extends StatelessWidget {
  final PersonalScheduleModel todo;

  const PersonalScheduleElementWidget({Key? key, required this.todo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.sp),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Expanded(
              flex: 2,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  '${todo.timer}',
                  style: ThemeText.bodyMedium.blue900,
                ),
              )),
          Expanded(
            flex: 8,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.sp),
              decoration: BoxDecoration(
                  border: Border(left: ThemeBorder.scheduleElementBorder)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    '${todo.name}',
                    maxLines: 1,
                    softWrap: false,
                    overflow: TextOverflow.ellipsis,
                    style: ThemeText.bodySemibold.blue900,
                  ),
                  if ((todo.note ?? '').isNotEmpty)
                    Text(
                      todo.note ?? '',
                      style: ThemeText.bodyRegular.blue900,
                      // maxLines: 1,
                      softWrap: false,
                      overflow: TextOverflow.ellipsis,
                    ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
