import 'dart:convert';

import 'package:themoviesapp/api/api.dart';
import 'package:themoviesapp/model/actor.dart';
import 'package:themoviesapp/model/genre.dart';
import 'package:themoviesapp/model/movie.dart';
import 'package:http/http.dart' as HTTP;

enum MoviesDataType { AllMovies, NowPlaying, TopRated, BySearch, ByGenre }

Map<dynamic, String> uriByMovieDataType = {
  MoviesDataType.AllMovies: API.moviesAllUrl,
  MoviesDataType.NowPlaying: API.moviesNowPlayingUrl,
  MoviesDataType.TopRated: API.moviesTopRatedUrl,
  MoviesDataType.BySearch: API.moviesSearchUrl,
  MoviesDataType.ByGenre: API.genresUrl,
};

class Repository {
  static var headers = {
    'api_key': API.apiKey,
    'language': 'en-US',
    'page': 1,
  };

  Future<MovieResponse> getMovies2(MoviesDataType moviesDataType) async {
    try {
      print('${uriByMovieDataType[moviesDataType]}?api_key=${API.apiKey}');
      final response = await HTTP
          .get('${uriByMovieDataType[moviesDataType]}?api_key=${API.apiKey}');
      if (response.statusCode == 200) {
        return MovieResponse.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to get movie2 details');
      }
    } catch (error, stackTrace) {
      print('Error in getMovies2(): $error, stackTrace: $stackTrace');
      throw Exception('Failed to get movie details');
    }
  }

  Future<MovieResponse> getMovies() async {
    try {
      print('${API.moviesAllUrl}?api_key=${API.apiKey}');
      final response =
          await HTTP.get('${API.moviesAllUrl}?api_key=${API.apiKey}');
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
      print('${API.moviesNowPlayingUrl}?api_key=${API.apiKey}');
      final response =
          await HTTP.get('${API.moviesNowPlayingUrl}?api_key=${API.apiKey}');
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

  Future<MovieResponse> getMoviesTopRated(int pageNo) async {
    try {
      final response = await HTTP
          .get('${API.moviesTopRatedUrl}?api_key=${API.apiKey}&page=$pageNo');
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
        print('${API.moviesSearchUrl}?api_key=${API.apiKey}&query=$searchText');
        final response = await HTTP.get(
            '${API.moviesSearchUrl}?api_key=${API.apiKey}&query=$searchText');
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
      final response = await HTTP
          .get('${API.moviesAllUrl}?api_key=${API.apiKey}&with_genre=$genreId');
      return MovieResponse.fromJson(jsonDecode(response.body));
    } catch (error, stackTrace) {
      print('Error in getMoviesByGenre(): $error, stackTrace: $stackTrace');
      return MovieResponse.withError(error.toString());
    }
  }

  Future<GenreResponse> getGenres() async {
    try {
      final response = await HTTP.get(API.genresUrl, headers: headers);
      return GenreResponse.fromJson(jsonDecode(response.body));
    } catch (error, stackTrace) {
      print('Error in getGenres(): $error, stackTrace: $stackTrace');
      return GenreResponse.withError(error.toString());
    }
  }

  Future<ActorResponse> getActors() async {
    try {
      print('${API.actorsUrl}?api_key=${API.apiKey}');
      final response = await HTTP.get('${API.actorsUrl}?api_key=${API.apiKey}');
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
