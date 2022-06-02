import 'package:cat_api/model/cats_model.dart';
import 'package:flutter/foundation.dart';

abstract class CatsState extends Object {
  const CatsState();
}

class CatsInitial extends CatsState {
  const CatsInitial();
}

class CatsLoading extends CatsState {
  const CatsLoading();
}

class CatsCompleted extends CatsState {
  final List<CatsFacts>? response;
  const CatsCompleted(this.response);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CatsCompleted && listEquals(other.response, response);
  }

  @override
  int get hashCode => response.hashCode;
}

class CatsError extends CatsState {
  final String errorMessage;
  const CatsError(this.errorMessage);
}
