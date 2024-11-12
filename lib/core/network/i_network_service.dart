import 'dart:async';
import 'dart:io';

abstract class INetworkService {
  Future<Map<String, dynamic>> get(String endpoint, {Map<String, String>? headers});
  Future<Map<String, dynamic>> post(String endpoint, {Map<String, String>? headers, dynamic body});
  Future<Map<String, dynamic>> put(String endpoint, {Map<String, String>? headers, dynamic body});
  Future<Map<String, dynamic>> delete(String endpoint, {Map<String, String>? headers});

  // Method for file upload with additional form data
  Future<Map<String, dynamic>> uploadFileWithData(String endpoint, File file, Map<String, String> formData, {Map<String, String>? headers});

  // Method for file download
  Future<File> downloadFile(String endpoint, String filePath, {Map<String, String>? headers});
}
