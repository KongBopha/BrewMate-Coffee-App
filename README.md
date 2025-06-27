# ☕ BrewMate Coffee App

BrewMate is a Flutter-based mobile app that lets users order coffee from stores with delivery service. The app supports Firebase integration for authentication, real-time data handling, and future scalability.

---

## ✅ Current Features

- 🔐 **Firebase Authentication** (Email/Password, Google)
- ☕ **Product Listing** from Firebase Firestore
- 🛒 **Add to Cart** functionality
- 📋 **Checkout Flow** (UI-level for now)
- 🎯 **Filter by Coffee Category** (espresso,latte, macchiato)
- 📦 **Order History UI** (ready for data connection)
- 🔔 **Firebase Push Notifications** *(planned)*

---

## 🛠 Tech Stack

| Layer         | Technology                          |
|---------------|------------------------------------ |
| Frontend      | Flutter, Dart                       |
| Backend       | Firebase (Firestore, Auth, Storage) |
| Auth          | Firebase Authentication             |
| State Mgmt    | Provider  |
| Notifications | Firebase Cloud Messaging *(soon)*   |

---

## 📂 Directory Structure (Flutter Side)
lib/
├── models/ # Data models (e.g., Product, CartItem)
├── screens/ # UI Screens (Home, Login, Cart, etc.)
├── widgets/ # Reusable UI components
├── services/ # Firebase integration (auth, data)
├── utils/ # Helpers, constants, themes
└── main.dart # App entry point

---

## 🔌 Firebase Setup

This app uses:
- **Firebase Authentication** for secure login
- **Firestore** to store and retrieve coffee product data
- **Firebase Storage** for product images (if any)
- *(Optionally)* **FCM** for push notifications

> Ensure your Firebase project is correctly connected via `google-services.json` (Android) and `GoogleService-Info.plist` (iOS).

---

## 📦 Installation

1. **Clone the repository:**

```bash
git clone https://github.com/yourusername/brewmate_coffee_app.git
cd brewmate_coffee_app

Install dependencies:

bash
Copy
Edit
flutter pub get
Run the app:

bash
Copy
Edit
flutter run
Ensure you have Firebase set up via the Firebase Console and have added necessary platform files.

🧪 Coming Soon
💳 In-App Payments (Stripe or PayWay)

📍 Google Maps Integration for shop and delivery

🔔 Push Notifications with FCM

🧾 Admin Panel (Web-based for managing orders and products)

📱 App Store / Play Store Deployment

👩‍💻 Developer
Kong Bopha – Flutter Developer & Project Lead
Kim  Chamraoen  - Flutter Developer & Members
Lach Theary  - Flutter Developer & Members

📃 License
MIT License. You’re welcome to use, modify, and contribute.

🌟 Inspiration
Inspired by modern digital café systems, BrewMate seeks to bring coffee closer to people through a seamless mobile ordering experience.

python
Copy
Edit

---

Let me know if you'd like me to:
- Include Firebase Firestore rules
- Add a `.env` setup guide (for secrets)
- Include screenshots/GIFs in the README

I'm happy to help you take it further!
