# Harber - Mermaid Diagrams

Visual diagrams of the Harber salon booking app architecture and flows.

---

## App Navigation Flow

```mermaid
flowchart TD
    A[App Launch] --> B[SplashScreen]
    B --> C{User Authenticated?}
    C -->|Yes| D[MyHomeScreen]
    C -->|No| E[SlideScreen]
    E -->|Next x3| F[SignUpScreen]
    E -->|Skip| G[LogInScreen]
    F <-->|Switch| G
    F -->|Success| D
    G -->|Success| D
    D -->|Tap Salon| H[BookingScreen]
    H -->|Continue| I[PaymentScreen]
    I -->|Payment Success| D
```

---

## Authentication Flow

```mermaid
sequenceDiagram
    participant U as User
    participant App as Flutter App
    participant Auth as Firebase Auth
    participant DB as Cloud Firestore

    U->>App: Open App
    App->>Auth: Check currentUser
    alt User exists
        Auth-->>App: User object
        App->>U: Show HomeScreen
    else No user
        Auth-->>App: null
        App->>U: Show SlideScreen

        alt Sign Up
            U->>App: Enter name, email, password
            App->>Auth: createUserWithEmailAndPassword()
            Auth-->>App: UserCredential
            App->>DB: Set users/{email} document
            DB-->>App: Success
            App->>U: Show HomeScreen
        else Log In
            U->>App: Enter email, password
            App->>Auth: signInWithEmailAndPassword()
            Auth-->>App: UserCredential
            App->>U: Show HomeScreen
        end
    end
```

---

## Booking Flow

```mermaid
sequenceDiagram
    participant U as User
    participant Home as HomeScreen
    participant Book as BookingScreen
    participant Pay as PaymentScreen
    participant UPI as UPI India
    participant DB as Cloud Firestore

    Home->>DB: Load salons/{state}/{city}
    DB-->>Home: Salon list
    Home->>U: Display salon cards

    U->>Home: Tap salon card
    Home->>Book: Navigate with salon data

    U->>Book: Select date
    U->>Book: Select time slot
    Book->>U: Show confirmation bottom sheet

    U->>Book: Tap Continue
    Book->>Pay: Navigate with booking details

    U->>Pay: Select service
    U->>Pay: Select UPI app
    Pay->>UPI: startTransaction()
    UPI-->>Pay: Transaction response

    Pay->>DB: Write to users/{email}/booking/{timestamp}
    DB-->>Pay: Success
    Pay->>U: Lottie success animation
    Pay->>Home: Navigate (clear stack)
```

---

## State Management Architecture

```mermaid
classDiagram
    class GetxController {
        <<abstract>>
        +onInit()
        +onClose()
    }

    class SlideController {
        +slideCount: RxInt
    }

    class SignUpController {
        +name: TextEditingController
        +email: TextEditingController
        +pass: TextEditingController
        +passwordVisible: RxBool
        +isPress: RxBool
    }

    class LogInController {
        +email: TextEditingController
        +pass: TextEditingController
        +passwordVisible: RxBool
        +isPress: RxBool
    }

    class HomeController {
        +search: TextEditingController
        +salons: RxList
        +storeList: RxList
        +userName: RxString
        +upcomingList: RxList
        +loadData()
        +searchSalon(String)
        +loadUpcoming()
    }

    class BookingController {
        +name: RxString
        +loc: RxString
        +rate: RxDouble
        +date: Rx~DateTime~
        +time: List~Text~
        +isSelected: RxList~bool~
        +itemSelected(int)
    }

    class PaymentController {
        +name: RxString
        +loc: RxString
        +time: RxString
        +date: Rx~DateTime~
        +apps: RxList~UpiApp~
        +services: List
        +service: RxInt
        +prices: List~double~
        +payment: RxBool
    }

    GetxController <|-- SlideController
    GetxController <|-- SignUpController
    GetxController <|-- LogInController
    GetxController <|-- HomeController
    GetxController <|-- BookingController
    GetxController <|-- PaymentController
```

---

## Screen-Controller Relationships

```mermaid
graph LR
    subgraph Views
        A[SlideScreen]
        B[SignUpScreen]
        C[LogInScreen]
        D[MyHomeScreen]
        E[BookingScreen]
        F[PaymentScreen]
    end

    subgraph Controllers
        G[SlideController]
        H[SignUpController]
        I[LogInController]
        J[HomeController]
        K[BookingController]
        L[PaymentController]
    end

    subgraph Firebase
        M[(Firebase Auth)]
        N[(Cloud Firestore)]
        O[(Firebase Storage)]
    end

    subgraph Payment
        P[UPI India]
    end

    A --- G
    B --- H
    C --- I
    D --- J
    E --- K
    F --- L

    H --> M
    H --> N
    I --> M
    J --> N
    L --> N
    L --> P
```

---

## Firestore Data Model

```mermaid
erDiagram
    SALONS {
        string state "e.g. tamil_nadu"
    }
    CITY {
        string city "e.g. vellore"
    }
    SALON {
        string name "Salon name"
        string image "Image URL"
        string loc "Address"
        double rate "Rating 0-5"
    }
    USERS {
        string name "Full name"
        string email "Email address"
        string uid "Firebase Auth UID"
    }
    BOOKING {
        string name "Salon name"
        string loc "Location"
        timestamp date "Booking date"
        string time "Time slot"
        string service "Service type"
    }

    SALONS ||--o{ CITY : "contains"
    CITY ||--o{ SALON : "lists"
    USERS ||--o{ BOOKING : "has"
```

---

## User Journey

```mermaid
journey
    title User Booking Journey
    section Onboarding
        View intro slides: 3: User
        Sign up or log in: 4: User
    section Discovery
        Browse salon list: 4: User
        Search for salon: 3: User
        View salon details: 4: User
    section Booking
        Select date: 5: User
        Choose time slot: 5: User
        Confirm booking: 4: User
    section Payment
        Pick service type: 5: User
        Select UPI app: 3: User
        Complete payment: 4: User
        See confirmation: 5: User
    section Post-Booking
        View upcoming appointments: 5: User
```

---

## Component Architecture

```mermaid
graph TD
    subgraph Entry
        main[main.dart] --> splash[SplashScreen]
    end

    subgraph Theming
        colors[AppColor]
    end

    subgraph Onboarding
        slide[SlideScreen] --- slidec[SlideController]
    end

    subgraph Auth
        signup[SignUpScreen] --- signupc[SignUpController]
        login[LogInScreen] --- loginc[LogInController]
    end

    subgraph Core
        home[MyHomeScreen] --- homec[HomeController]
        booking[BookingScreen] --- bookingc[BookingController]
        payment[PaymentScreen] --- paymentc[PaymentController]
    end

    subgraph Models
        salon[Salon Class]
    end

    splash --> slide
    splash --> home
    slide --> signup
    slide --> login
    signup --> home
    login --> home
    home --> booking
    booking --> payment
    payment --> home

    colors -.-> signup
    colors -.-> login
    colors -.-> home
    colors -.-> booking
    colors -.-> payment
```

---

## Deployment Architecture

```mermaid
graph TB
    subgraph Client
        android[Android App]
        ios[iOS App]
    end

    subgraph Firebase
        auth[Firebase Auth]
        firestore[Cloud Firestore]
        storage[Firebase Storage]
    end

    subgraph Payment Gateway
        upi[UPI India SDK]
        apps[Google Pay / PhonePe / Paytm]
    end

    android --> auth
    android --> firestore
    android --> storage
    android --> upi
    ios --> auth
    ios --> firestore
    ios --> storage
    ios --> upi
    upi --> apps
```

---

> **Note:** To render these diagrams, use any Mermaid-compatible viewer such as GitHub's built-in Markdown renderer, [mermaid.live](https://mermaid.live), or VS Code with the Mermaid extension.
