class Movie {
  final int id;
  final String title;
  final String poster;
  final String backPoster;
  final String overview;
  final String releaseDate;
  final double popularity;
  final double rating;
  final int voteCount;

  Movie(
      {this.id,
      this.title,
      this.poster,
      this.backPoster,
      this.overview,
      this.popularity,
      this.releaseDate,
      this.rating,
      this.voteCount});

  Movie.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        poster = 'https://image.tmdb.org/t/p/w200' +
            (json['poster_path'] ?? '/fKtYXUhX5fxMxzQfyUcQW9Shik6.jpg'),
        backPoster = 'https://image.tmdb.org/t/p/w400' +
            (json['backdrop_path'] ??
                json['poster_path'] ??
                '/fKtYXUhX5fxMxzQfyUcQW9Shik6.jpg'),
        overview = json['overview'],
        popularity = json['popularity'],
        rating = json['vote_average'],
        releaseDate = json['release_date'],
        voteCount = json['vote_count'];
}

class MovieResponse {
  final List<Movie> movies;
  final String error;

  MovieResponse({this.movies, this.error});

  MovieResponse.fromJson(Map<String, dynamic> json)
      : movies = (json['results'] as List)
            .map((i) => new Movie.fromJson(i))
            .toList(),
        error = '';

  MovieResponse.withError(String error)
      : movies = [],
        this.error = error;
}
