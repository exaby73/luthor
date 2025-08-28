class HasLength {
  final int length;
  final String? message;
  final String? Function()? messageFn;

  const HasLength(this.length, {this.message, this.messageFn});
}
