import 'dart:ui';

class NoteCategory {
  final String name;
  final Color color;

  NoteCategory({required this.name, required this.color});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'color': color.value,
    };
  }

  factory NoteCategory.fromJson(Map<String, dynamic> json) {
    return NoteCategory(
      name: json['name'],
      color: Color(json['color']),
    );
  }
}