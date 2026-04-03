# Architecture Overview

## Design Pattern

Harber follows an **MVC (Model-View-Controller)** architecture powered by **GetX** for reactive state management.

| Layer | Role | Example |
|-------|------|---------|
| **Model** | Data structures & Firebase documents | `Salon`, Firestore Maps |
| **View** | Stateless UI widgets | `HomeScreen`, `BookingScreen` |
| **Controller** | Business logic & state | `HomeController`, `BookingController` |

Each screen is a `StatelessWidget` paired with a `GetxController`. The controller holds observable state (`.obs`), and the view rebuilds reactively via `Obx()`.

```dart
// Pattern used across all screens
class SomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SomeController controller = Get.put(SomeController());
    return Obx(() => Scaffold(/* reactive UI */));
  }
}
```

---

## Screen-Controller Mapping

| Screen | Controller | Responsibility |
|--------|-----------|---------------|
| `SplashScreen` | (inline StatefulWidget) | Firebase init, auth check, routing |
| `SlideScreen` | `SlideController` | Onboarding slide index tracking |
| `SignUpScreen` | `SignUpController` | Form state, Firebase Auth creation, Firestore user write |
| `LogInScreen` | `LogInController` | Form state, Firebase Auth sign-in |
| `MyHomeScreen` | `HomeController` | Salon loading, search filtering, upcoming bookings listener |
| `BookingScreen` | `BookingController` | Date/time selection, slot management |
| `PaymentScreen` | `PaymentController` | Service selection, UPI app discovery, payment initiation |

---

## Application Layers

### 1. Presentation Layer (Views)

All screens are `StatelessWidget`s that delegate state to their controllers. UI components include:

- **Staggered animations** on list items (fade + slide)
- **Lottie animations** for splash and payment success
- **Gradient headers** with the app's color palette (`AppColor`)

### 2. State Management Layer (Controllers)

GetX controllers handle:

- **Reactive properties** (`RxString`, `RxBool`, `RxList`, etc.)
- **Lifecycle hooks** (`onInit()` for data loading)
- **Business logic** (search filtering, slot selection, form validation)

### 3. Data Layer (Firebase)

Firebase services used:

| Service | Usage |
|---------|-------|
| **Firebase Auth** | Email/password authentication |
| **Cloud Firestore** | Salon data, user profiles, booking records |
| **Firebase Storage** | Asset storage (salon images) |

### 4. Payment Layer (UPI India)

- Discovers installed UPI apps on the device
- Initiates transactions with amount, receiver ID, and transaction note
- Stores booking record in Firestore upon successful payment

---

## Data Flow

### Authentication Flow

```
App Launch
  → Firebase.initializeApp()
  → Check FirebaseAuth.instance.currentUser
      ├── User exists → MyHomeScreen
      └── No user → SlideScreen (onboarding)
                        ├── "Sign Up" → SignUpScreen
                        │     → Firebase Auth createUser
                        │     → Firestore write to users/{email}
                        │     → MyHomeScreen
                        └── "Log In" → LogInScreen
                              → Firebase Auth signIn
                              → MyHomeScreen
```

### Booking Flow

```
MyHomeScreen
  → Load salons from Firestore (salons/{state}/{city})
  → User taps a salon card
  → BookingScreen (receives salon data via Get.arguments)
      → Select date (CalendarDatePicker2)
      → Select time slot (ToggleButtons)
      → Confirm via bottom sheet
      → PaymentScreen (receives booking details via Get.arguments)
          → Select service (Hair Cut / Shave / Facial)
          → Select UPI app
          → UpiIndia.startTransaction()
          → On success: write to Firestore users/{email}/booking/{timestamp}
          → Show Lottie success animation
          → Navigate back to MyHomeScreen
```

### Data Sync

The `HomeController` sets up a real-time Firestore listener on the user's booking subcollection. New bookings appear immediately in the "Upcoming Appointments" section without manual refresh.

---

## Firestore Schema

### salons collection

```
salons/{state}/{city}/{salon_id}
{
  name: String,       // "Urban Cuts"
  image: String,      // URL to salon image
  loc: String,        // "Main Street, Vellore"
  rate: double         // 4.5
}
```

### users collection

```
users/{email}
{
  name: String,       // "John Doe"
  email: String,      // "john@example.com"
  uid: String          // Firebase Auth UID
}

users/{email}/booking/{timestamp}
{
  name: String,       // Salon name
  loc: String,        // Salon location
  date: Timestamp,    // Booking date
  time: String,       // "10:00 AM - 10:30 AM"
  service: String      // "Hair Cut"
}
```

---

## Navigation Architecture

Harber uses **GetX navigation** with three patterns:

| Method | Behavior | Used When |
|--------|----------|-----------|
| `Get.to()` | Push new screen (can go back) | Home → Booking, Booking → Payment |
| `Get.off()` | Replace current screen | Slide → SignUp, SignUp → LogIn |
| `Get.offAll()` | Clear entire stack, push new | After login/signup → Home, After payment → Home |

This ensures users cannot navigate back to login after authenticating or back to payment after completing a transaction.

---

## Color System

Defined in `AppColor`:

| Constant | Hex | Usage |
|----------|-----|-------|
| `prime1` | `#00BBFF` | Accent, gradients |
| `prime2` | `#0095FF` | Primary, headers |
| `prime3` | `#6214FF` | Secondary, gradient endpoints |
| `background` | `#EFEFEF` | Screen backgrounds |

---

## Key Architectural Decisions

1. **GetX over Provider/Bloc** - Chosen for simplicity: combines state management, dependency injection, and navigation in one package.

2. **Stateless views** - All screens are `StatelessWidget`s. State lives exclusively in controllers, making views pure rendering functions.

3. **Map-based data** - Firestore documents are consumed as `Map<String, dynamic>` rather than strongly-typed models, trading type safety for development speed.

4. **UPI-only payments** - Targets the Indian market where UPI is the dominant mobile payment method.

5. **Location-based Firestore structure** - Salons are organized by state/city in Firestore, enabling location-scoped queries without complex geospatial indexing.
