# 🎄 Christmas Quiz: Winter Challenge 🎅

Welcome! This is my **Final Capstone Project** for the **INF229** course. 
I have developed a festive, high-performance mobile quiz application built with Flutter, focused on clean architecture, state management, and a smooth user experience.

## Project Overview
This application is more than just a simple quiz. It features a holiday-themed interface with falling snow animations, vibrant gradients, and a dynamic questioning system. Users can test their knowledge in three core areas:
1. **Mathematics** — A robust database of 100 questions ranging from basic arithmetic to algebra.
2. **English Language** — Testing grammar, vocabulary, and linguistic speed.
3. **Mobile Development** — Specialized questions about Flutter, Dart, and the mobile ecosystem.

## Tech Stack & Architecture
This project demonstrates proficiency in the following areas:
* **Flutter & Dart** — Cross-platform framework for high-quality UI.
* **Provider (State Management)** — Decoupled business logic from the UI for better scalability and testing.
* **Shared Preferences** — Persistent local storage to save User Profiles and High Scores.
* **Custom UI/UX** — Custom-coded animations (Snowfall effect), reusable widgets, and responsive layouts.

## Key Features
* **User Authentication:** A local verification system that personalizes the experience.
* **Randomized Quiz Engine:** The app pulls 10 random questions from a larger pool every session, ensuring high replayability.
* **Pressure Timer:** A built-in 15-second timer per question to challenge the user's reflexes.
* **Persistence:** Your name and personal record (High Score) are saved locally on the device.
* **Polished Transitions:** Smooth navigation and feedback when answers are selected.

## Project Structure
```text
lib/
├── data/            # local data 
├── models/          # Data Models 
├── providers/       # Logic & State 
├── screens/         # UI Screens (Login, Home, Quiz, Result, Profile)
├── widgets/         # Reusable Components (SnowWidget)
└── main.dart        # Application Entry Point

Setup & Installation
Ensure you have Flutter installed on your machine.
Clone this repository:
git clone [https://github.com/Ansxxs/Final_project_inf229.git](https://github.com/Ansxxs/Final_project_inf229.git)
Install dependencies:
flutter pub get
Run the application:
flutter run

Developer: Abylkanov Ansat
id:230103172

Developed as a Final Project for INF229.

Merry Christmas and Happy Coding! 
