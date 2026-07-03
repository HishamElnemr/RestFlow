## 🧩 4.5. UI Composition & Widget Structure (STRICT — NO EXCEPTIONS)

This is a **mandatory, non-negotiable** rule for every screen you create. Violating this 
structure is considered a failed implementation, even if the app compiles and looks correct.

### Rule: Every Screen = 2 Files Minimum (Page + Body)

For ANY new screen, you MUST split it into at least two separate widget classes, in two 
separate files:

1. **The Page (Scaffold wrapper)** — file: `lib/features/<feature>/presentation/pages/<name>_page.dart`
   - Contains ONLY: `Scaffold`, `AppBar` (if any), and calls the Body widget.
   - This file must be short (typically under 30-40 lines). If it's longer than that, 
     you are doing it wrong — move logic out.
   - Example skeleton:
```dart
     class LoginPage extends StatelessWidget {
       const LoginPage({super.key});

       @override
       Widget build(BuildContext context) {
         return Scaffold(
           body: SafeArea(
             child: LoginPageBody(),
           ),
         );
       }
     }
```
   - If the screen needs a Cubit/Provider, wrap it here with `BlocProvider` — 
     NOT inside the Body widget.

2. **The Body** — file: `lib/features/<feature>/presentation/widgets/<name>_page_body.dart`
   - Contains the actual layout: `Column`, `Padding`, `ListView`, etc.
   - The Body itself must ALSO be broken down — it should mostly consist of calls 
     to smaller widgets, NOT raw nested widget trees.
   - If the Body's `build()` method exceeds ~50 lines, STOP and extract sections 
     into smaller widgets immediately.

### Rule: Extract Every Repeated or Logical UI Section Into Its Own Widget

Any of the following MUST become its own separate widget file, even if used only once 
on that screen, if it represents a distinct logical section:
- Headers/logos (e.g. `RestflowLogoHeader`)
- Form sections (e.g. `LoginFormFields`)
- A group of related inputs (e.g. `EmailPasswordFields`, `PhoneFields`)
- Toggle/tab controls (e.g. `AuthMethodToggle`)
- Footer/link rows (e.g. `AuthFooterLinks` for "Don't have an account? Sign up")
- Any widget block used in 2+ places → MUST go in `lib/core/widgets/`
- Any widget block used only within this feature → goes in 
  `lib/features/<feature>/presentation/widgets/`

**Rule of thumb**: if you can give a UI section a clear, specific name 
(e.g. "the email/password form", "the toggle tabs", "the footer links"), 
it MUST be its own `StatelessWidget` class in its own file — not an inline 
anonymous widget tree.

### Rule: No Business Logic Inside Small Widgets

Extracted widgets (form sections, toggles, etc.) must remain "dumb" — they receive 
data and callbacks via constructor parameters ONLY. They must NOT:
- Read `context.read<Cubit>()` directly (unless explicitly it's the top-level Body widget 
  wiring the BlocConsumer)
- Contain validation logic (validators are passed in, defined once in the Page/Body 
  or a shared validators file)

### Rule: File Naming Convention

- Page: `<screen_name>_page.dart` → class `<ScreenName>Page`
- Body: `<screen_name>_page_body.dart` → class `<ScreenName>PageBody`
- Sub-widgets: `<descriptive_name>.dart` → class `<DescriptiveName>` 
  (no generic names like `Widget1`, `CustomSection`, `MyForm`)

### Self-Check Before Submitting Code (MANDATORY)

Before presenting the final code, verify ALL of these are true. If ANY is false, 
refactor before responding — do not submit code that fails this checklist:

- [ ] The Page file contains ONLY Scaffold + Body call (no form fields, no columns 
      of widgets, no business logic)
- [ ] The Body's build() method is short and mostly composed of other widget calls, 
      not a deep nested tree
- [ ] Every logical UI section (header, form, toggle, footer, etc.) is its own 
      widget class in its own file
- [ ] No widget file exceeds ~100 lines
- [ ] Shared widgets (used in 2+ places) are in `lib/core/widgets/`, 
      feature-specific ones are in `lib/features/<feature>/presentation/widgets/`
- [ ] No widget class has a generic/vague name

**If you generate a single monolithic file with everything nested inside one 
build() method, this is a FAILED response. Stop, split it according to the rules 
above, and only then respond.**