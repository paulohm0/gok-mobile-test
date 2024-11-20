class ReposUserGithubModel {
  final String? name;
  final String? htmlUrl;
  final String? description;
  final String? language;
  final String? updatedAt;

  ReposUserGithubModel({
    required this.name,
    required this.htmlUrl,
    required this.description,
    required this.language,
    required this.updatedAt,
  });

  factory ReposUserGithubModel.fromJson(Map<String, dynamic> json) {
    return ReposUserGithubModel(
      name: json['name'],
      htmlUrl: json['html_url'],
      description: json['description'],
      language: json['language'],
      updatedAt: json['updated_at'],
    );
  }
}
