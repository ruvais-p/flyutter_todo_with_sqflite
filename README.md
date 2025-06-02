# 📝 Flutter ToDo App

A simple, lightweight ToDo app built with Flutter and powered by a local SQLite database using the `sqflite` package. This app allows users to add, mark, and delete tasks. Data is stored locally and persists between sessions.

## ✨ Features

* Add new tasks via a dialog
* Mark tasks as completed using a checkbox
* Delete tasks with a long press
* Local persistence using SQLite (`sqflite` package)

## 📱 Screenshots

| Home Page                                                   | Add Task Dialog                                                     |
| ----------------------------------------------------------- | ------------------------------------------------------------------- |
| ![Home](https://via.placeholder.com/200x400?text=Home+Page) | ![Dialog](https://via.placeholder.com/200x400?text=Add+Task+Dialog) |

*(Replace with real screenshots if needed)*

## 📁 Project Structure

```
lib/
├── main.dart
├── models/
│   └── task.dart
├── servieces/
│   └── database_serviece.dart
└── homepage.dart
```

## 🧠 Data Model

The app uses a `Task` model with the following fields:

```dart
class Task {
  final int id;
  final String content;
  final int status; // 0 = Incomplete, 1 = Complete
}
```

## 🛠 Technologies Used

* **Flutter**
* **SQLite** via `sqflite`
* **Path Provider** via `path`

## 🔧 How It Works

* `DatabaseService` handles all database interactions.
* On app start, tasks are loaded from the database.
* Adding a task inserts a new row in the SQLite database.
* Marking a task complete/incomplete updates the `status` field.
* Long-pressing a task deletes it from the database.

## 🚀 Getting Started

### Prerequisites

* Flutter SDK installed
* An emulator or physical device

### Installation

1. Clone the repository:

```bash
git clone https://github.com/yourusername/flutter-todo-app.git
cd flutter-todo-app
```

2. Get dependencies:

```bash
flutter pub get
```

3. Run the app:

```bash
flutter run
```

## 📦 Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  sqflite: ^2.3.0
  path: ^1.8.3
```

## ✅ To-Do (for improvement)

* Add task due dates
* Categorize tasks
* Add task editing
* Implement notification reminders


---

Let me know if you'd like a version of this with actual GitHub markdown badges, or want to include the model class `task.dart` as well.
