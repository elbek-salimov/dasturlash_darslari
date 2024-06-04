import '../models/sidebar_model.dart';

class SideBarRepository {
  List<SideBarModel> mainMenu = [
    SideBarModel(
      title: 'Home',
      artBoard: 'HOME',
      stateMachineName: 'HOME_interactivity',
    ),
    SideBarModel(
      title: 'Search',
      artBoard: 'SEARCH',
      stateMachineName: 'SEARCH_Interactivity',
    ),
    SideBarModel(
      title: 'Rank',
      artBoard: 'LIKE/STAR',
      stateMachineName: 'STAR_Interactivity',
    ),
    SideBarModel(
      title: 'Profile',
      artBoard: 'USER',
      stateMachineName: 'USER_Interactivity',
    ),
  ];
  List<SideBarModel> moreMenu = [
    SideBarModel(
      title: 'Help',
      artBoard: 'CHAT',
      stateMachineName: 'CHAT_Interactivity',
    ),
    SideBarModel(
      title: 'Notification',
      artBoard: 'BELL',
      stateMachineName: 'BELL_Interactivity',
    ),
    SideBarModel(
      title: 'Settings',
      artBoard: 'SETTINGS',
      stateMachineName: 'SETTINGS_Interactivity',
    ),
  ];
}
