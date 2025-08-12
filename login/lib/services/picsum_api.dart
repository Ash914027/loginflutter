// TODO Implement this library.
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/picsum_image.dart';

class PicsumApi {
  final _base = 'https://picsum.photos';
  Future<List<PicsumImage>> fetchList({int limit = 10}) async {
    final uri = Uri.parse('$_base/v2/list?limit=$limit');
    final res = await http.get(uri);
    if (res.statusCode != 200) throw Exception('Failed to load images');
    final List data = json.decode(res.body) as List;
    return data.map((e) => PicsumImage.fromJson(e)).toList();
  }
}
