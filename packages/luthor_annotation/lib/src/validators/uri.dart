class IsUri {
  final List<String>? allowedSchemes;
  final String? message;

  const IsUri({this.allowedSchemes, this.message});
}

const isUri = IsUri();
