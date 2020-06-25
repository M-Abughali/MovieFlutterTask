import 'package:task/models/Movie.dart';

class MovieResult {
  MovieResult({
    this.results,
    this.page,
    this.totalResults,
    this.dates,
    this.totalPages,
  });

  List<Movie> results;
  int page;
  int totalResults;
  Dates dates;
  int totalPages;

  factory MovieResult.fromJson(Map<String, dynamic> json) => MovieResult(
    results: List<Movie>.from(json["results"].map((x) => Movie.fromJson(x))),
    page: json["page"],
    totalResults: json["total_results"],
    dates: Dates.fromJson(json["dates"]),
    totalPages: json["total_pages"],
  );

  Map<String, dynamic> toJson() => {
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
    "page": page,
    "total_results": totalResults,
    "dates": dates.toJson(),
    "total_pages": totalPages,
  };
}

class Dates {
  Dates({
    this.maximum,
    this.minimum,
  });

  DateTime maximum;
  DateTime minimum;

  factory Dates.fromJson(Map<String, dynamic> json) => Dates(
    maximum: DateTime.parse(json["maximum"]),
    minimum: DateTime.parse(json["minimum"]),
  );

  Map<String, dynamic> toJson() => {
    "maximum": "${maximum.year.toString().padLeft(4, '0')}-${maximum.month.toString().padLeft(2, '0')}-${maximum.day.toString().padLeft(2, '0')}",
    "minimum": "${minimum.year.toString().padLeft(4, '0')}-${minimum.month.toString().padLeft(2, '0')}-${minimum.day.toString().padLeft(2, '0')}",
  };
}

