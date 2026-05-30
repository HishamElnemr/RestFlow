# 🔐 Auth Module Implementation Plan

## 📌 Context
We are currently building the Authentication and Authorization module for the Restflow SaaS application. The live backend server is not fully deployed yet. Therefore, we will build the Flutter frontend using **Mocking (Simulation)** for the data layer, which will easily be swapped to real networking later.

## 📄 Documentation & API Contracts
- **Postman Documentation:** [Restflow API Workspace](https://documenter.getpostman.com/view/38748410/2sBXwntBpW#intro)
- **Local Backend Reference:** You have access to the local C# backend repository in the workspace. Please inspect `RestflowAPI/DTOs/Auth` and `RestflowAPI/Controllers/AuthController.cs` to understand the exact payload structures, field names, and expected responses.

## ⚙️ Business Rules
1. **Tenant ID Management:** `tenant_id` is automatically handled via the JWT by the backend. Do not include it in API headers or payloads from Flutter.
2. **Registration:** Requires `fullName`, `email`, `phoneNumber`, `password`, and `confirmPassword`.
3. **OTP Verification:** Necessary for both Email and Phone to activate the account.
4. **Login:** Can be performed using Email or Phone. It returns both an Access Token and a Refresh Token.
5. **Token Management:** Tokens must be stored securely locally.

## 🚀 Tasks for the AI Agent (Step-by-Step)
When instructed to begin, follow these steps strictly:

1. **Dart Models (`lib/features/auth/data/models/`)**: 
   - Analyze the Postman link and C# DTOs.
   - Generate exact Dart models (e.g., `LoginRequestModel`, `RegisterRequestModel`, `TokenResponseModel`).
2. **Secure Storage Service (`lib/core/services/`)**: 
   - Implement a service using `flutter_secure_storage` to save, read, and delete the Access and Refresh JWTs.
3. **Mock Data Layer (`lib/features/auth/data/datasources/`)**: 
   - Create `AuthMockDataSource`.
   - Implement functions for `login`, `register`, `verifyOtp`, and `refreshToken`.
   - Use `Future.delayed` (approx. 2 seconds) to simulate network latency.
   - Return valid mock JWT strings for successful scenarios, and throw custom exceptions (from `lib/core/errors/`) for edge cases like duplicate emails or invalid credentials.
4. **Domain & Presentation (`lib/features/auth/domain/` & `presentation/`)**: 
   - Create the necessary Repositories and ViewModels (MVVM) to consume the mock data source.

*Wait for the developer's prompt before generating code.*