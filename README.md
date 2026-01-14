# 💊 Medicine Reminder App

A **Flutter-based mobile application** that helps users schedule and manage their medicines efficiently. The app sends notifications to remind users to take their medications on time, ensuring better health management.

---

## 📌 Features

- Add medicines with **name, dose, and scheduled time**.
- Get **push notifications** when it’s time to take your medicine.
- View all medicines in a **clean, professional list**.
- Delete medicines once taken.
- Easy-to-use UI with **Teal and Orange color theme**.

---

## 📱 Screenshots

**Home Screen:**  
![Home Screen](assets/images/home_screen.png)

**Add Medicine Screen:**  
![Add Medicine Screen](assets/images/add_medicine_screen.png)

*Replace with actual screenshots from your project.*

---

## ⚙️ Technology Stack

- **Framework:** Flutter  
- **Language:** Dart  
- **State Management:** Provider  
- **Local Storage:** Hive / SQLite / Shared Preferences  
- **Notifications:** Local Notifications via `flutter_local_notifications`  
- **Platform Support:** Android, iOS  

---

## 🚀 Installation & Setup

1. **Clone the repository:**
   ```bash
   git clone https://github.com/bondrepranjali977-ops/Medicine-Reminder-Application.git

2.Navigate into the project folder:
cd medicine_reminder

3.Get dependencies:
flutter pub get

4.Run the app:
flutter run

5.(Optional) Build APK for Android:
flutter build apk --release

🧩 Folder Structure
medicine_reminder/
│
├── lib/
│   ├── controller/          # Provider controllers for state management
│   ├── models/              # Dart models (Medicine.dart)
│   ├── services/            # Notification and other services
│   ├── utils/               # Colors, constants, helpers
│   └── view/                # Screens (HomeView, AddMedicineView)
│
├── assets/                  # Images, icons, etc.
├── pubspec.yaml             # Flutter dependencies
└── README.md

💻 Usage

Open the Home Screen to see all medicines.

Click the + button to add a new medicine.

Enter the Medicine Name, Dose, and Time.

Click Save. A notification will be scheduled at the selected time.

Delete medicines by clicking the trash icon when taken.

🎨 UI & Theme

Primary Color: Teal

Accent Color: Orange

Modern, minimal, and professional design.

Designed for easy usability and accessibility.

📌 Contribution

Fork the repository.

Create a new branch: git checkout -b feature-name

Make your changes and commit: git commit -m "Add feature"

Push to your branch: git push origin feature-name

Open a Pull Request.

✍️ Author

Pranjali Bondre

GitHub: bondrepranjali977-ops

