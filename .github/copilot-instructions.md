# 🤖 AI Agent Flutter Development Guidelines: Restflow SaaS

Welcome! As an AI agent working on this Flutter project, your primary goal is to maintain clean, scalable, and highly readable code. You must strictly adhere to the following architecture, styling, and structural guidelines.

## 🏗️ 1. Architecture & Folder Structure
This project follows a **Feature-First Clean Architecture** utilizing the **MVVM pattern** for the presentation layer.

### Directory Breakdown
The `lib/` folder is divided into two main sections: `core` and `features`.

- **`lib/core/`**: Contains globally shared resources, configurations, and generic components.
  - `/constants/`: App-wide constants.
  - `/errors/`: Exception and failure models.
  - `/routes/`: App navigation routing configuration.
  - `/services/`: Global services (e.g., API clients, local storage, DI).
  - `/theme/`: Theming and color configurations.
  - `/utils/`: Helper classes, extension methods, and asset managers.
  - `/widgets/`: **CRITICAL:** Any UI widget used in more than one place must be placed here.
- **`lib/features/`**: Contains isolated feature modules. Each feature has its own layered architecture: `data/`, `domain/`, and `presentation/`.

## 🚦 2. Routing & Navigation Rules
When creating a new screen or view, you MUST follow this strict two-step registration process:
1. **Route Name Definition**: Register the unique string identifier inside `lib/core/routes/routes_name.dart`.
2. **Route Mapping**: Define the route generation and page binding inside `lib/core/routes/app_routes.dart`.
*Never hardcode route strings inside views; always reference the constants from `routes_name.dart`.*

## 💉 3. Dependency Injection (DI)
We utilize the `get_it` package for service location and dependency injection.
- All global singletons, factories, repositories, network clients, and ViewModels must be registered inside `lib/core/services/getit_services.dart`.

## 🎨 4. Theming, UI, Localization and Assets
- **Localization**: The app currently supports **English (en) ONLY**. 
- **Theming**: The app operates in **Light Mode ONLY**. Do not write logic for Dark Mode.
- **Colors & Typography**: Always use context-based theme colors (`Theme.of(context)`) and predefined styles from `lib/core/utils/app_styles.dart`.
- **Images & Assets**: Always reference assets via the `lib/core/utils/app_images.dart` class.

## 🌐 5. Networking, API & Security Rules
- **Retrofit**: API clients should be generated using `retrofit`.
- **CRITICAL TENANT RULE:** **DO NOT** send `tenant_id` in the API headers for any request. The backend integrates the `tenant_id` directly inside the JWT token claims. Whenever an authenticated request is made, sending the `Authorization: Bearer <jwt>` is sufficient.

## ♻️ 6. Agent Workflow Execution
1. **Analyze**: Check the folder structure and layered architecture needed.
2. **Register**: Declare routes in `routes_name.dart` and DI in `getit_services.dart`.
3. **Implement**: Write feature code adhering to Light Mode and English-only defaults.
4. **Refactor**: Split large widgets and move shared UI components to `lib/core/widgets/`.