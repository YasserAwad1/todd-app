class Endpoints {
  static const baseUrl = 'http://192.168.43.181:8080';
  static const login = '$baseUrl/api/login';
  static const classes = '$baseUrl/api/classroom';
  static const statuses = '$baseUrl/api/status';
  static const events = '$baseUrl/api/events';
  static const photos = '$baseUrl/api/post';
  static const qa = '$baseUrl/api/question-answer';
  static const sendStatus = '$baseUrl/api/child-status';
  static const eventById = '$baseUrl//api/events';
  static const currentUser = '$baseUrl/api/current-user';
  static const dates = '$baseUrl/api/status-dates';
  static const getChildReports = '$baseUrl/api/get_child_reports';
  static const report = '$baseUrl/api/reports';
  static const childStatusByDate = '$baseUrl/api/get-child-status-date';
  static const getChildrenByParentOrTeacherId = '$baseUrl/api/get-teacher-parent-child';
  static const getChildStatusByDate = '$baseUrl/api/get-child-status-date';
  static const getStatusesToSend = '$baseUrl/api/get-status-by-child';
  static const sendKidImage = '$baseUrl/api/child-image';
  static const getChildImagesToCheck = '$baseUrl/api/child-images';
  static const checkImage = '$baseUrl/api/image-check';
  static const deleteImageCopy = '$baseUrl/api/child-image';

}