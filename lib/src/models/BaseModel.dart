class BaseModel {
  bool _status = false;
  String _error = '';


  bool get status => _status;

  set status(bool value) {
    _status = value;
  }

  String get error => _error;

  set error(String value) {
    _error = value;
  }
}
