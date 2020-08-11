class Actor {
  final int id;
  final String name;
  final String picture;

  Actor({
    this.id,
    this.name,
    this.picture,
  });

  Actor.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        picture =
            'https://image.tmdb.org/t/p/w200' + (json['profile_path'] ?? '');
}

class ActorResponse {
  final List<Actor> actors;
  final String error;

  ActorResponse({this.actors, this.error});

  ActorResponse.fromJson(Map<String, dynamic> json)
      : actors = (json['results'] as List)
            .map((i) => new Actor.fromJson(i))
            .toList(),
        error = '';

  ActorResponse.withError(String error)
      : actors = [],
        this.error = error;
}
