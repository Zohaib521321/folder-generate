import 'dart:io';

void main() {
  // Define project name
  String projectName =
      'your_project_name'; // Change this to your desired project name

  print('Generating MVC folder structure for Flutter with Provider...');

  // Define base directory
  String baseDir = 'lib/';

  // Create necessary folders
  createDirectory('$baseDir/core/constants');
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

  createFileWithContent(
      '$baseDir/core/services/api_service.dart', apiServiceSample());
  createFileWithContent(
      '$baseDir/core/utils/validators.dart', validatorsSample());

  createFileWithContent('$baseDir/models/user_model.dart', userModelSample());
  createFileWithContent(
      '$baseDir/models/product_model.dart', productModelSample());

  createFileWithContent('$baseDir/controllers/auth_controller.dart',
      authControllerSample(projectName));
  createFileWithContent('$baseDir/controllers/product_controller.dart',
      productControllerSample(projectName));

  createFileWithContent(
      '$baseDir/views/auth/login_view.dart', loginViewSample(projectName));
  createFileWithContent('$baseDir/views/product/product_list_view.dart',
      productListViewSample(projectName));

  createFileWithContent(
      '$baseDir/routes/app_pages.dart', appPagesSample(projectName));

  print('MVC folder structure with Provider generated successfully!');
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

// Sample content for auth_controller.dart with Provider
String authControllerSample(String projectName) {
  return '''
import 'package:flutter/foundation.dart';

class AuthController with ChangeNotifier {
  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  void login(String email, String password) {
    // Perform login logic
    _isLoggedIn = true;
    notifyListeners();
  }

  void logout() {
    _isLoggedIn = false;
    notifyListeners();
  }
}
''';
}

// Sample content for product_controller.dart with Provider
String productControllerSample(String projectName) {
  return '''
import 'package:flutter/foundation.dart';
import 'package:$projectName/models/product_model.dart';

class ProductController with ChangeNotifier {
  List<ProductModel> _products = [];

  List<ProductModel> get products => _products;

  void fetchProducts() {
    // Mock data fetching
    _products = [
      ProductModel(id: '1', name: 'Product 1', price: 50.0),
      ProductModel(id: '2', name: 'Product 2', price: 30.0),
    ];
    notifyListeners();
  }
}
''';
}

// Sample content for login_view.dart with Provider
String loginViewSample(String projectName) {
  return '''
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:$projectName/controllers/auth_controller.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authController = Provider.of<AuthController>(context);

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

// Sample content for product_list_view.dart with Provider
String productListViewSample(String projectName) {
  return '''
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:$projectName/controllers/product_controller.dart';

class ProductListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productController = Provider.of<ProductController>(context);
    productController.fetchProducts();

    return Scaffold(
      appBar: AppBar(
        title: Text('Product List'),
      ),
      body: ListView.builder(
        itemCount: productController.products.length,
        itemBuilder: (context, index) {
          final product = productController.products[index];
          return ListTile(
            title: Text(product.name),
            subtitle: Text(''),
          );
        },
      ),
    );
  }
}
''';
}

// Sample content for app_pages.dart
String appPagesSample(String projectName) {
  return '''
import 'package:flutter/material.dart';
import 'package:$projectName/views/auth/login_view.dart';
import 'package:$projectName/views/product/product_list_view.dart';

class AppPages {
  static final routes = {
    '/login': (context) => LoginView(),
    '/products': (context) => ProductListView(),
  };
}
''';
}
