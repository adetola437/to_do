import 'dart:ui';

class Note {
   String? id;
   String? title;
   String? category;
   String? quillContent; // JSON string of Quill document
   DateTime? createdAt;
   DateTime? updatedAt;
   Color? color;

  Note({
     this.id,
     this.title,
     this.category,
     this.quillContent,
     this.createdAt,
     this.updatedAt,
     this.color,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'category': category,
      'quillContent': quillContent,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'color': color?.value,
    };
  }

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      id: json['id'],
      title: json['title'],
      category: json['category'],
      quillContent: json['quillContent'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      color: Color(json['color']),
    );
  }

  Note copyWith({
    String? title,
    String? category,
    String? quillContent,
    DateTime? updatedAt,
    Color? color,
  }) {
    return Note(
      id: id,
      title: title ?? this.title,
      category: category ?? this.category,
      quillContent: quillContent ?? this.quillContent,
      createdAt: createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      color: color ?? this.color,
    );
  }
}
