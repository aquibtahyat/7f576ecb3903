import 'dart:convert';

class Pagination {
  final int totalRecords;
  final int currentPage;
  final int totalPages;
  final int limit;

  Pagination({
    required this.totalRecords,
    required this.currentPage,
    required this.totalPages,
    required this.limit,
  });

  factory Pagination.fromRawJson(String str) =>
      Pagination.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
    totalRecords: json["totalRecords"],
    currentPage: json["currentPage"],
    totalPages: json["totalPages"],
    limit: json["limit"],
  );

  Map<String, dynamic> toJson() => {
    "totalRecords": totalRecords,
    "currentPage": currentPage,
    "totalPages": totalPages,
    "limit": limit,
  };
}
