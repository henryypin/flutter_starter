/// Supplies the current bearer token, or `null` when the user is signed out.
///
/// Implementations read the token from storage and never refresh it; expired
/// sessions must be handled by the caller.
typedef TokenProvider = Future<String?> Function();
