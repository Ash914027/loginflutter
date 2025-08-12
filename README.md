
# README for Flutter Application: Login and Home Screen 🎉

## Project Overview 🌟

This project involves developing a Flutter application that consists of two screens: a **Login Screen** and a **Home Screen**. The application utilizes BLoC (Business Logic Component) for state management, implements form validation, and integrates with an external API for data fetching.

## Features 🚀

- **Login Screen**: Allows users to enter their email and password.
- **Home Screen**: Displays a list of images fetched from an external API.

## Implementation Details 🛠️

### 1. Login Screen 🖥️

#### UI Components

- **Email Field**: Input field for email.
- **Password Field**: Input field for password.
- **Submit Button**: Button to submit the login form.

#### Functional Requirements

- **Validation**:
  - **Email Validation**: Must match a regular valid email format.
  - **Password Validation**:
    - Minimum of 8 characters.
    - Must contain at least one uppercase letter, one lowercase letter, one symbol, and one numeric digit.

#### Example Code Snippet

```dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: BlocProvider(
        create: (_) => LoginBloc(),
        child: LoginForm(),
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  // Form fields and validation logic here
}
```

### 2. Navigation 🔄

- On successful login, the application transitions to the **Home Screen**.

### 3. Home Screen 🖼️

#### Data Display

- Fetch and display 10 images from the following API: [https://picsum.photos/](https://picsum.photos/).
- Images are displayed in a vertical list view with proportional padding.

#### Cell Layout

- **Image**: Width matches screen width; height adjusts dynamically based on the image’s aspect ratio.
- **Title**: Dark text color styled with Montserrat Semi-Bold.
- **Description**: Dark grey color, styled with Montserrat Regular, maximum of 2 lines.

#### Example Code Snippet

```dart
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: FutureBuilder<List<ImageData>>(
        future: fetchImages(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ImageCell(imageData: snapshot.data![index]);
              },
            );
          }
        },
      ),
    );
  }

  Future<List<ImageData>> fetchImages() async {
    final response = await http.get(Uri.parse('https://picsum.photos/v2/list?page=1&limit=10'));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => ImageData.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load images');
    }
  }
}
```

### Screenshots 📸

Include screenshots of the application for better understanding. You can take screenshots of both the login and home screens and add them here.

![Login Screen](https://github.com/user-attachments/assets/b49e7a68-9882-4614-87e3-c4a0514087d4) 

![Home Screen](https://github.com/user-attachments/assets/c355a5d2-f77a-4feb-b9d4-54370ecdda93) 


## APK Download 📥

You can download the APK for the application using the link below:

[Download APK](https://drive.google.com/drive/folders/1KvTd-8ky9ER2GzQoyZkBZZZSyKbJBGHz)

## Conclusion 🎊

This Flutter application demonstrates the use of BLoC for state management, form validation, and API integration. The code snippets provided give a basic structure to get started with the implementation.

## Requirements 📋

- Flutter SDK
- Dart
- Dependencies: `flutter_bloc`, `http`, `google_fonts` (for custom fonts)

## Installation ⚙️

1. Clone the repository.
2. Navigate to the project directory.
3. Run `flutter pub get` to install dependencies.
4. Use `flutter run` to start the application.


