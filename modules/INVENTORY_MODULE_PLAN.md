# 📦 INVENTORY MODULE PLAN (Logic & Data Layer Only)

## 📌 Context

You are generating the data, domain, and presentation (State Management) layers for the **Inventory Module** in the Restflow SaaS application.
**CRITICAL: DO NOT WRITE ANY UI CODE.** Focus purely on models, API services, repositories, and state management (MVVM).

## 🔗 Resources

- **Postman Documentation:** [Inventory Postman Docs](https://documenter.getpostman.com/view/38748410/2sBXwntBpW#be92cbce-d509-4bf1-ac92-a1ac46effd40)
- **Local Backend Repository:** You must search and read the local `.NET` files inside the `RestflowAPI/Controllers/` (e.g., `InventoryController.cs`) and the related `DTOs` folders to extract the EXACT variable names and JSON structures.

## 💼 Business Rules (Strictly Enforced)

1. **Tenant Isolation:** The `tenant_id` is handled globally via the JWT. **Do not** add `tenant_id` to request headers or bodies in the app.
2. **Role-Based Access:** - **Super Admin:** Manages Inventory Categories (Master list).
   - **Owner & Employee:** Manages Inventory Items, Stock Movements, and views Low Stock Alerts.
3. **No Negative Stock:** Current quantity cannot go below 0. Any "Stock Out" or "Adjustment" transaction that results in negative stock must be handled as an error.
4. **No Permanent Deletion:** Items are "Deactivated" (Soft Delete), never permanently deleted, to preserve movement history.
5. **Low Stock Alert Logic:** An item is flagged as "Low Stock" if `current_quantity <= minimum_quantity`.
6. **Stock Movements:** Allowed transaction types are `stock_in`, `stock_out`, and `adjustment`.

## 🛠️ Step-by-Step Execution Plan

**Agent Task:** Please execute the following steps sequentially. Finish Step 1 and present the code, then wait for my confirmation to proceed to Step 2.

### Step 1: Data Models Generation

- Read the C# DTOs and Postman responses.
- Generate Dart models using `json_serializable` and `equatable`.
- Required Models:
  - `CategoryModel` (id, name)
  - `InventoryItemModel` (id, item_name, category, unit_of_measure, current_quantity, minimum_quantity, cost_per_unit, active_status)
  - `StockMovementModel` (transaction_id, transaction_type, quantity, note, transaction_date)
  - `InventoryRequestDtos` (for creation, updating, and movement transactions).

### Step 2: Retrofit API Client

- Create `InventoryApiService` using the `retrofit` and `dio` packages.
- Define the endpoints strictly based on the Postman docs and C# Controllers (e.g., GET `/items`, POST `/items`, PATCH `/items/{id}/deactivate`, POST `/items/{id}/transactions`, GET `/alerts/low-stock`).

### Step 3: Repository Implementation

- Create `InventoryRepository` (and its implementation) to wrap the `InventoryApiService`.
- Use the `dartz` package (or your standard Either/Result pattern) to return `Either<Failure, T>`.
- Catch API errors (e.g., 400 Bad Request for "insufficient quantity" during stock-out) and map them to readable domain exceptions.

### Step 4: State Management (ViewModels)

- Create the ViewModels / Cubits for:
  - Fetching the Inventory List (with pagination and category filtering).
  - Adding/Editing an Inventory Item.
  - Submitting a Stock Movement (In/Out/Adjustment).
  - Fetching Low Stock Alerts.
