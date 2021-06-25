class BaseResponseListener<T> {
  Function(T) onSuccess;
  Function(String) onError;
  Function(bool) showProgress;
  bool isLive=false;

  BaseResponseListener(
      {this.onSuccess, this.onError, this.showProgress,this.isLive});

  updateIfLive(T t) {
    if (isLive!=null&&isLive) {
      onSuccess(t);
    }
  }
}
