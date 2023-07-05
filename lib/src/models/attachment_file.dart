import 'dart:typed_data';
import 'package:http_parser/http_parser.dart';

import 'package:equatable/equatable.dart';

class AttachmentFile extends Equatable {
  final String filename;
  final String extension;
  final Uint8List data;
  final String? path;
  final MediaType? contentType;

  const AttachmentFile({
    required this.filename,
    required this.extension,
    required this.data,
    this.path,
    this.contentType,
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
        contentType: contentType,
      );
}
