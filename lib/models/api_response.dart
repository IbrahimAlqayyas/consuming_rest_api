class APIResponse<T> {
  T data;
  bool error;
  String errorMessage;

  APIResponse({this.data, this.error = false, this.errorMessage}); //  initialized by false because most cases we won't have errors
}