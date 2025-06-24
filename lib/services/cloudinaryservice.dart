import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart'; 
import 'package:mime/mime.dart';

class CloudinaryService {

  static const String cloudName = 'dwwlg2zaj';
  static const String uploadPreset = 'BrewMate_Coffee_App';

  static Future<String?> uploadImageToCloudinary(File imageFile) async {
    final url = Uri.parse('https://api.cloudinary.com/v1_1/$cloudName/image/upload');

    final mimeType = lookupMimeType(imageFile.path);
    final mimeSplit = mimeType?.split('/') ?? ['image', 'jpeg'];

    final request = http.MultipartRequest('POST', url)
      ..fields['upload_preset'] = uploadPreset
      ..files.add(await http.MultipartFile.fromPath(
        'file',
        imageFile.path,
        contentType: MediaType(mimeSplit[0], mimeSplit[1]),
      ));

    final response = await request.send();

    if (response.statusCode == 200) {
      final responseData = await response.stream.bytesToString();
      final jsonData = json.decode(responseData);
      return jsonData['secure_url'];
    } else {
      print('❌ Failed to upload image: ${response.statusCode}');
      return null;
    }
  }
}
