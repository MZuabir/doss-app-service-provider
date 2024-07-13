import 'dart:io';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';


class CacheService {
  //Get cache path
  static Future<String> getCachePath(String url) async {
    final cacheManager = DefaultCacheManager();
    final fileInfo = await cacheManager.getFileFromCache(url);

    if (fileInfo != null && fileInfo.file.existsSync()) {
      return fileInfo.file.path; // Return cached File path
    }
    // File is not cached, download and cache it
    final file = await cacheManager.downloadFile(url);

    if (file != null && file.file.existsSync()) {
      return file.file.path; // Return cached File path
    } else {
      // Unable to cache File, return original URL
      return '';
    }
  }

  
}
