# StudyAI 🚀

StudyAI is a powerful Flutter application designed to assist students and learners by providing instant, AI-driven answers to their study questions. Built with performance and simplicity in mind, it leverages the OpenRouter API to deliver intelligent responses.

## ✨ Features

- **AI Question Answering:** Get instant explanations and answers for any study-related query.
- **GetX State Management:** Fast and reactive UI updates for a smooth user experience.
- **Copy to Clipboard:** Easily copy AI responses to use in your notes.
- **Secure Configuration:** Uses `flutter_dotenv` to manage sensitive API keys safely.
- **Firebase Integration:** Ready for cloud-based features like data persistence.
- **Clean UI/UX:** Simple and intuitive interface for focused learning.

## 🛠️ Tech Stack

- **Framework:** [Flutter](https://flutter.dev/)
- **State Management:** [GetX](https://pub.dev/packages/get)
- **Networking:** [http](https://pub.dev/packages/http)
- **AI Backend:** [OpenRouter API](https://openrouter.ai/) (Cohere North Mini Code)
- **Database:** [Firebase Firestore](https://firebase.google.com/)
- **Environment Variables:** [flutter_dotenv](https://pub.dev/packages/flutter_dotenv)

## 🚀 Getting Started

Follow these steps to get the project up and running on your local machine.

### Prerequisites

- Flutter SDK (Latest Version)
- Android Studio / VS Code
- An OpenRouter API Key

### Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/your-username/study_ai.git
   cd study_ai
   ```

2. **Install dependencies:**
   ```bash
   flutter pub get
   ```

3. **Setup Environment Variables:**
   - Create a `.env` file in the root directory.
   - Add your OpenRouter API key:
     ```env
     OPENROUTER_API_KEY=your_api_key_here
     ```

4. **Firebase Setup:**
   - Create a project on the [Firebase Console](https://console.firebase.google.com/).
   - Download the `google-services.json` (for Android) and `GoogleService-Info.plist` (for iOS).
   - Place them in the respective directories (`android/app` and `ios/Runner`).

5. **Run the app:**
   ```bash
   flutter run
   ```

## 📂 Project Structure

```text
lib/
├── controller/     # Business logic & State management (GetX)
├── models/         # Data models
├── services/       # API and external service integrations
├── view/           # UI Screens and Widgets
└── main.dart       # Entry point of the app
```

## 📝 Commit Convention

This project follows the [Conventional Commits](https://www.conventionalcommits.org/) standard:
- `feat:` New features
- `fix:` Bug fixes
- `docs:` Documentation changes
- `style:` Formatting, missing semi colons, etc.

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---
Built with ❤️ for learners everywhere.
