class Pokemon {
  final String name;
  final String url;

  const Pokemon({required this.name, required this.url});

  /// Entity → JSON
  Map<String, dynamic> toJson() {
    return {'name': name, 'url': url};
  }
}
