class HasMax {
  final String? message;
  final String? Function()? messageFn;
  final int max;

  const HasMax(this.max, {this.message, this.messageFn});
}

class HasMaxDouble {
  final String? message;
  final String? Function()? messageFn;
  final double max;

  const HasMaxDouble(this.max, {this.message, this.messageFn});
}

class HasMaxNumber {
  final String? message;
  final String? Function()? messageFn;
  final num max;

  const HasMaxNumber(this.max, {this.message, this.messageFn});
}
