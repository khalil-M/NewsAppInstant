# NewsAppInstant


NewsAppInstant is a simple project designed to display a list of articles along with their details.

## Development Environment

This project was developed using Xcode version 15.0.1


## Features

### List of News (1st Screen)
Clean Architecture: The use of clean architecture ensures separation of concerns, making your codebase modular and easier to maintain. It typically involves organizing your code into layers such as Presentation, Domain, and Data layers.
Dependency Injection by Constructor: This is a clean and effective way to provide dependencies to your components. Constructor injection promotes loose coupling between components, making it easier to replace or mock dependencies during testing.
### Detail of Selected News (2nd Screen)
The second screen displays detailed information about a selected news item. This could involve navigating to a new view controller or presenting a modal view with the detailed information.
The details view might also utilize Diffable DataSource for efficiently updating its UI if there are dynamic elements or updates to the detailed information.


### Navigation Using a Router

The project also employs a router for navigation to the details screen. This architectural pattern offers several advantages:

- **Separation of Concerns**: Using a router separates the navigation logic from your view controllers, promoting cleaner and more maintainable code. It helps you avoid tightly coupling your view controllers with navigation code.

- **Reusability**: Routers can be reused across different parts of your app, making it easy to maintain consistent navigation behavior.

- **Testability**: Navigation logic becomes easier to test independently when isolated within a router.

### Composition Root

NewsAppInstant
 includes a composition root, which is responsible for setting up and configuring the application's dependencies. This architectural pattern provides the following benefits:

- **Dependency Injection**: The composition root facilitates dependency injection, allowing you to inject dependencies into your view controllers and other components. This promotes testability and decouples your code.

- **Centralized Configuration**: By centralizing dependency configuration in the composition root, you can easily manage and update dependencies across your app.

## Installation

To run this project on your local machine, follow these steps:

1. Clone the repository to your local machine:

   ```bash
   git clone https://github.com/your-username/NewsAppInstant
.git

2. Replace the API Key:
Locate int the compositionRoot where the API key is being used.

