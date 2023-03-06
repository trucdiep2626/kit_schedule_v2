

enum AnalyticsEventType {
  appLaunched,
  notification,
  viewSchedule,
  score,
  todo
}

extension AnalyticsEventTypeExtension on AnalyticsEventType {
  String get name {
    var string = '';
    switch (this) {
      case AnalyticsEventType.appLaunched:
        string = 'app_launched';
        break;
      case AnalyticsEventType.notification:
        string = 'notification';
        break;
      case AnalyticsEventType.viewSchedule:
        string = 'view_schedule';
        break;
      case AnalyticsEventType.score:
        string = 'score';
        break;
      case AnalyticsEventType.todo:
        string = 'todo';
        break;
    }
    return string;
  }
}


