<h1 align="center"> Rick&Morty (UIKit Version) </h1>



> ##### If you like this project, support it by "★ Star" in the repository. Thank you!

<p align="center">
<br>
SwiftyMarvel is a SwiftUI app that uses the Marvel API to display a list of Marvel characters and their details. You can browse through hundreds of heroes and villains from the Marvel universe, see their comics, and learn more about their powers and abilities.
 <br>
 <br>
This app is created as a personal project to showcase my skills and passion for iOS development. This app demonstrates how to implement Clean Architecture and some of best practices for iOS app development using SwiftUI, CoreData, Combine, MVVM, Dependency Injection, Unit Testing, Code Coverage, and more.
<br>
</p>

<!-- TOC -->

* [Screenshots](#screenshots)
* [Project Structure](#project-structure)
* [Folder Structure](#folder-structure)
* [Tools & Frameworks Used](#tools--frameworks-used)
* [Development Environment](#development-environment)

<!-- TOC -->

## How it looks

| Launch Screen | List | Search | Details |
| :-: | :-: | :-: | :-: |
| <img src="Settings/Assets/Launch.png"/> | <img src="Settings/Assets/Characters.png"/> | <img src="Settings/Assets/Search.png"/> | <img src="Settings/Assets/Details.png"/>

## Project Concept and Structure

This project uses Clean Architecture and is separated into four main layers:

* **Data**: Contains the repositories implementations responsible for abstracting
  the data source used. In this case, the data sources are a REST API and a Core Data database.
* **Domain**: Holds the business logic layer, which contains the use cases responsible for handling
  the business logic of the application and the abstract repositories. The use cases are the entry
  point to the domain layer.
* **Presentation**: Contains the UI responsible for presenting the data to the user and handling
  user interactions. It also contains the ViewModels, which are
  responsible for preparing the data to be presented and for handling the interactions between the
  view and the use cases.
* **Core**: Contains the common code between the other layers, like the extensions and the dependency
  injection code.


## Folder Structure

```markdown
📦SwiftyMarvel
┣ 📂Core
┃ ┣ 📂DI
┃ ┗ 📂Extensions
┣ 📂Data
┃ ┣ 📂Constants
┃ ┣ 📂DataSource
┃ ┣ 📂Model
┃ ┣ 📂Mappers
┃ ┣ 📂Networking
┃ ┗ 📂Repository
┣ 📂Domain
┃ ┣ 📂Entity
┃ ┣ 📂Errors
┃ ┣ 📂Repository
┃ ┗ 📂UseCase
┣ 📂Presentation
┃ ┣ 📂Core
┃ ┣ 📂ReusableViews
┃ ┣ 📂Screens
┃ ┃ ┣ 📂Home
┃ ┃ ┃ ┣ 📂ViewModels
┃ ┃ ┃ ┗ 📂Views
┗ 📜SwiftyMarvelApp.swift => The app entry point.
```

## Tools & Frameworks Used

| Tool                                                                                                  | Used for                                                             |
|-------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------|
| VIPER                                                                                                 | Architectural design pattern for separating the logic form the views |
| [Core Data](https://developer.apple.com/documentation/coredata/)                                      | Storing favorite characters                                          |
| [Swinject](https://github.com/Swinject/Swinject)                                                      | Dependency Injection                                                 |
| [Arkana](https://github.com/rogerluan/arkana)                                                         | Securely storing secrets and keys                                    |
| [Nuke](https://github.com/kean/Nuke)                                                                  | Image Loading & Caching                                              |
| [SwiftLint](https://github.com/realm/SwiftLint)                                                       | Code Linting                                                         |
| [Mockingbird](https://github.com/birdrides/mockingbird)                                               | Generating mock, stub, and verify objects in Swift unit tests        |


## Development Environment
* Xcode 14.3.1
* Swift 5.8.1
* iOS Deployment Target 16.2

## Author
* [**Carlos Morgado**](https://github.com/Carlos-Morgado)

  
## Characteristics Overview
- Written in Swift
- Using UIKit framework
- Auto layout Based
- Designed with VIPER pattern
- App runed on iPhone.
- Built in Xcode 15
- Leverages free Rick & Morty API
- Kingfisher with CocoaPods
  
## App's design and structure
The app has six key area:
- Characters, which shows a list of all the characters.
- Character Detail, where we can see all the information about the character.
- Locations, which shows a list of all the locations.
- Location Detail, where we can see all the information about the location.
- Episodes, which shows a list of all the episodes.
- Episode Detail, where we can see all the information about the episode.
