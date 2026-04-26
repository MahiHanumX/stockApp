This is a Flutter-based stock watchlist application designed with a focus on performance, clean structure, and a smooth user experience. The app uses the BLoC pattern along with Clean Architecture to keep everything organized and scalable.

1 What the App Does
You can create and manage a list of stocks in a simple and clean interface.
There’s an edit mode where you can reorder stocks using drag-and-drop or remove them easily.
Stock prices show basic movement indicators (up/down), making it easier to scan quickly.
The UI follows a glassmorphism style with smooth transitions and blur effects to give it a modern feel.
All state changes are handled using BLoC, so the app behaves predictably and is easier to maintain.
2 Project Structure

The project is organized using Clean Architecture principles, so each layer has a clear responsibility:

lib/
├── core/               # Common utilities, themes, constants
├── features/
│   └── watchlist/
│       ├── data/       # Data sources and repository implementations
│       ├── domain/     # Business logic (entities, repository contracts)
│       └── presentation/
│           ├── bloc/   # BLoC (events, states, logic)
│           ├── page/   # Screens (watchlist, edit page)
│           └── widget/ # Reusable UI components
├── model/              # Data models
└── main.dart           # Entry point
3 Tech Stack
Flutter for building the UI
flutter_bloc for state management
Custom UI components for the design
