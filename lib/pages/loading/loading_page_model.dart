import 'dart:async';

class LoadingPageModel {
  final bool isLoading;
  LoadingPageModel({this.isLoading: true});

  LoadingPageModel copyWith({isLoading}) {
    return LoadingPageModel(isLoading: isLoading ?? this.isLoading);
  }
}
