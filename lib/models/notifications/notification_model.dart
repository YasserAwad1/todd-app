class NotificationModel {
  final int? id;
  final String? title;
  final String? body;

  NotificationModel({
    this.id,
    this.title,
    this.body,
  });

  NotificationModel fromJson(Map<String, dynamic> json) => NotificationModel(
        id: json['id'] as int?,
        title: json['title'] as String?,
        body: json['body'] as String?,
      );
}
