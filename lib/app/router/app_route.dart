import 'package:kaisel/kaisel.dart';

/// Every top-level route in the app.
sealed class AppRoute extends KaiselRoute {
  const AppRoute();
}

/// Home screen shown once the user is signed in.
final class Home extends AppRoute {
  const Home();
}

/// Sign-in screen, reachable while signed out.
final class Login extends AppRoute {
  const Login();
}

/// Settings screen.
final class Settings extends AppRoute {
  const Settings();
}

/// Profile screen.
final class Profile extends AppRoute {
  const Profile();
}
