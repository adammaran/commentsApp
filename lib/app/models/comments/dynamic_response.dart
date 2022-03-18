class DynamicResponse<T> {
  final String status;
  final String statusMessage;
  T? response;

  DynamicResponse(this.status, this.statusMessage, {this.response});
}
