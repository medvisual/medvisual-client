# Medvisual

A Flutter application for medical visualization and disease management.

## View 

https://github.com/user-attachments/assets/98236dd7-f11c-40c9-a17f-f5d0061a37a0

## Features

- User Authentication (Login/Registration)
- B/W Theme
- Disease Management
- Visual Information Processing
- Secure Data Storage
- Cross-platform Support

## Getting Started

### Prerequisites

- Flutter SDK (Latest stable version)
- Dart SDK
- Git

### Installation backend ❤️

```
git clone https://github.com/medvisual/medvisual-backend
```

### Install dependencies
```
flutter pub get
```

### Create a .env file in the root directory with the following variables
```
ENDPOINT-API=your_api_url
```

### Dependencies
```
flutter_bloc: State management

dio: HTTP client

get_it: Dependency injection

realm: Local database

flutter_secure_storage: Secure storage for sensitive data

talker_flutter: Logging and debugging

Architecture
This project follows Clean Architecture principles and BLoC pattern for state management. The application is divided into three main layers:

Presentation Layer (UI)

Domain Layer (Business Logic)

Data Layer (Data Sources)

Security
Secure storage for sensitive data

Token-based authentication

Encrypted local storage using Realm

Contributing
Fork the repository

Create your feature branch ( git checkout -b feature/amazing-feature)

Commit your changes ( git commit -m 'Add some amazing feature')

Push to the branch ( git push origin feature/amazing-feature)

Open a Pull Request
```
