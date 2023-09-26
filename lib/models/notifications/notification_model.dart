class NotificationModel {
  final int? id;
  final String? title;
  final String? body;
  final String? time;

  NotificationModel({
    this.id,
    this.title,
    this.body,
    this.time
  });

  NotificationModel fromJson(Map<String, dynamic> json) => NotificationModel(
        id: json['id'] as int?,
        title: json['title'] as String?,
        body: json['body'] as String?,
        time: json['created_at'] as String?
      );
}
