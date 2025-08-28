class MatchRegex {
  final String pattern;
  final String? message;
  final String? Function()? messageFn;

  const MatchRegex(this.pattern, {this.message, this.messageFn});
}
