class TFirebaseAuthException implements Exception {
  final String code;

  TFirebaseAuthException(this.code);

  String get message {
    switch (code) {
      case 'email-already-in-use':
        return 'Email already registered for other accounts. Please use different email.';
      case 'invalid-email':
        return 'Email is not valid.';
      case 'weak-password':
        return 'Please enter a stronger password.';
      case 'operation-not-allowed':
        return 'Operation is not allowed. Please contact support.';
      case 'user-disabled':
        return 'This user has been disabled. Please contact support for help.';
      case 'wrong-password':
        return 'Wrong password.';
      case 'user-not-found':
        return 'There is no account registered for this email.';
      default:
        return 'An unknown error occured.';
    }
  }
}