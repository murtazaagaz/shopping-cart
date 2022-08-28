class ApiResult {
   String response;
   String errorMsg;
   bool isSuccess;
   ApiResult({
    required this.response,
    this.errorMsg = '',
    required this.isSuccess,
  });
}
