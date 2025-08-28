class HasMin {
  final String? message;
  final String? Function()? messageFn;
  final int min;

  const HasMin(this.min, {this.message, this.messageFn});
}

class HasMinDouble {
  final String? message;
  final String? Function()? messageFn;
  final double min;

  const HasMinDouble(this.min, {this.message, this.messageFn});
}

class HasMinNumber {
  final String? message;
  final String? Function()? messageFn;
  final num min;

  const HasMinNumber(this.min, {this.message, this.messageFn});
}
