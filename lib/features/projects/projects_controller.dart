import 'package:get/get.dart';
import '../../core/constants/app_constants.dart';
import 'project_model.dart';

class ProjectsController extends GetxController {
  final RxList<ProjectModel> _allProjects = <ProjectModel>[
    ProjectModel(
      id: '1',
      title: 'WeTalk -- ChatApp',
      description: 'A ChatApp is a real-time messaging application that allows users to send and receive text instantly over the internet.',
      imageUrl: 'assets/images/project_placeholder.png',
      techStack: ['Flutter', 'Firebase'],
      githubUrl: 'https://github.com/Ravikindarkhediya/WeTalk---ChatApp',
      tags: ['mobile', 'firebase', 'app'],
    ),
    ProjectModel(
      id: '2',
      title: 'PeopleMart',
      description: 'A user-friendly and responsive e-commerce platform where users can list products for sale and purchase items from others.',
      imageUrl: 'assets/images/project_placeholder.png',
      techStack: ['J2EE', 'MySQL', 'MVC', 'Responsive'],
      githubUrl: 'https://github.com/Ravikindarkhediya/PeopleMart',
      tags: ['web'],
    ),
    ProjectModel(
      id: '3',
      title: 'Portfolio Website (This App!)',
      description: 'This very portfolio application, showcasing skills and projects. Built to be responsive and modern.',
      imageUrl: 'assets/images/project_placeholder.png',
      techStack: ['Flutter', 'GetX', 'Responsive'],
      githubUrl: AppConstants.githubUrl,
      tags: ['mobile', 'web', 'portfolio'],
    ),
  ].obs;

  final RxList<ProjectModel> filteredProjects = <ProjectModel>[].obs;
  final RxList<String> allTags = <String>[].obs;
  final RxString selectedTag = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _loadProjects();
    _extractTags();
  }

  void _loadProjects() {
    filteredProjects.assignAll(_allProjects);
  }

  void _extractTags() {
    final Set<String> tagsSet = {};
    for (var project in _allProjects) {
      tagsSet.addAll(project.tags);
    }
    allTags.assignAll(tagsSet.toList()..sort());
  }

  void filterByTag(String? tag) {
    if (tag == null || tag.isEmpty) {
      selectedTag.value = '';
      filteredProjects.assignAll(_allProjects);
    } else {
      selectedTag.value = tag;
      filteredProjects.assignAll(
          _allProjects.where((project) => project.tags.contains(tag)).toList());
    }
  }
}