# People Browser

People Browser is a Flutter-based mobile application that allows users to explore 
and discover random profiles using the Random User API. 

The app presents user-friendly profile cards with essential personal details, 
making it ideal for scenarios like social discovery, networking, dating, or matrimony-style browsing.
## Features

- **Landing Screen**: A beautiful entry point with custom illustrations and smooth onboarding.
- **Home Dashboard**: A personalized dashboard that serves as a central hub for navigation.
- **Dynamic List**: Fetches and displays a list of people with their name, avatar, and contact details.
- **Pull-to-Refresh**: Refresh the list anytime to get new data.
- **Search**: Real-time client-side search by name.
- **Detail View**: Interactive detail screen with high-fidelity UI and Hero animations.
- **Error Handling**: Graceful error states with retry functionality.
- **Modern UI**: Clean, responsive design using custom themes and subtle animations.

## Tech Stack & Libraries

- **Framework**: Flutter
- **State Management**: flutter_bloc - Chosen for its robustness, predictable state changes, and clear separation of concerns.
- **Networking**: dio - A powerful HTTP client for Dart, supporting interceptors, global configuration, and better error handling.
- **Models & Equality**: equatable - Simplifies object comparison, which is essential for BLoC state updates.
- **UI Components**:
  - [cached_network_image]: For efficient image loading and caching.
  - [shimmer]: For a premium loading experience.

## Architecture

The project follows a simplified **Clean Architecture** pattern, ensuring separation of concerns:

1.  **Data Layer**:
    *   [PersonModel]: Data structure and JSON serialization.
    *   [PeopleRepository]: Handles API calls and data orchestration.
2.  **Service Layer (BLoC/Cubit)**:
    *   [PeopleCubit]: Manages the application state (Loading, Loaded, Error, Empty) and business logic like search filtering.
3.  **Presentation Layer**:
    *   [Screens]: High-level UI components (List and Detail).
    *   [Widgets]: Reusable UI components (ListTile, ErrorView, LoadingView, etc.).
    *   [Theme]: Centralized styling and brand colors.

## Testing

The application includes a representative set of tests:
- **Model Tests**: Verifies JSON parsing and data integrity.
- **Cubit Tests**: Validates state transitions for loading, successful data fetch, error handling, and search filtering.

To run the tests:
### bash
flutter test

# 
### How to Run

1.  **Clone the repository**.
2.  **Install dependencies**:
    - flutter pub get
3.  **Run the app**:
    - flutter run