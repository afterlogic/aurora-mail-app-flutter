
import 'dart:io';

import 'package:background_downloader/background_downloader.dart';
import 'package:flutter/services.dart';

/// Moves [sourceFile] (already fully written, e.g. in a private temp/cache
/// directory) into the device's public Downloads folder.
///
/// Plain dart:io writes into the public Downloads path are rejected by
/// Android 10+ scoped storage, so this goes through background_downloader's
/// MediaStore-aware mover instead. If MediaStore already has an entry under
/// that name (SQLITE_CONSTRAINT_UNIQUE - e.g. a stale row left by an earlier
/// attempt), retries under a numbered name ("name (1).ext", "name (2).ext",
/// ...) rather than trying to detect/clean up the stale entry.
Future<String> moveToDownloads(File sourceFile, {String? mimeType}) async {
  final originalName = sourceFile.uri.pathSegments.last;
  final dotIndex = originalName.lastIndexOf('.');
  final hasExt = dotIndex > 0;
  final base = hasExt ? originalName.substring(0, dotIndex) : originalName;
  final ext = hasExt ? originalName.substring(dotIndex) : '';

  var current = sourceFile;
  for (var attempt = 0; ; attempt++) {
    try {
      final path = await FileDownloader().moveFileToSharedStorage(
        current.path,
        SharedStorage.downloads,
        mimeType: mimeType,
      );
      if (path == null) {
        throw Exception('Failed to save file to Downloads');
      }
      return path;
    } on PlatformException catch (e) {
      final isUniqueConstraint =
          e.message?.contains('UNIQUE constraint') == true;
      if (!isUniqueConstraint || attempt >= 20) rethrow;
      final candidateName = '$base (${attempt + 1})$ext';
      current = await current.rename(
          '${current.parent.path}${Platform.pathSeparator}$candidateName');
    }
  }
}
