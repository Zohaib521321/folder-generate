import 'dart:io';

void main() {
  const String yourProjectName =
      'paypal_clone'; // Define your project name here

  print('Generating MVVM folder structure for Flutter with GetX...');

  // Define base directory
  String baseDir = 'lib/';

  // Create necessary folders
  createDirectory('$baseDir/core/constants');
  createDirectory('$baseDir/core/bindings');
  createDirectory('$baseDir/core/services');
  createDirectory('$baseDir/core/utils');

  createDirectory('$baseDir/data/models');
  createDirectory('$baseDir/data/repositories');
  createDirectory('$baseDir/data/providers');

  createDirectory('$baseDir/presentation/controllers');
  createDirectory('$baseDir/presentation/views/auth');
  createDirectory('$baseDir/presentation/views/product');
  createDirectory('$baseDir/presentation/widgets');
  createDirectory('$baseDir/presentation/dialogs');

  createDirectory('$baseDir/routes');

  // Generate sample files with sample content
  createFileWithContent(
      '$baseDir/core/constants/app_colors.dart', appColorsSample());
  createFileWithContent(
      '$baseDir/core/constants/app_images.dart', appImagesSample());
  createFileWithContent(
      '$baseDir/core/constants/app_strings.dart', appStringsSample());

  createFileWithContent('$baseDir/core/bindings/initial_bindings.dart',
      initialBindingsSample(yourProjectName));
  createFileWithContent(
      '$baseDir/core/services/api_service.dart', apiServiceSample());
  createFileWithContent(
      '$baseDir/core/utils/validators.dart', validatorsSample());

  createFileWithContent(
      '$baseDir/data/models/user_model.dart', userModelSample());
  createFileWithContent('$baseDir/data/repositories/user_repository.dart',
      userRepositorySample(yourProjectName));
  createFileWithContent(
      '$baseDir/data/providers/api_provider.dart', apiProviderSample());

  createFileWithContent(
      '$baseDir/presentation/controllers/auth_controller.dart',
      authControllerSample());
  createFileWithContent('$baseDir/presentation/views/auth/login_view.dart',
      loginViewSample(yourProjectName));
  createFileWithContent(
      '$baseDir/presentation/views/product/product_list_view.dart',
      productListViewSample());
  createFileWithContent(
      '$baseDir/presentation/widgets/custom_button.dart', customButtonSample());

  createFileWithContent(
      '$baseDir/routes/app_pages.dart', appPagesSample(yourProjectName));

  print('Folder structure and files generated successfully!');
}

// Function to create a directory
void createDirectory(String path) {
  final directory = Directory(path);
  if (!directory.existsSync()) {
    directory.createSync(recursive: true);
    print('Created directory: $path');
  }
}

// Function to create a file with content
void createFileWithContent(String path, String content) {
  final file = File(path);
  if (!file.existsSync()) {
    file.writeAsStringSync(content);
    print('Created file: $path');
  }
}

// Sample content for app_colors.dart
String appColorsSample() {
  return '''
import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryColor = Color(0xFF4CAF50);  // Teal Green
  static const Color accentColor = Color(0xFF00BCD4);   // Cyan
  static const Color backgroundColor = Color(0xFFF5F5F5);
  static const Color textColor = Color(0xFF212121);
}
''';
}

// Sample content for app_images.dart
String appImagesSample() {
  return '''
class AppImages {
  static const String logo = 'assets/images/logo.png';
}
''';
}

// Sample content for app_strings.dart
String appStringsSample() {
  return '''
class AppStrings {
  static const String welcome = 'Welcome to the App';
  static const String login = 'Login';
}
''';
}

// Sample content for initial_bindings.dart
String initialBindingsSample(String projectName) {
  return '''
import 'package:get/get.dart';
import 'package:$projectName/presentation/controllers/auth_controller.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController());
  }
}
''';
}

// Sample content for api_service.dart
String apiServiceSample() {
  return '''
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl = 'https://api.example.com/';

  Future<dynamic> getRequest(String endpoint) async {
    final response = await http.get(Uri.parse('""\$endpoint'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }
}
''';
}

// Sample content for validators.dart
String validatorsSample() {
  return '''
class Validators {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email cannot be empty';
    }
    final regex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!regex.hasMatch(value)) {
      return 'Enter a valid email';
    }
    return null;
  }
}
''';
}

// Sample content for user_model.dart
String userModelSample() {
  return '''
class UserModel {
  final String id;
  final String name;
  final String email;

  UserModel({required this.id, required this.name, required this.email});
}
''';
}

// Sample content for user_repository.dart
String userRepositorySample(String projectName) {
  return '''
import 'package:$projectName/data/models/user_model.dart';
import 'package:$projectName/data/providers/api_provider.dart';

class UserRepository {
  final ApiProvider apiProvider;

  UserRepository(this.apiProvider);

  Future<UserModel> fetchUser(String id) async {
    final data = await apiProvider.getUserData(id);
    return UserModel(id: data['id'], name: data['name'], email: data['email']);
  }
}
''';
}

// Sample content for api_provider.dart
String apiProviderSample() {
  return '''
class ApiProvider {
  Future<Map<String, dynamic>> getUserData(String id) async {
    // Mocked API response
    return {'id': id, 'name': 'John Doe', 'email': 'john.doe@example.com'};
  }
}
''';
}

// Sample content for auth_controller.dart
String authControllerSample() {
  return '''
import 'package:get/get.dart';

class AuthController extends GetxController {
  var isLoggedIn = false.obs;

  void login(String email, String password) {
    // Perform login logic
    isLoggedIn.value = true;
  }

  void logout() {
    isLoggedIn.value = false;
  }
}
''';
}

// Sample content for login_view.dart
String loginViewSample(String projectName) {
  return '''
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:$projectName/presentation/controllers/auth_controller.dart';

class LoginView extends StatelessWidget {
  final AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            authController.login('email', 'password');
          },
          child: Text('Login'),
        ),
      ),
    );
  }
}
''';
}

// Sample content for product_list_view.dart
String productListViewSample() {
  return '''
import 'package:flutter/material.dart';

class ProductListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product List'),
      ),
      body: Center(
        child: Text('List of Products'),
      ),
    );
  }
}
''';
}

String customButtonSample() {
  return '''
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  CustomButton({required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(label),
    );
  }
}
''';
}

// Sample content for app_pages.dart
String appPagesSample(String projectName) {
  return '''
import 'package:get/get.dart';
import 'package:$projectName/presentation/views/auth/login_view.dart';
import 'package:$projectName/presentation/views/product/product_list_view.dart';

class AppPages {
  static final routes = [
    GetPage(name: '/login', page: () => LoginView()),
    GetPage(name: '/products', page: () => ProductListView()),
  ];
}
''';
}
