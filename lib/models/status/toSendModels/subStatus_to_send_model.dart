class SubStatusToSendModel {
  final int subStatusId;
  final String? description;

  SubStatusToSendModel({
    required this.subStatusId,
    this.description,
  });

  Map<String, dynamic> toJson() {
    return {
      'substatus_id': subStatusId,
      if (description != null) 'description': description!,
    };
  }
}
