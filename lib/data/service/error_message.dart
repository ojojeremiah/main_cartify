

class ErrorMessageHelper {
  static String getUserFriendlyMessage(String technicalError) {
    if (technicalError.contains('network') || technicalError.contains('connection')) {
      return 'No internet connection. Please check your network.';
    } else if (technicalError.contains('timeout')) {
      return 'Request timed out. Please try again.';
    } else if (technicalError.contains('404')) {
      return 'Products not found.';
    } else {
      return 'Unable to load products. Please try again later.';
    }
  }
}