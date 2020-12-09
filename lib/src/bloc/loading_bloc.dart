import 'package:rxdart/subjects.dart';

class LoadingBloc {
  var _loadingStreamController = BehaviorSubject<bool>();
  Function(bool) get loadingSink => _loadingStreamController.sink.add;
  Stream<bool> get loadingSteam => _loadingStreamController.stream;
  dispose() {
    _loadingStreamController.close();
  }
}
