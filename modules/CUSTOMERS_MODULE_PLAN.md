# 🤖 CUSTOMERS_MODULE_PLAN.md

## Context

We are building the "Customers" module for the Restflow SaaS application. This acts as a lightweight CRM to manage restaurant patrons.
CRITICAL: We are NOT using Mocking. We will integrate directly with the REAL backend endpoints using `Retrofit`.

## Resources

1. **Local Backend Code:** You have access to the local .NET backend repository. Look into the Controllers (e.g., `CustomersController.cs`) and the DTOs folder (e.g., `DTOs/Customers`) to understand the exact JSON structures, data types, and route definitions.
2. **Postman Documentation:** Review the Customers section here: https://documenter.getpostman.com/view/38748410/2sBXwntBpW#7ff25d67-f34b-49e1-bf57-9df91d233cb4

## Business Rules & Validations

- **Required Fields:** `full_name` and `phone_number`.
- **Unique Constraint:** The `phone_number` MUST be unique per tenant. The backend will return an error if a duplicate is sent.
- **Soft Delete:** Customers are never permanently deleted. Use the `status` field (Active/Inactive) to toggle visibility.
- **Tenant Isolation:** Do NOT send `tenant_id` in headers or body. The backend extracts it automatically from the JWT.

## Step-by-Step Agent Task

1. **Dart Models:** Read the C# DTOs and generate the corresponding Dart models (e.g., `CustomerModel`, `CreateCustomerRequest`, `UpdateCustomerRequest`). Use `json_serializable`.
2. **API Client (Retrofit):** Create a `CustomersApiService` abstract class using Retrofit. Define the GET, POST, and PATCH methods according to the Postman documentation and C# controllers. Trigger the build runner to generate the `.g.dart` file.
3. **Repository Layer:** Create the `CustomersRepository` (Domain and Data implementations) to call the Retrofit service and handle exceptions (specifically catching duplicate phone number 400 errors).
4. **State Management:** Create the necessary ViewModel/Cubit to manage the state for fetching the customers list, creating, updating, and toggling status.
5. Do NOT write any UI (Screens/Widgets) until the data and logic layers are fully generated and registered in `getit_services.dart`.
