import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:message/Static/ListBuildItem/ListBottomNavigateItem.dart';
import 'package:message/Static/LocalNotificationService.dart';
import 'package:message/Template/BottomNavBarTemplate.dart';

class LocalNotificationOptionPage extends StatefulWidget {
  LocalNotificationOptionPage({Key? key}) : super(key: key);

  @override
  LocalNotificationOptionPageState createState() =>
      new LocalNotificationOptionPageState();
}

class LocalNotificationOptionPageState
    extends State<LocalNotificationOptionPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavBarTemplate(
      bodyWidget: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 8),
                  child: Text('Tap on a notification when it appears to trigger'
                      ' navigation'),
                ),
                PaddedElevatedButton(
                  buttonText: 'Show plain notification with payload',
                  onPressed: () async {
                    await LocalNotificationService.notificationService
                        .showNotification();
                  },
                ),
                PaddedElevatedButton(
                  buttonText: 'Show plain notification that has no title with '
                      'payload',
                  onPressed: () async {
                    await LocalNotificationService.notificationService
                        .showNotificationWithNoTitle();
                  },
                ),
                PaddedElevatedButton(
                  buttonText: 'Show plain notification that has no body with '
                      'payload',
                  onPressed: () async {
                    await LocalNotificationService.notificationService
                        .showNotificationWithNoBody();
                  },
                ),
                PaddedElevatedButton(
                  buttonText: 'Show notification with custom sound',
                  onPressed: () async {
                    await LocalNotificationService.notificationService
                        .showNotificationCustomSound();
                  },
                ),
                if (!kIsWeb && !Platform.isLinux) ...<Widget>[
                  PaddedElevatedButton(
                    buttonText: 'Schedule notification to appear in 5 seconds '
                        'based on local time zone',
                    onPressed: () async {
                      await LocalNotificationService.notificationService
                          .zonedScheduleNotification();
                    },
                  ),
                  PaddedElevatedButton(
                    buttonText: 'Repeat notification every minute',
                    onPressed: () async {
                      await LocalNotificationService.notificationService
                          .repeatNotification();
                    },
                  ),
                  PaddedElevatedButton(
                    buttonText:
                        'Schedule daily 10:00:00 am notification in your '
                        'local time zone',
                    onPressed: () async {
                      await LocalNotificationService.notificationService
                          .scheduleDailyTenAMNotification();
                    },
                  ),
                  PaddedElevatedButton(
                    buttonText:
                        'Schedule daily 10:00:00 am notification in your '
                        "local time zone using last year's date",
                    onPressed: () async {
                      await LocalNotificationService.notificationService
                          .scheduleDailyTenAMLastYearNotification();
                    },
                  ),
                  PaddedElevatedButton(
                    buttonText:
                        'Schedule weekly 10:00:00 am notification in your '
                        'local time zone',
                    onPressed: () async {
                      await LocalNotificationService.notificationService
                          .scheduleWeeklyTenAMNotification();
                    },
                  ),
                  PaddedElevatedButton(
                    buttonText:
                        'Schedule weekly Monday 10:00:00 am notification '
                        'in your local time zone',
                    onPressed: () async {
                      await LocalNotificationService.notificationService
                          .scheduleWeeklyMondayTenAMNotification();
                    },
                  ),
                  PaddedElevatedButton(
                    buttonText: 'Check pending notifications',
                    onPressed: () async {
                      await LocalNotificationService.notificationService
                          .checkPendingNotificationRequests(this.context);
                    },
                  ),
                ],
                PaddedElevatedButton(
                  buttonText: 'Show notification with no sound',
                  onPressed: () async {
                    await LocalNotificationService.notificationService
                        .showNotificationWithNoSound();
                  },
                ),
                PaddedElevatedButton(
                  buttonText: 'Cancel notification',
                  onPressed: () async {
                    await LocalNotificationService.notificationService
                        .cancelNotification();
                  },
                ),
                PaddedElevatedButton(
                  buttonText: 'Cancel all notifications',
                  onPressed: () async {
                    await LocalNotificationService.notificationService
                        .cancelAllNotifications();
                  },
                ),
                if (!kIsWeb && Platform.isAndroid) ...<Widget>[
                  const Text(
                    'Android-specific examples',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  PaddedElevatedButton(
                    buttonText:
                        'Show plain notification with payload and update '
                        'channel description',
                    onPressed: () async {
                      await LocalNotificationService.notificationService
                          .showNotificationUpdateChannelDescription();
                    },
                  ),
                  PaddedElevatedButton(
                    buttonText: 'Show plain notification as public on every '
                        'lockscreen',
                    onPressed: () async {
                      await LocalNotificationService.notificationService
                          .showPublicNotification();
                    },
                  ),
                  PaddedElevatedButton(
                    buttonText:
                        'Show notification with custom vibration pattern, '
                        'red LED and red icon',
                    onPressed: () async {
                      await LocalNotificationService.notificationService
                          .showNotificationCustomVibrationIconLed();
                    },
                  ),
                  PaddedElevatedButton(
                    buttonText:
                        'Show notification that times out after 3 seconds',
                    onPressed: () async {
                      await LocalNotificationService.notificationService
                          .showTimeoutNotification();
                    },
                  ),
                  PaddedElevatedButton(
                    buttonText: 'Show insistent notification',
                    onPressed: () async {
                      await LocalNotificationService.notificationService
                          .showInsistentNotification();
                    },
                  ),
                  PaddedElevatedButton(
                    buttonText:
                        'Show big picture notification using local images',
                    onPressed: () async {
                      await LocalNotificationService.notificationService
                          .showBigPictureNotification();
                    },
                  ),
                  PaddedElevatedButton(
                    buttonText:
                        'Show big picture notification using base64 String '
                        'for images',
                    onPressed: () async {
                      await LocalNotificationService.notificationService
                          .showBigPictureNotificationBase64();
                    },
                  ),
                  PaddedElevatedButton(
                    buttonText: 'Show big picture notification using URLs for '
                        'Images',
                    onPressed: () async {
                      await LocalNotificationService.notificationService
                          .showBigPictureNotificationURL();
                    },
                  ),
                  PaddedElevatedButton(
                    buttonText:
                        'Show big picture notification, hide large icon '
                        'on expand',
                    onPressed: () async {
                      await LocalNotificationService.notificationService
                          .showBigPictureNotificationHiddenLargeIcon();
                    },
                  ),
                  PaddedElevatedButton(
                    buttonText: 'Show media notification',
                    onPressed: () async {
                      await LocalNotificationService.notificationService
                          .showNotificationMediaStyle();
                    },
                  ),
                  PaddedElevatedButton(
                    buttonText: 'Show big text notification',
                    onPressed: () async {
                      await LocalNotificationService.notificationService
                          .showBigTextNotification();
                    },
                  ),
                  PaddedElevatedButton(
                    buttonText: 'Show inbox notification',
                    onPressed: () async {
                      await LocalNotificationService.notificationService
                          .showInboxNotification();
                    },
                  ),
                  PaddedElevatedButton(
                    buttonText: 'Show grouped notifications',
                    onPressed: () async {
                      await LocalNotificationService.notificationService
                          .showGroupedNotifications();
                    },
                  ),
                  PaddedElevatedButton(
                    buttonText: 'Show notification with tag',
                    onPressed: () async {
                      await LocalNotificationService.notificationService
                          .showNotificationWithTag();
                    },
                  ),
                  PaddedElevatedButton(
                    buttonText: 'Show ongoing notification',
                    onPressed: () async {
                      await LocalNotificationService.notificationService
                          .showOngoingNotification();
                    },
                  ),
                  PaddedElevatedButton(
                    buttonText:
                        'Show notification with no badge, alert only once',
                    onPressed: () async {
                      await LocalNotificationService.notificationService
                          .showNotificationWithNoBadge();
                    },
                  ),
                  PaddedElevatedButton(
                    buttonText:
                        'Show progress notification - updates every second',
                    onPressed: () async {
                      await LocalNotificationService.notificationService
                          .showProgressNotification();
                    },
                  ),
                  PaddedElevatedButton(
                    buttonText: 'Show indeterminate progress notification',
                    onPressed: () async {
                      await LocalNotificationService.notificationService
                          .showIndeterminateProgressNotification();
                    },
                  ),
                  PaddedElevatedButton(
                    buttonText: 'Show notification without timestamp',
                    onPressed: () async {
                      await LocalNotificationService.notificationService
                          .showNotificationWithoutTimestamp();
                    },
                  ),
                  PaddedElevatedButton(
                    buttonText: 'Show notification with custom timestamp',
                    onPressed: () async {
                      await LocalNotificationService.notificationService
                          .showNotificationWithCustomTimestamp();
                    },
                  ),
                  PaddedElevatedButton(
                    buttonText: 'Show notification with custom sub-text',
                    onPressed: () async {
                      await LocalNotificationService.notificationService
                          .showNotificationWithCustomSubText();
                    },
                  ),
                  PaddedElevatedButton(
                    buttonText: 'Show notification with chronometer',
                    onPressed: () async {
                      await LocalNotificationService.notificationService
                          .showNotificationWithChronometer();
                    },
                  ),
                  PaddedElevatedButton(
                    buttonText: 'Show full-screen notification',
                    onPressed: () async {
                      await LocalNotificationService.notificationService
                          .showFullScreenNotification(this.context);
                    },
                  ),
                ],
                if (!kIsWeb &&
                    (Platform.isIOS || Platform.isMacOS)) ...<Widget>[
                  const Text(
                    'iOS and macOS-specific examples',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  PaddedElevatedButton(
                    buttonText: 'Show notification with subtitle',
                    onPressed: () async {
                      await LocalNotificationService.notificationService
                          .showNotificationWithSubtitle();
                    },
                  ),
                  PaddedElevatedButton(
                    buttonText: 'Show notification with icon badge',
                    onPressed: () async {
                      await LocalNotificationService.notificationService
                          .showNotificationWithIconBadge();
                    },
                  ),
                  PaddedElevatedButton(
                    buttonText: 'Show notification with attachment',
                    onPressed: () async {
                      await LocalNotificationService.notificationService
                          .showNotificationWithAttachment();
                    },
                  ),
                  PaddedElevatedButton(
                    buttonText: 'Show notifications with thread identifier',
                    onPressed: () async {
                      await LocalNotificationService.notificationService
                          .showNotificationsWithThreadIdentifier();
                    },
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
      listBottomNavigateBar: ListBottomNavigateItem.list,
      bottomNavigateBarIndex: 3,
    );
  }
}

class PaddedElevatedButton extends StatelessWidget {
  const PaddedElevatedButton({
    required this.buttonText,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  final String buttonText;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(buttonText),
      ),
    );
  }
}
