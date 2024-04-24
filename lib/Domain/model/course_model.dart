class CourseModel {
  String courseID;
  String photo;
  String title;
  String overview;
  List chapters;
  List description;
  String amount; 
  String document;
  List videos;

  CourseModel(
      {required this.courseID,
      required this.photo,
      required this.title,
      required this.overview,
      required this.chapters,
      required this.description,
      required this.amount,
      required this.document,
      required this.videos});
}
