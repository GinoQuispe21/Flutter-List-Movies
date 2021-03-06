class Movie {
  int id;
  String overview;
  String posterPath;
  String title;
  bool isFavorite;

  Movie(
      {this.id,
      this.overview,
      this.posterPath,
      this.title,
      this.isFavorite = false});

  Movie.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    overview = json['overview'];
    posterPath = json['poster_path'];
    title = json['title'];
    //isFavorite = json['isFavorite'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['overview'] = this.overview;
    data['poster_path'] = this.posterPath;
    data['title'] = this.title;
    //data['isFavorite'] = this.isFavorite;
    return data;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'overview': overview,
      'poster_path': posterPath,
    };
  }
}
