// menu_modal.dart
class MenuModel {
  String icon;
  String title;
  bool isSelected;

  MenuModel({
    required this.icon,
    required this.title,
    this.isSelected = false,
  });
}
