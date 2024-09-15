import 'dart:io';

void main() {
  String yourProjectName =
      'your_project_name'; // Variable for your project name
  print('Generating MVC folder structure for Flutter with GetX...');

  // Define base directory
  String baseDir = 'lib/';

  // Create necessary folders
  createDirectory('$baseDir/core/constants');
  createDirectory('$baseDir/core/bindings');
  createDirectory('$baseDir/core/services');
  createDirectory('$baseDir/core/utils');

  createDirectory('$baseDir/models');

  createDirectory('$baseDir/controllers');

  createDirectory('$baseDir/views/auth');
  createDirectory('$baseDir/views/product');

  createDirectory('$baseDir/routes');

  // Generate sample files with sample content
  createFileWithContent(
      '$baseDir/core/constants/app_colors.dart', appColorsSample());
  createFileWithContent(
      '$baseDir/core/constants/app_images.dart', appImagesSample());
  createFileWithContent(
      '$baseDir/core/constants/app_strings.dart', appStringsSample());

  createFileWithContent('$baseDir/core/bindings/app_bindings.dart',
      appBindingsSample(yourProjectName));
  createFileWithContent(
      '$baseDir/core/services/api_service.dart', apiServiceSample());
  createFileWithContent(
      '$baseDir/core/utils/validators.dart', validatorsSample());

  createFileWithContent('$baseDir/models/user_model.dart', userModelSample());
  createFileWithContent(
      '$baseDir/models/product_model.dart', productModelSample());

  createFileWithContent(
      '$baseDir/controllers/auth_controller.dart', authControllerSample());
  createFileWithContent('$baseDir/controllers/product_controller.dart',
      productControllerSample());

  createFileWithContent(
      '$baseDir/views/auth/login_view.dart', loginViewSample(yourProjectName));
  createFileWithContent('$baseDir/views/product/product_list_view.dart',
      productListViewSample(yourProjectName));

  createFileWithContent(
      '$baseDir/routes/app_pages.dart', appPagesSample(yourProjectName));

  print('MVC folder structure and files generated successfully!');
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

// Sample content for app_bindings.dart (with dynamic project name)
String appBindingsSample(String projectName) {
  return '''
import 'package:get/get.dart';
import 'package:$projectName/controllers/auth_controller.dart';
import 'package:$projectName/controllers/product_controller.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController());
    Get.lazyPut<ProductController>(() => ProductController());
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
    final response = await http.get(Uri.parse('\$endpoint'));
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

// Sample content for product_model.dart
String productModelSample() {
  return '''
class ProductModel {
  final String id;
  final String name;
  final double price;

  ProductModel({required this.id, required this.name, required this.price});
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

// Sample content for product_controller.dart
String productControllerSample() {
  return '''
import 'package:get/get.dart';

class ProductController extends GetxController {
  var productList = [].obs;

  void fetchProducts() {
    // Fetch product logic
    productList.value = [
      {'id': '1', 'name': 'Product 1', 'price': 50.0},
      {'id': '2', 'name': 'Product 2', 'price': 30.0},
    ];
  }
}
''';
}

// Sample content for login_view.dart (with dynamic project name)
String loginViewSample(String projectName) {
  return '''
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:$projectName/controllers/auth_controller.dart';

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

// Sample content for product_list_view.dart (with dynamic project name)
String productListViewSample(String projectName) {
  return '''
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:$projectName/controllers/product_controller.dart';

class ProductListView extends StatelessWidget {
  final ProductController productController = Get.find();

  @override
  Widget build(BuildContext context) {
    productController.fetchProducts();

    return Scaffold(
      appBar: AppBar(
        title: Text('Product List'),
      ),
    );
  }
}
''';
}

// Sample content for app_pages.dart (with dynamic project name)
String appPagesSample(String projectName) {
  return '''
import 'package:get/get.dart';
import 'package:$projectName/views/auth/login_view.dart';
import 'package:$projectName/views/product/product_list_view.dart';

class AppPages {
  static final routes = [
    GetPage(name: '/login', page: () => LoginView()),
    GetPage(name: '/products', page: () => ProductListView()),
  ];
}
''';
}
