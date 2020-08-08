import 'dart:convert';

import 'package:themoviesapp/api/api.dart';
import 'package:themoviesapp/model/actor.dart';
import 'package:themoviesapp/model/genre.dart';
import 'package:themoviesapp/model/movie.dart';
import 'package:http/http.dart' as HTTP;

class Repository {
  static final String moviesAllUrl = '${API.mainPath}/discover/movie';
  static final String moviesNowPlayingUrl = '${API.mainPath}/movie/now_playing';
  static final String moviesTopRatedUrl = '${API.mainPath}/movie/top_rated';
  static final String moviesSearchUrl = '${API.mainPath}/search/movie';
  static final String genresUrl = '${API.mainPath}/genre/movie/list';
  static final String actorsUrl = '${API.mainPath}/trending/person/week';

  static var headers = {
    'api_key': API.apiKey,
    'language': 'en-US',
    'page': 1,
  };

  Future<MovieResponse> getMovies() async {
    try {
      print('$moviesAllUrl?api_key=${API.apiKey}');
      final response = await HTTP.get('$moviesAllUrl?api_key=${API.apiKey}');
      if (response.statusCode == 200) {
        return MovieResponse.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to get movie details');
      }
    } catch (error, stackTrace) {
      print('Error in getMovies(): $error, stackTrace: $stackTrace');
      throw Exception('Failed to get movie details');
    }
  }

  Future<MovieResponse> getMoviesNowPlaying() async {
    try {
      print('$moviesNowPlayingUrl?api_key=${API.apiKey}');
      final response =
          await HTTP.get('$moviesNowPlayingUrl?api_key=${API.apiKey}');
      if (response.statusCode == 200) {
        return MovieResponse.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to get movie details');
      }
    } catch (error, stackTrace) {
      print('Error in getMoviesNowPlaying(): $error, stackTrace: $stackTrace');
      return MovieResponse.withError(error.toString());
    }
  }

  Future<MovieResponse> getMoviesTopRated() async {
    try {
      final response =
          await HTTP.get('$moviesTopRatedUrl?api_key=${API.apiKey}');
      if (response.statusCode == 200) {
        return MovieResponse.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to get movie details');
      }
    } catch (error, stackTrace) {
      print('Error in getMoviesTopRated(): $error, stackTrace: $stackTrace');
      return MovieResponse.withError(error.toString());
    }
  }

  Future<MovieResponse> getMoviesBySearch(String searchText) async {
    if (searchText.length > 0) {
      try {
        print('$moviesSearchUrl?api_key=${API.apiKey}&query=$searchText');
        final response = await HTTP
            .get('$moviesSearchUrl?api_key=${API.apiKey}&query=$searchText');
        if (response.statusCode == 200) {
          print('Search results JSON: ${jsonDecode(response.body)}');
          return MovieResponse.fromJson(jsonDecode(response.body));
        } else {
          throw Exception(
              'Failed to get movie details: ${response.statusCode} - ${response.body}');
        }
      } catch (error, stackTrace) {
        print('Error in getMoviesBySearch(): $error, stackTrace: $stackTrace');
        throw Exception('Failed to get movie details');
      }
    } else {
      return MovieResponse();
    }
  }

  Future<MovieResponse> getMoviesByGenre(int genreId) async {
    try {
      final headers = {
        'api_key': API.apiKey,
        'language': 'en-US',
        'page': 1,
        'with_genre': genreId,
      };
      final response = await HTTP
          .get('$moviesAllUrl?api_key=${API.apiKey}&with_genre=$genreId');
      return MovieResponse.fromJson(jsonDecode(response.body));
    } catch (error, stackTrace) {
      print('Error in getMoviesByGenre(): $error, stackTrace: $stackTrace');
      return MovieResponse.withError(error.toString());
    }
  }

  Future<GenreResponse> getGenres() async {
    try {
      final response = await HTTP.get(genresUrl, headers: headers);
      return GenreResponse.fromJson(jsonDecode(response.body));
    } catch (error, stackTrace) {
      print('Error in getGenres(): $error, stackTrace: $stackTrace');
      return GenreResponse.withError(error.toString());
    }
  }

  Future<ActorResponse> getActors() async {
    try {
      print('$actorsUrl?api_key=${API.apiKey}');
      final response = await HTTP.get('$actorsUrl?api_key=${API.apiKey}');
      if (response.statusCode == 200) {
        return ActorResponse.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to get actor details');
      }
    } catch (error, stackTrace) {
      print('Error in getActors(): $error, stackTrace: $stackTrace');
      return ActorResponse.withError(error.toString());
    }
  }
}

Repository repository = Repository();
