import '../models/user.dart';

class AuthService {
  // Симуляция задержки сети
  Future<void> _simulateNetworkDelay() async {
    await Future.delayed(const Duration(seconds: 1));
  }

  /// Регистрация пользователя
  Future<bool> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required DateTime birthDate,
  }) async {
    try {
      await _simulateNetworkDelay();

      // Здесь будет реальный API запрос
      // final response = await http.post(
      //   Uri.parse('https://api.example.com/register'),
      //   body: {
      //     'email': email,
      //     'password': password,
      //     'first_name': firstName,
      //     'last_name': lastName,
      //     'birth_date': birthDate.toIso8601String(),
      //   },
      // );
      //
      // if (response.statusCode == 200 || response.statusCode == 201) {
      //   return true;
      // }

      print('Регистрация: $email');
      return true;
    } catch (e) {
      print('Ошибка регистрации: $e');
      return false;
    }
  }

  /// Вход пользователя
  Future<User?> login(String email, String password) async {
    try {
      await _simulateNetworkDelay();

      // Здесь будет реальный API запрос
      // final response = await http.post(
      //   Uri.parse('https://api.example.com/login'),
      //   body: {'email': email, 'password': password},
      // );
      //
      // if (response.statusCode == 200) {
      //   return User.fromJson(json.decode(response.body));
      // }

      print('Вход: $email');
      return User(
        id: '1',
        email: email,
        firstName: 'Test',
        lastName: 'User',
        birthDate: DateTime(1990),
      );
    } catch (e) {
      print('Ошибка входа: $e');
      return null;
    }
  }

  /// Сброс пароля
  Future<bool> resetPassword(String email) async {
    try {
      await _simulateNetworkDelay();

      // Здесь будет реальный API запрос
      // final response = await http.post(
      //   Uri.parse('https://api.example.com/reset-password'),
      //   body: {'email': email},
      // );
      //
      // return response.statusCode == 200;

      print('Сброс пароля для: $email');
      return true;
    } catch (e) {
      print('Ошибка сброса пароля: $e');
      return false;
    }
  }
}