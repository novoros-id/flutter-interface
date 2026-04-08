import 'package:flutter/material.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_button.dart';
import '../services/auth_service.dart';
import '../utils/app_theme.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _authService = AuthService();

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  DateTime? _birthDate;
  bool _isLoading = false;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
      locale: const Locale('ru', 'RU'),
    );

    if (picked != null) {
      setState(() {
        _birthDate = picked;
      });
    }
  }

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;
    if (_birthDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Выберите дату рождения')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final success = await _authService.register(
        email: _emailController.text.trim(),
        password: _passwordController.text,
        firstName: _firstNameController.text.trim(),
        lastName: _lastNameController.text.trim(),
        birthDate: _birthDate!,
      );

      if (!mounted) return;

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Регистрация успешна!')),
        );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Ошибка регистрации')),
        );
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Ошибка: $e')),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Регистрация',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),

                CustomTextField(
                  hintText: 'Фамилия',
                  suffixIcon: Icons.person_outline,
                  controller: _lastNameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Введите фамилию';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 16),

                CustomTextField(
                  hintText: 'Имя',
                  suffixIcon: Icons.person_outline,
                  controller: _firstNameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Введите имя';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 16),

                GestureDetector(
                  onTap: _selectDate,
                  child: AbsorbPointer(
                    child: CustomTextField(
                      hintText: _birthDate == null
                          ? 'Дата рождения'
                          : '${_birthDate!.day}.${_birthDate!.month}.${_birthDate!.year}',
                      suffixIcon: Icons.calendar_today,
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                CustomTextField(
                  hintText: 'Email',
                  suffixIcon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Введите email';
                    }
                    if (!value.contains('@')) {
                      return 'Введите корректный email';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 16),

                CustomTextField(
                  hintText: 'Пароль',
                  suffixIcon: Icons.lock_outline,
                  obscureText: true,
                  controller: _passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Введите пароль';
                    }
                    if (value.length < 6) {
                      return 'Пароль должен быть не менее 6 символов';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 16),

                CustomTextField(
                  hintText: 'Повторите пароль',
                  suffixIcon: Icons.lock_outline,
                  obscureText: true,
                  controller: _confirmPasswordController,
                  validator: (value) {
                    if (value != _passwordController.text) {
                      return 'Пароли не совпадают';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 30),

                CustomButton(
                  text: 'Регистрация',
                  onPressed: _register,
                  isLoading: _isLoading,
                ),

                const SizedBox(height: 20),

                Center(
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Text.rich(
                      TextSpan(
                        text: 'Уже есть аккаунт? - ',
                        style: TextStyle(color: AppTheme.linkColor, fontSize: 14),
                        children: [
                          TextSpan(
                            text: 'Войти',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF335570),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}