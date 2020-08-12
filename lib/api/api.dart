class API {
  static final String apiKey = 'b2416802c240057a1a33bc8c818a3548';
  static final String host = 'api.themoviedb.org';
  static final String basePath = '3';
  static final String mainPath = 'https://$host/$basePath';
  static final String mainPathForImages =
      'https://image.tmdb.org/t/p/w200'; //Considered width 200 as a fixed default, can be changed.

  static final String moviesAllUrl = '$mainPath/discover/movie';
  static final String moviesNowPlayingUrl = '$mainPath/movie/now_playing';
  static final String moviesTopRatedUrl = '$mainPath/movie/top_rated';
  static final String moviesSearchUrl = '$mainPath/search/movie';
  static final String genresUrl = '$mainPath/genre/movie/list';
  static final String actorsUrl = '$mainPath/trending/person/week';
}
