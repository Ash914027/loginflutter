// TODO Implement this library.
class PicsumImage {
  final String id;
  final String author;
  final int width;
  final int height;
  final String downloadUrl;

  PicsumImage({
    required this.id,
    required this.author,
    required this.width,
    required this.height,
    required this.downloadUrl,
  });

  factory PicsumImage.fromJson(Map<String, dynamic> j) {
    return PicsumImage(
      id: j['id'].toString(),
      author: j['author'] ?? '',
      width: j['width'] ?? 1,
      height: j['height'] ?? 1,
      downloadUrl: j['download_url'] ?? '',
    );
  }
}
