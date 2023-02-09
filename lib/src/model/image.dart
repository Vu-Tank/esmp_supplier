import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Image {
  final int imageID;
  final String fileName;
  final String path;
  final String crete_date;
  final bool isActive;
  Image({
    required this.imageID,
    required this.fileName,
    required this.path,
    required this.crete_date,
    required this.isActive,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'imageID': imageID,
      'fileName': fileName,
      'path': path,
      'crete_date': crete_date,
      'isActive': isActive,
    };
  }

  factory Image.fromMap(Map<String, dynamic> map) {
    return Image(
      imageID: map['imageID'] as int,
      fileName: map['fileName'] as String,
      path: map['path'] as String,
      crete_date: map['crete_date'] as String,
      isActive: map['isActive'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Image.fromJson(String source) =>
      Image.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Image(imageID: $imageID, fileName: $fileName, path: $path, crete_date: $crete_date, isActive: $isActive)';
  }
}
