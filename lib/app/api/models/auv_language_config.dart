/// 语言配置
class AuvLanguageConfig {
  final String language;
  final String name;

  AuvLanguageConfig({
    required this.language,
    required this.name,
  });

  factory AuvLanguageConfig.fromJson(Map<String, dynamic> json) {
    return AuvLanguageConfig(
      language: json['language'] ?? '',
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'language': language,
        'name': name,
      };
}
