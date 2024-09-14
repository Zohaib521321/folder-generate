import 'dart:io';

void main() {
  // Define project name
  String projectName =
      'your_project_name'; // Change this to your desired project name

  print('Generating MVVM folder structure for Flutter with BLoC...');

  // Define base directory
  String baseDir = 'lib/';

  // Create necessary folders
  createDirectory('$baseDir/core/constants');
  createDirectory('$baseDir/core/services');
  createDirectory('$baseDir/core/utils');

  createDirectory('$baseDir/models');

  createDirectory('$baseDir/blocs/auth');
  createDirectory('$baseDir/blocs/product');

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

  createFileWithContent(
      '$baseDir/blocs/auth/auth_bloc.dart', authBlocSample(projectName));
  createFileWithContent('$baseDir/blocs/product/product_bloc.dart',
      productBlocSample(projectName));

  createFileWithContent(
      '$baseDir/views/auth/login_view.dart', loginViewSample(projectName));
  createFileWithContent('$baseDir/views/product/product_list_view.dart',
      productListViewSample(projectName));

  createFileWithContent(
      '$baseDir/routes/app_pages.dart', appPagesSample(projectName));

  print('MVVM folder structure with BLoC generated successfully!');
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

// Sample content for auth_bloc.dart using BLoC pattern
String authBlocSample(String projectName) {
  return '''
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial());

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is LoginRequested) {
      yield AuthLoading();
      try {
        // Simulate login delay
        await Future.delayed(Duration(seconds: 2));
        yield Authenticated();
      } catch (_) {
        yield AuthError('Login Failed');
      }
    } else if (event is LogoutRequested) {
      yield AuthInitial();
    }
  }
}
''';
}

// Sample content for auth_event.dart (for AuthBloc)
String authEventSample() {
  return '''
part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LoginRequested extends AuthEvent {
  final String email;
  final String password;

  LoginRequested(this.email, this.password);
}

class LogoutRequested extends AuthEvent {}
''';
}

// Sample content for auth_state.dart (for AuthBloc)
String authStateSample() {
  return '''
part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class Authenticated extends AuthState {}

class AuthError extends AuthState {
  final String message;

  AuthError(this.message);

  @override
  List<Object> get props => [message];
}
''';
}

// Sample content for product_bloc.dart using BLoC pattern
String productBlocSample(String projectName) {
  return '''
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:$projectName/models/product_model.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitial());

  @override
  Stream<ProductState> mapEventToState(ProductEvent event) async* {
    if (event is FetchProducts) {
      yield ProductLoading();
      try {
        // Simulate network call delay
        await Future.delayed(Duration(seconds: 2));
        List<ProductModel> products = [
          ProductModel(id: '1', name: 'Product 1', price: 50.0),
          ProductModel(id: '2', name: 'Product 2', price: 30.0),
        ];
        yield ProductLoaded(products);
      } catch (_) {
        yield ProductError('Failed to fetch products');
      }
    }
  }
}
''';
}

// Sample content for product_event.dart (for ProductBloc)
String productEventSample() {
  return '''
part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class FetchProducts extends ProductEvent {}
''';
}

// Sample content for product_state.dart (for ProductBloc)
String productStateSample() {
  return '''
part of 'product_bloc.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<ProductModel> products;

  ProductLoaded(this.products);

  @override
  List<Object> get props => [products];
}

class ProductError extends ProductState {
  final String message;

  ProductError(this.message);

  @override
  List<Object> get props => [message];
}
''';
}

// Sample content for login_view.dart using BLoC
String loginViewSample(String projectName) {
  return '''
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:$projectName/blocs/auth/auth_bloc.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: BlocProvider(
        create: (context) => AuthBloc(),
        child: LoginForm(),
      ),
    );
  }
}
}
class LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        } else if (state is Authenticated) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Login Successful')),
          );
        }
      },
      child: Center(
        child: ElevatedButton(
          onPressed: () {
            BlocProvider.of<AuthBloc>(context).add(LoginRequested('email', 'password'));
          },
          child: Text('Login'),
        ),
      ),
    );
  }
}
''';
}

// Sample content for product_list_view.dart using BLoC
String productListViewSample(String projectName) {
  return '''
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:$projectName/blocs/product/product_bloc.dart';

class ProductListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product List'),
      ),
      body: BlocProvider(
        create: (context) => ProductBloc()..add(FetchProducts()),
        child: ProductList(),
      ),
    );
  }
}
}
class ProductList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state is ProductLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is ProductLoaded) {
          return ListView.builder(
            itemCount: state.products.length,
            itemBuilder: (context, index) {
              final product = state.products[index];
              return ListTile(
                title: Text(product.name),
                subtitle: Text(''),
              );
            },
          );
        } else if (state is ProductError) {
          return Center(child: Text(state.message));
        }
        return Container();
      },
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
