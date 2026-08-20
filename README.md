# ConverterApp

A Flutter unit-conversion app built as a coursework project and cleaned up as a small example of stateful UI, input handling, and testable application logic.

## Features

- Length conversions between meters, kilometers, feet, and miles
- Mass conversions between grams, kilograms, pounds, and ounces
- Decimal, negative, and zero-value input support
- Validation for incompatible conversions such as meters to kilograms
- Conversion logic separated from the UI for unit testing

## Tech Stack

- Flutter
- Dart
- Material UI
- `flutter_test`

## Project Structure

```text
ConverterApp/
├── README.md
└── unit_converter/
    ├── lib/
    │   ├── conversion.dart
    │   └── main.dart
    ├── test/
    │   ├── conversion_test.dart
    │   └── widget_test.dart
    └── pubspec.yaml
```

## Run Locally

### Prerequisites

- Flutter SDK with Dart 3.7 or newer

Clone the repository and enter the Flutter project:

```bash
git clone https://github.com/knoxdevchris/ConverterApp.git
cd ConverterApp/unit_converter
```

Install dependencies:

```bash
flutter pub get
```

Run the app:

```bash
flutter run
```

## Quality Checks

Run static analysis:

```bash
flutter analyze
```

Run the test suite:

```bash
flutter test
```

The tests cover core conversion math and verify that the main converter controls render successfully.

## Example Conversions

| Input | From | To | Result |
| ---: | --- | --- | ---: |
| 1000 | grams | kilograms | 1 |
| 1 | miles | feet | 5280 |
| 1 | kilometers | meters | 1000 |
| 16 | ounces | pounds | 1 |
