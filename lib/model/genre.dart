class Genre {
  final int id;
  final String name;

  Genre({
    this.id,
    this.name,
  });

  Genre.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'];
}

class GenreResponse {
  final List<Genre> genres;
  final String error;

  GenreResponse({
    this.genres,
    this.error,
  });

  GenreResponse.fromJson(Map<String, dynamic> json)
      : genres = (json['results'] as List)
            .map((i) => new Genre.fromJson(i))
            .toList(),
        error = '';

  GenreResponse.withError(String error)
      : genres = [],
        this.error = error;
}
