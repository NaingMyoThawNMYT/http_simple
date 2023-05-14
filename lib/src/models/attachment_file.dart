import 'dart:typed_data';

import 'package:equatable/equatable.dart';

class AttachmentFile extends Equatable {
  final String filename;
  final String extension;
  final Uint8List data;
  final String? path;

  const AttachmentFile({
    required this.filename,
    required this.extension,
    required this.data,
    this.path,
  });

  String get fileNameWithExtension => '$filename.$extension';

  @override
  List<Object?> get props => [
        filename,
        path,
      ];

  AttachmentFile clone() => AttachmentFile(
        filename: filename,
        extension: extension,
        data: data,
        path: path,
      );
}
