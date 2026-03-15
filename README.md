# Digital Burnout Recovery Platform

A beautifully crafted Flutter application designed to combat digital fatigue and promote healthier screen habits. This app offers tools for tracking usage, running focused work sessions, and taking guided recovery breaks to ensure sustainable digital wellness.

## 📱 Features

- **Activity Insights**: Track your daily, weekly, and monthly screen time. Monitor burnout risk and view a detailed breakdown of your most distracting vs. most productive apps.
- **Focus Mode**: A dedicated timer for deep work sessions with a visual progress ring, motivational quotes, and the ability to temporarily restrict access to distracting apps.
- **Recovery Hub**: Guided digital reset sessions including:
  - 🌬️ **Breathing Exercises**: Animated breathing guides to help you center yourself.
  - 🧘 **Meditation Player**: A fully functional audio player for mindfulness sessions.
  - 👁️ **Eye Relaxation**: Reminders to follow the 20-20-20 rule.
  - 🚶 **Short Walks**: Prompts for physical movement to break up long screen streaks.
- **Profile & Progress**: A gamified experience featuring wellness trends, focus units, break streaks, and achievement badges to keep you motivated.
- **Dark & Light Mode**: Seamlessly adapts to your system preferences with a custom, polished design system (`AppTheme`).

## 🛠️ Tech Stack

- **Framework**: Flutter (Dart)
- **State Management**: Provider
- **Local Storage**: Shared Preferences
- **Charts**: fl_chart
- **Icons**: Cupertino Icons & Material Icons
- **Fonts**: Google Fonts (Inter)

## 🚀 Getting Started

### Prerequisites
- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- A configured IDE (VS Code, Android Studio, or IntelliJ)

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/digital_detox.git
   ```
2. Navigate to the project directory:
   ```bash
   cd digital_detox
   ```
3. Install dependencies:
   ```bash
   flutter pub get
   ```
4. Run the app:
   ```bash
   flutter run
   ```

## 🏗️ Project Architecture

```
lib/
├── main.dart               # Entry point and theme configuration
├── models/                 # Data classes (AppStats, FocusSession, etc.)
├── providers/              # State management logic
├── screens/                # UI screens (Dashboard, Focus Mode, etc.)
├── services/               # Core business logic (Storage, Burnout calculation)
├── utils/                  # Constants, Theme definitions, and Formatters
└── widgets/                # Reusable UI components (MetricCards, Charts, etc.)
```

## 📄 License
This project is open-source and available under the terms of the MIT License.
