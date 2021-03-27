import 'dart:async';

import 'package:btix/pages/loading/loading_page_model.dart';

class LoadingBloc {
  final _controller = StreamController<LoadingPageModel>();

  final _model = LoadingPageModel();
}
