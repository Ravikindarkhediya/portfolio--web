import 'package:get/get.dart';
import 'project_model.dart';
import 'package:carousel_slider/carousel_controller.dart' as slider;

class ProjectsController extends GetxController {
  final RxList<ProjectModel> _allProjects =
      <ProjectModel>[
        ProjectModel(
          id: '1',
          title: 'WeTalk -- ChatApp',
          description:
              'A ChatApp is a real-time messaging application that allows users to send and receive text instantly over the internet.',
          imageUrls: [
            'assets/project_images/weTalk_5.jpg',
            'assets/project_images/weTalk_4.jpg',
            'assets/project_images/weTalk_3.jpg',
            'assets/project_images/weTalk_2.jpg',
            'assets/project_images/weTalk_1.jpg',
          ],
          techStack: ['Flutter', 'Firebase'],
          githubUrl: 'https://github.com/Ravikindarkhediya/WeTalk---ChatApp',
          tags: ['mobile', 'firebase', 'app'],
        ),
        ProjectModel(
          id: '2',
          title: 'GameHub',
          description:
              'Android GameHub App with multiple games where users can play and earn real money. '
              'I worked on designing and implementing some key UI parts for better usability.',
          imageUrls: [
            'assets/project_images/gamehub_2.jpg',
            'assets/project_images/gamehub.jpg',
          ],
          techStack: ['J2EE', 'MySQL', 'MVC', 'Responsive'],
          githubUrl: 'https://github.com/Ravikindarkhediya/',
          tags: ['web'],
        ),
        ProjectModel(
          id: '3',
          title: 'Portfolio Website (This App!)',
          description:
              'This very portfolio application, showcasing skills and projects. Built to be responsive and modern with light and dark theme supported.',
          imageUrls: [
            'assets/project_images/portfolio_1.png',
            'assets/project_images/portfolio_2.png',
            'assets/project_images/portfolio_3.png',
            'assets/project_images/portfolio_6.png',
            'assets/project_images/portfolio_4.png',
            'assets/project_images/portfolio_5.png',
          ],
          techStack: ['Flutter', 'GetX', 'Responsive'],
          githubUrl: 'https://github.com/Ravikindarkhediya/portfolio--web',
          tags: ['mobile', 'web', 'portfolio'],
        ),

        ProjectModel(
          id: '4',
          title: 'Bhashantar',
          description:
              'Bhashantar is a multilingual translation app that lets users convert text between various Indian and global languages. '
              'It offers a clean, responsive UI with real-time translation powered by Google Translate API.',
          imageUrls: [
            'assets/project_images/bhashantar_1.jpg',
            'assets/project_images/bhashantar_2.jpg',
          ],
          techStack: ['Flutter', 'Clean UI', 'Multiple Languages'],
          githubUrl: 'https://github.com/Ravikindarkhediya/Bhashantar-App',
          tags: ['mobile', 'web', 'app'],
        ),
        ProjectModel(
          id: '5',
          title: 'Currency-Converter',
          description:
              'Convert currencies instantly with live exchange rates. Simple, fast, and accurate for global travelers and traders.',
          imageUrls: [
            'assets/project_images/Currency-Converter_1.png',
            'assets/project_images/Currency-Converter_2.png',
          ],
          techStack: ['Flutter', 'Clean UI', 'Multiple Currency'],
          githubUrl: 'https://github.com/Ravikindarkhediya/Currency-Convertor-with-API/tree/master',
          tags: ['mobile', 'web', 'app'],
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
        _allProjects.where((project) => project.tags.contains(tag)).toList(),
      );
    }
  }

  //   TODO: ------------------- project Card controller -----------------

  final RxInt hoveredIndex = (-1).obs;
  final RxInt githubHoveredIndex = (-1).obs;

  void setHoveredIndex(int index) => hoveredIndex.value = index;

  void clearHoveredIndex() => hoveredIndex.value = -1;

  void setGithubHoveredIndex(int index) => githubHoveredIndex.value = index;

  void clearGithubHoveredIndex() => githubHoveredIndex.value = -1;
  var currentCarouselIndex = 0.obs;
  final slider.CarouselSliderController carouselController =
      slider.CarouselSliderController();

  void onCarouselChanged(int index) {
    currentCarouselIndex.value = index;
  }

  //   TODO: --------------------- FullScreenIMageDialog ---------------------
  final RxInt fullScreenCarouselIndex = 0.obs;

  void setFullScreenCarouselIndex(int index) {
    fullScreenCarouselIndex.value = index;
  }
}
