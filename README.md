# NewsAppInstant


NewsAppInstant is a simple project designed to display a list of articles along with their details.

## Development Environment

This project was developed using Xcode version 15.0.1

## Architecture
Clean Architecture: The use of clean architecture ensures separation of concerns
Dependency Injection by Constructor: This is a clean and effective way to provide dependencies to your components. Constructor injection promotes loose coupling between components, making it easier to replace or mock dependencies during testing.
MVVM: Dedicated for the presentation layer


## Features

### List of News (1st Screen)
The first screen is showing list of news from remote API

### Detail of Selected News (2nd Screen)
The second screen displays detailed information about a selected news item. 


### Navigation Using a Router

The project also employs a router for navigation to the details screen.

- **Separation of Concerns**: Using a router separates the navigation logic from your view controllers, promoting cleaner and more maintainable code. It helps you avoid tightly coupling your view controllers with navigation code.

- **Reusability**: Routers can be reused across different parts of your app, making it easy to maintain consistent navigation behavior.

- **Testability**: Navigation logic becomes easier to test independently when isolated within a router.

### Composition Root

NewsAppInstant
 includes a composition root, which is responsible for setting up and configuring the application's dependencies. This architectural pattern provides the following benefits:

- **Dependency Injection**: The composition root facilitates dependency injection, allowing you to inject dependencies into your view controllers and other components. This promotes testability and decouples your code.

- **Centralized Configuration**: By centralizing dependency configuration in the composition root, you can easily manage and update dependencies across your app.

- ## Caching images

The project features `OnDiskImageCaching` for efficient image caching. This caching mechanism optimizes performance by storing images locally. If an image is already downloaded, it won't be re-fetched.

## Installation

To run this project on your local machine, follow these steps:

1. Clone the repository to your local machine:

```
git clone https://github.com/khalil-M/NewsAppInstant.git
```
2. Update API Key
Open the composition root and locate the apiKey variable. Replace its value with your actual API key.




