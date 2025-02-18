class IsUrl {
  final List<String>? allowedSchemes;
  final String? message;

  const IsUrl({this.allowedSchemes, this.message});
}

const isUrl = IsUrl();
