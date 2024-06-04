// import 'package:cloud_firestore/cloud_firestore.dart';
//
// import '../../../utils/constants/app_constants.dart';
// import '../../models/course/course_model.dart';
// import '../../models/network_response.dart';
//
// class CourseRepository {
//   Future<NetworkResponse> getCourse() async {
//
//     List<CourseModel> courses = [];
//     try {
//       await FirebaseFirestore.instance
//           .collection(AppConstants.courses)
//           .get()
//           .then((snapshot) {
//         courses =
//             snapshot.docs.map((e) => CourseModel.fromJson(e.data())).toList();
//       });
//       if (courses.isNotEmpty) {
//         return NetworkResponse(
//           data: courses,
//         );
//       } else {
//         return NetworkResponse(errorText: "No Data");
//       }
//     } on FirebaseException catch (e) {
//       return NetworkResponse(errorText: "Firestore error: ${e.message}");
//     } catch (e) {
//       return NetworkResponse(errorText: e.toString());
//     }
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../utils/constants/app_constants.dart';
import '../../models/course/course_model.dart';
import '../../models/course/lesson_model.dart';
import '../../models/course/module_model.dart';
import '../../models/network_response.dart';

class CourseRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<NetworkResponse> getCourses() async {
    List<CourseModel> courses = [];

    try {
      QuerySnapshot courseSnapshot =
      await _firestore.collection(AppConstants.courses).get();

      for (var courseDoc in courseSnapshot.docs) {
        List<ModuleModel> modules = [];

        QuerySnapshot moduleSnapshot = await courseDoc.reference
            .collection(AppConstants.modules)
            .get();

        for (var moduleDoc in moduleSnapshot.docs) {
          List<LessonModel> lessons = [];

          QuerySnapshot lessonSnapshot = await moduleDoc.reference
              .collection(AppConstants.lessons)
              .get();

          for (var lessonDoc in lessonSnapshot.docs) {
            lessons.add(LessonModel.fromJson(lessonDoc.data() as Map<String, dynamic>));
          }

          modules.add(ModuleModel(
            moduleUid: moduleDoc.id,
            moduleId: moduleDoc['module_id'],
            moduleTitle: moduleDoc['module_title'],
            lessons: lessons,
          ));
        }

        courses.add(CourseModel(
          courseTitle: courseDoc['course_title'],
          courseImageUrl: courseDoc['course_imageUrl'],
          courseLessonCount: courseDoc['course_lessonCount'],
          courseCreatedAt: courseDoc['course_createdAt'],
          courseId: courseDoc.id,
          isPopular: courseDoc['isPopular'],
          isPaid: courseDoc['isPaid'],
          coursePrice: (courseDoc['course_price'] as num).toDouble(),
          courseDuration: courseDoc['course_duration'],
          mentorName: courseDoc['mentor_name'],
          mentorImageUrl: courseDoc['mentor_imageUrl'],
          modules: modules,
        ));
      }

      if (courses.isNotEmpty) {
        return NetworkResponse(
          data: courses,
        );
      } else {
        return NetworkResponse(errorText: "No Data");
      }
    } on FirebaseException catch (e) {
      return NetworkResponse(errorText: "Firestore error: ${e.message}");
    } catch (e) {
      return NetworkResponse(errorText: e.toString());
    }
  }
}
