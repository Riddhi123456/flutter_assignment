abstract class AbstractMapper<JsonString, MappedResult> {
  MappedResult toViewModel(JsonString jsonString, int statusCode);
  String errorMessage(int statusCode) {
    String rMessage = '';
    if (statusCode == 400) {
      rMessage = 'Some information are missing';
    } else if (statusCode == 401) {
      rMessage = 'You are not authorize to access';
    } else if (statusCode == 403) {
      rMessage = 'Unable to accesss this time';
    } else if (statusCode == 404) {
      rMessage = 'No Data Available';
    } else if (statusCode == 500) {
      rMessage = 'Please try again later';
    } else if (statusCode == 501) {
      rMessage = 'Unable to access this time';
    } else if (statusCode == 502) {
      rMessage = 'Please try again later';
    } else if (statusCode == 503) {
      rMessage = 'Please try again later';
    } else if (statusCode == 504) {
      rMessage = 'Please try again later';
    } else {
      rMessage = "Please try again later";
    }
    return rMessage;
  }
}
