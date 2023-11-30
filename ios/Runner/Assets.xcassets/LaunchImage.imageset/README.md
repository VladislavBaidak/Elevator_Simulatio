# Elevator Simulation App Documentation

## Overview

The Elevator Simulation App is a Flutter application designed to provide a simulated experience of elevator movement within a building. The app offers a user-friendly interface for interacting with building data, simulating elevator movement, and receiving notifications about the elevator's current position.

## Table of Contents

1. [Introduction](#introduction)
2. [Features](#features)
3. [Project Structure](#project-structure)
4. [Installation](#installation)
5. [Usage](#usage)
6. [Screens](#screens)
   - [First Screen](#first-screen)
   - [Second Screen](#second-screen)
   - [Floor Screen](#floor-screen)
7. [Database Operations](#database-operations)
8. [Local Notifications](#local-notifications)
9. [Elevator Simulation](#elevator-simulation)
   - [Elevator Logic](#elevator-logic)
   - [Random Floor Stack](#random-floor-stack)
   - [Notification Sending](#notification-sending)
10. [Contributing](#contributing)
11. [License](#license)

## Introduction

The Elevator Simulation App serves as a demonstration of elevator functionality within a building context. It leverages Flutter for creating an intuitive user interface, SQLite for managing building data, and local notifications to enhance user experience.

## Features

- **Building Management:** Users can add buildings with customizable names and floor counts.
- **Elevator Simulation:** The app simulates elevator movement, visually highlighting the current floor.
- **Local Notifications:** Notifications are sent to users, providing real-time feedback on the elevator's position.

## Project Structure

The project is structured into multiple Dart files, each serving a specific purpose:

- **building.dart:** Defines the `Building` class, encapsulating the structure of a building with an id, name, and floors.
- **buildingdetialscreen.dart:** Implements the `FloorScreen` widget, responsible for simulating elevator movement and floor visualization.
- **database_helper.dart:** Manages SQLite database operations related to building data, including database initialization, building insertion, and loading building data.
- **second_screen.dart:** Displays a list of buildings, enables users to add new buildings, and facilitates navigation to the `FloorScreen`.
- **home_screen.dart:** Represents the initial screen with a welcome message, an image, and a button to navigate to the second screen.
- **main.dart:** Serves as the entry point for the Flutter application.

## Installation

1. **Clone the repository:**

```bash
git clone https://github.com/your-username/elevator_simulation_app.git
```

2. **Navigate to the project directory:**

```bash
cd elevator_simulation_app
```

3. **Install dependencies:**

```bash
flutter pub get
```

## Usage

Run the app using the following command:

```bash
flutter run
```

## Screens

### First Screen

The initial screen of the app provides a welcoming interface featuring a greeting message, an image, and a button. This button allows users to navigate to the second screen.

### Second Screen

The second screen offers users the ability to view a list of buildings, add new buildings, and navigate to the `FloorScreen` for elevator simulation.

### Floor Screen

The `FloorScreen` widget serves as the core of the elevator simulation. It simulates elevator movement within a building, displaying a list of floors, visually highlighting the current floor, and sending notifications to enhance user engagement.

## Database Operations

The `BuildingDatabase` class, found in `database_helper.dart`, manages SQLite database operations for storing and retrieving building data. Key methods include database initialization, building insertion, and loading building data.

## Local Notifications

Local notifications are implemented using the `FlutterLocalNotificationsPlugin` in the `FloorScreen`. Notifications are triggered to inform users about the current floor of the simulated elevator, providing a seamless and informative user experience.

## Elevator Simulation

### Elevator Logic

The elevator simulation logic is implemented within the `FloorScreen` widget. It includes functionality for generating a random floor stack, orchestrating elevator movement, and managing the sending of notifications. The simulation begins automatically upon app launch and can be reset for a new cycle.

### Random Floor Stack

The `FloorScreen` widget generates a random floor stack using a combination of Dart's `Random` class and the building's floor count. This stack represents the sequence of floors the elevator will visit during the simulation.

### Notification Sending

Notifications are sent to the user using the `FlutterLocalNotificationsPlugin`. Notifications include details about the elevator's current position, enhancing the user's understanding of the simulation.

## Contributing

Contributions to the Elevator Simulation App are encouraged. Users encountering issues or with ideas for improvements can submit pull requests to contribute to the project's development.

## License

This project is licensed under the [MIT License](LICENSE).

Feel free to tailor this documentation to align with your project's unique details and requirements.
