# Bonify React Native Application Architecture Document

**Version:** [Document Version - e.g., v2.0, Last Updated: 2025-02-26]

**Table of Contents**
[Automatically generate table of contents if possible, or manually list main headings]

1. [Introduction](#1-introduction)
   - [Document Purpose](#11-document-purpose)
   - [Target Audience](#12-target-audience)
   - [Scope](#13-scope)
2. [High-Level Architecture Overview](#2-high-level-architecture-overview)
   - [Architectural Pattern](#21-architectural-pattern)
   - [Main Layers/Modules](#22-main-layersmodules)
3. [Data Flow](#3-data-flow)
   - [Overall Data Flow](#31-overall-data-flow)
   - [State Management](#32-state-management)
   - [API Communication](#33-api-communication)
4. [Navigation](#4-navigation)
   - [Navigation Library](#41-navigation-library)
   - [Navigation Structure](#42-navigation-structure)
   - [Route Management](#43-route-management)
5. [Component Architecture](#5-component-architecture)
   - [Component Types](#51-component-types)
   - [Component Library/System](#52-component-librarysystem)
   - [Styling Approach](#53-styling-approach)
6. [Key Technical Decisions](#6-key-technical-decisions)
   - [Technology Choices](#61-technology-choices)
   - [Performance Optimizations](#62-performance-optimizations)
   - [Security Considerations](#63-security-considerations)
   - [Scalability and Maintainability](#64-scalability-and-maintainability)
7. [Deployment Architecture](#7-deployment-architecture)
   - [Deployment Environments](#71-deployment-environments)
   - [Build and Deployment Process](#72-build-and-deployment-process)
8. [Related Documents](#related-documents)
9. [Author & Date](#author--date)

---

## 1. Introduction

- **1.1. Document Purpose:** <a id="11-document-purpose"></a>
  This document provides a comprehensive overview of the Bonify React Native application’s architecture. Its main purpose is to:
  - Serve as a reference for new developers and team members.
  - Capture important design decisions and rationale behind the chosen architecture.
  - Ensure consistent and maintainable development practices across the team.
- **1.2. Target Audience:** <a id="12-target-audience"></a>
  This document is primarily aimed at:
  - React Native Developers who will implement features and maintain the codebase.
  - Tech Leads & Software Architects who want to understand the system’s structure and make informed decisions about further enhancements.
  - QA Engineers who need insights into the application flow and data handling to design test strategies.
- **1.3. Scope:** <a id="13-scope"></a>
  This document focuses on the frontend architecture of the Bonify React Native application, including:
  - Directory structure and how it reflects our chosen architectural pattern.
  - Data flow (state management, API interactions, domain logic).
  - Navigation strategy and screen organization.
  - Key technical decisions and best practices for scalability, security, and maintainability.
    It does not cover backend architecture or DevOps details beyond the basic deployment and environment configuration references.

## 2. High-Level Architecture Overview

- **2.1. Architectural Pattern:**
  The Bonify React Native application adopts a modular and layered architecture inspired by Clean Architecture principles. Key elements include:

  - Separation of Concerns: Dividing the application into distinct layers (Presentation, Domain, Data) ensures each layer has a clear responsibility.
  - Unidirectional Data Flow: Data moves in a predictable, one-way flow, simplifying debugging and maintenance.
  - Feature-Based Structure: Within the src/ directory, features are grouped in a way that promotes encapsulation and reusability.

  Why this pattern?

  - Facilitates scalability by allowing features to grow independently.
  - Improves testability since business logic (domain) is decoupled from UI (presentation).
  - Encourages clean separation between data handling, domain logic, and presentation.

  Below is a simplified diagram of our layers:

  ```bash
  [ Presentation Layer ] --> [ Domain Layer ] --> [ Data Layer ]
           |                     |                   |
        (UI/UX)              (Use Cases)       (Repositories, APIs)
  ```

- **2.2. Main Layers/Modules:**

  - **1.Presentation Layer (`src/app`, `src/navigation`, and each feature’s presentation subfolder (e.g., `src/features/auth/presentation`)):**

    - Contains React Native screens, UI components, and navigation setup.
    - Handles user interactions, form validations, and dispatches actions or calls domain logic.
    - May include container components that integrate with state management (e.g., Redux) and domain logic.

  - **2.Domain Layer (`src/core/domain` (if global) or each feature’s domain subfolder (e.g., `src/features/auth/domain`)):**

    - Holds core business logic, use cases, and entities/models that define the domain.
    - Minimizes dependencies on external frameworks to maintain testability and independence.
    - Acts as the “brain” of the application, focusing on how data is processed and validated.

  - **3.Data Layer (`src/core/data` (if global) or each feature’s data subfolder (e.g., `src/features/auth/data`)):**

    - Manages API communication, repositories, and data sources (e.g., local storage, AsyncStorage).
    - Implements network requests, data caching, and transformations from external APIs into domain-friendly models.
    - Often includes service classes or functions (apiService.ts, etc.) to abstract direct HTTP calls.

  - **4.Device Layer (`src/device`):**

    - Integrates with native modules or device-specific functionalities (e.g., camera, push notifications).
    - Abstracts low-level platform-specific APIs behind a clean interface for the rest of the app.

  - **5.Device Layer (`src/shared`):**

    - Contains shared assets, utilities, hooks, constants, styles, models, and reusable components.
    - Promotes consistency across features and prevents code duplication.
    - Examples include UI library components, theme definitions, localization utilities, and more.

  - **6.Test (`__tests__`(root-level) plus each feature’s own **tests** folder (e.g., `src/features/example/__test__`)) :**\
    - Centralized location for unit tests, integration tests, and end-to-end tests.
    - Each feature or layer can have corresponding test files to ensure comprehensive coverage.

## 3. Data Flow

- **3.1. Overall Data Flow:**
  - User Interaction: A user triggers an action (e.g., tapping a button on a screen).
  - Presentation Layer: The screen or container component processes the event, optionally dispatching an action or calling a use case in the Domain layer.
  - Domain Layer: Use cases handle the business logic, possibly requesting data from the Data layer or updating local state.
  - Data Layer: Fetches or updates data from the backend API or local storage, then returns it to the Domain layer.
  - Back to Presentation: The updated data flows back to the Presentation layer to render changes on the UI.
    A unidirectional flow ensures each data path is explicit and easier to track.
- **3.2. State Management:**
  We use `Redux Toolkit` as our primary solution for state management, offering a robust, centralized store with predictable state updates and advanced debugging via the Redux DevTools. In addition, we incorporate Realm for local data storage and offline capabilities.

  - **Why `Redux Toolkit`**?
    - Reduced Boilerplate: Compared to classic `Redux`, `Redux Toolkit` simplifies the creation of actions, reducers, and async logic.
    - Built-In Best Practices: Provides preconfigured features like `createSlice` and `createAsyncThunk` for cleaner, more maintainable code.
    - Scalability: Suited for complex state needs, with strong community support and ecosystem.
    - Testability: The unidirectional data flow is straightforward to test, ensuring reliable feature development.
  - **Why `Realm`**?
    - Offline Support & Local Persistence: Ideal for applications that require advanced offline functionality or large-scale local data management.
    - High Performance: Efficient queries and data handling, which can outperform simpler solutions like AsyncStorage or SQLite in certain use cases.
    - Real-Time Sync & Encryption: Offers real-time data synchronization options (if configured) and secure data storage with encryption.
    - Automatic Migrations: Simplifies schema updates without forcing major code refactors.
  - **Data Persistence & State Rehydration**
    - **`Persistence`**:
      - We use `Realm` for more complex local data storage and offline capabilities, storing domain objects and managing larger datasets.
      - For Redux state slices or user preferences that need quick read/write operations, we use `react-native-mmkv`. This offers minimal overhead and extremely fast performance compared to traditional `AsyncStorage`.
    - **`Rehydration`**:
      - On app launch, the application retrieves necessary data from Realm to repopulate the `Redux store`. This ensures users can continue where they left off without manual data entry or network calls.
      - Meanwhile, more complex domain data and offline records remain in Realm, ready to be loaded on-demand. This approach balances speed for frequently accessed state with robust offline capabilities for larger data sets.

  By combining Redux Toolkit for global state management with Realm for local storage, the Bonify React Native application achieves a scalable, high-performance approach that supports both real-time interactions and offline capabilities.

- **3.3. API Communication:**
  - **API Client Library**: We primarily use `Axios` for HTTP requests due to its simplicity and powerful features.
  - **Error Handling**: Centralized error interception in `Axios interceptors`. Errors are normalized and passed back to the domain layer for proper UI handling.
  - **Data Transformation**: Responses are transformed or validated in the Data layer to ensure the Domain layer receives consistent data structures.

## 4. Navigation

- **4.1. Navigation Library:**
  The application uses React Navigation for screen-to-screen navigation:
  - **Why React Navigation?**
    - Industry-standard for React Native.
    - Well-documented, robust, and flexible.
    - Supports nested navigators, deep linking, and advanced patterns.
- **4.2. Navigation Structure:**
  - **Stack Navigator**: For the primary navigation flow, handling screen transitions (push/pop).
  - **Bottom Tab Navigator**: For main sections of the app that require quick switching (e.g., Home, Profile, Settings).
  - **Drawer Navigator (optional)**: For additional menus or user settings if needed.
- **4.3. Route Management:**

  - **Route Definitions**: Centralized in src/navigation/RouteNames.ts or similar, storing string constants for each screen route.
  - **Passing Parameters**: Via React Navigation’s parameter props (navigation.navigate('ScreenName', { paramKey })).

  ```Typescript
    navigation.navigate('ScreenName', { paramKey: value });
  ```

  - **Navigation State**: Managed internally by React Navigation; screens can access navigation props for advanced patterns (e.g., resetting navigation stack, nested navigation flows).
  - **Navigation Service**: To facilitate common navigation operations throughout the app, we have implemented a NavigationService located in src/app/service. This service provides utility methods for actions such as navigating between screens, resetting the navigation stack, and accessing the navigation state from non-component modules.
    Example usage:

  ```Typescript
    // Example call from anywhere in the app
    NavigationService.navigate('ScreenName', { paramKey: value });
  ```

## 5. Component Architecture

- **5.1. Component Types:**
  - **1. Presentational Components (UI/Dumb Components):**
    - Found in src/shared/components or within feature folders.
    - Receive data via props, focus on rendering UI.
    - No direct business logic or state management beyond local UI state (e.g., toggling a dropdown).
  - **2. Container Components (Smart Components)**:
    - Located in src/features/<FeatureName> or src/app/ screens.
    - Connect to the Domain layer or global state management (Redux).
    - Orchestrate data fetching, handle side effects, and pass data to Presentational Components.
  - **3. Screen Components**:
    - Typically in `src/features/<FeatureName>/screens/`
    - Represent major app screens. Often combine multiple presentational and container components.
    - Responsible for user flows, hooking into navigation.
  - **4. Custom Hooks**:
    - In `src/shared/hooks` or within each feature folder (`src/features/<FeatureName>/hooks`).
    - Encapsulate reusable logic or side effects, enabling more readable components.
- **5.2. Component Library/System (If any):**
  We maintain a small, internal UI library in `src/shared/components`:
  - **Purpose**: Ensure a consistent look-and-feel across the app and reduce code duplication.
  - **Examples**: Reusable buttons, input fields, modals, typography components.
  - **Guidelines**: Each component has clear props, well-documented usage, and follows a unified design language.
- **5.3. Styling Approach:**
  - **Styling Method**: The application primarily uses React Native `StyleSheet` to define component styles. This approach is chosen for its performance benefits and native compatibility with React Native.
  - **Animation & Interactivity**: For smooth and complex animations, we leverage `React Native Reanimated`. This library allows us to create native-driven animations that are both performant and visually appealing.
  - **Theming**: A global theme object is defined in src/shared/styles (or src/shared/constants) that includes variables for colors, typography, and spacing. Components consume these theme variables to ensure a consistent look and feel throughout the application.
  - **Responsive Design**: Responsive layouts are achieved through a combination of dimension checks (using `Dimensions.get('window')`). This ensures that the application adapts smoothly to various device sizes and orientations.

## 6. Key Technical Decisions

- **6.1. Technology Choices:**

  - `TypeScript`:
    - Enhances code quality with static typing, reduces runtime errors, and improves developer productivity and maintainability.
    - **Alternatives Considered**: Plain JavaScript was an option but lacked the type safety and tooling benefits provided by TypeScript.
  - `Redux Toolkit (RTK)`:
    - Simplifies Redux development by reducing boilerplate, providing a standardized approach with features like createSlice and createAsyncThunk, and integrating well with RTK Query for data fetching.
    - **Alternatives Considered**: Traditional Redux and Context API were considered; however, RTK was chosen for its balance of simplicity, scalability, and robust tooling support.
  - `React Navigation`:
    - Offers a comprehensive navigation solution with support for various navigator types (Stack, Bottom Tab, Drawer) and deep linking, backed by a strong community.
    - **Alternatives Considered**: Other navigation libraries were assessed, but React Navigation provided the best combination of flexibility and ease-of-use.
  - `Axios`:
    - Chosen for its clean API, support for interceptors, and effective error handling mechanisms, making it ideal for managing HTTP requests.
    - **Alternatives Considered**: The native Fetch API was considered but Axios’s additional features such as request cancellation and automatic JSON parsing offered clear advantages.
  - `Internationalization`:
    - **Libraries**: react-i18next & react-native-localize
    - **Why**: They provide a flexible and well-supported solution for implementing multi-language support and localization across the application.
  - `Local Storage & State Hydration`:

    - [React Native MMKV](https://github.com/mrousavy/react-native-mmkv):
      - Offers high-performance key-value storage, enabling fast persistence and rehydration of Redux state and user preferences.
      - Alternatives Considered: AsyncStorage was evaluated but found to be significantly [Slower](https://blog.logrocket.com/using-react-native-mmkv-improve-app-performance/)
    - **Additional Storage**:
      - **`Realm`**: Utilized for managing more complex data sets and offline capabilities, particularly for domain-specific data that requires robust querying and synchronization.

  - `UI & Animations`:
    - **`React Native Reanimated`**: Enables highly performant, native-driven animations that run smoothly even under complex scenarios.
    - **``React Native Gesture Handler`**`: Provides reliable and smooth gesture handling, ensuring a seamless and interactive user experience.
  - `Code Quality & Testing`:
    - **`ESLint & Prettier`**: Enforce consistent coding styles and best practices, reducing potential bugs and improving code readability.
    - **`Jest & @testing-library/react-native`**: Ensure comprehensive test coverage with a focus on behavior and user-centric testing approaches.

- **6.2. Performance Optimizations:**
  - **`Lazy Loading & Code Splitting`**: Dynamically load feature modules to reduce the initial bundle size and improve startup time.
  - **`Memoization Techniques`**: Utilize React.memo and useMemo to avoid unnecessary re-renders and enhance performance.
  - **`List Virtualization`**: Implement components like `FlatList` and `SectionList` to efficiently render large datasets with minimal performance overhead.
  - **`Native Modules & Optimized Animations`**: Leverage libraries such as React Native Reanimated to offload intensive animations to the native thread, ensuring fluid and responsive UI interactions.
  - **`Optimized Image Loading`**: Employ image caching and optimization strategies to reduce memory usage and enhance rendering performance.
- **6.3. Security Considerations:**
  - **`Data Encryption & Secure Storage`**: Use high-performance storage solutions like react-native-mmkv and secure storage mechanisms (Keychain/Keystore) to protect sensitive data.
  - **`Input Validation & Sanitization`**: Validate and sanitize user inputs on both the client and server sides to prevent injection attacks and ensure data integrity.
- **6.4. Scalability and Maintainability:**
  - **Modular Architecture**: The codebase is organized into distinct layers (Presentation, Domain, Data, Device, Shared), facilitating separation of concerns and easier scalability as new features are added.
  - **Automated Testing**: Comprehensive unit, integration, and end-to-end tests help maintain code quality and prevent regressions during development.
  - **Adherence to Coding Standards**: Strict use of ESLint, Prettier, and code reviews ensures a consistent and maintainable codebase.
  - **Continuous Integration/Deployment (CI/CD)**: Automated pipelines for testing, building, and deployment ensure rapid and reliable releases, supporting ongoing scalability and maintainability.
  - **Community & Ecosystem Support**: Adoption of widely supported libraries and frameworks ensures access to ongoing updates, community expertise, and a rich ecosystem of plugins and tools.

## 7. Deployment Architecture

- **7.1. Deployment Environments:**
  - **Development**: Local environment, uses dev API endpoints and debug builds.
  - **Staging**: Internal testing environment, closely mirrors production settings but with a separate backend instance.
  - **Production**: Live environment used by end-users.
    Environment variables are managed through .env files or a secure configuration service. The app reads these to determine API endpoints and feature toggles.
- **7.2. Build and Deployment Process:**
  - **CI/CD**: We use a CI/CD pipeline (e.g., GitLab CI) that:
    - Runs tests, lint checks, and type checks.
    - Builds the app for iOS and Android.
    - Deploys artifacts to TestFlight, Google Play Internal Testing, or relevant distribution channels.
  - **Manual Steps**: Final promotion from staging to production typically requires manual approval to ensure stability.

---

**Related Documents:**

<!-- - [Link to DOCUMENT.md file](https://www.google.com/url?sa=E&source=gmail&q=DOCUMENT.md) -->

- [Link to coding-standards.md file](https://gitlab.com/arunchaudhary/bonifyreactnativeapp/-/blob/setup/configure-di-container/docs/coding-standards.md)
- [Link to commit-message-guidelines.md file](https://gitlab.com/arunchaudhary/bonifyreactnativeapp/-/blob/setup/configure-di-container/docs/commit-message-guidelines.md)
  <!-- - [Link to NAMING_CONVENTION.md file](https://www.google.com/url?sa=E&source=gmail&q=NAMING_CONVENTION.md) -->
  <!-- - [Link to CI/CD.md file (if any)](https://www.google.com/url?sa=E&source=gmail&q=CI/CD.md) -->
  <!-- - [Link to Backend API documentation (if any)](https://www.google.com/url?sa=E&source=gmail&q=API_DOCUMENTATION_LINK) -->
  ...

**Author:** [Kane/Engineering]

**Date Created:** [Feb-10-2025]
