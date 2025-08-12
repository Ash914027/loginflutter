// TODO Implement this library.
import '../models/picsum_image.dart';
import '../services/picsum_api.dart';

class PicsumRepository {
  final PicsumApi _api = PicsumApi();

  Future<List<PicsumImage>> getImages({int limit = 10}) {
    return _api.fetchList(limit: limit);
  }
}
