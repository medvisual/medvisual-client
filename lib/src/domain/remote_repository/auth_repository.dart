import 'package:medvisual/src/data/remote/models/auth_response/auth_response.dart';
import 'package:medvisual/src/data/remote/models/user/user.dart';

abstract interface class AuthRepository {
  Future<AuthResponse> login(User user);
  Future<void> register(User user);
}
