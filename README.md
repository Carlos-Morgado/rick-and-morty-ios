![Portadas-Github](https://github.com/Carlos-Morgado/rick-and-morty-ios/assets/122310905/62d4cb8b-ed60-4fcd-91e3-4ded71c41ac6)

<h1 align="center"> Rick&Morty (UIKit Version) </h1>

> ##### If you like this project, support it by "★ Star" in the repository. Thank you!

<p align="center">
<br>
Rick&Morty is an American television series that narrates the adventures of Rick, a peculiar and crazy genius; and Morty, his shy and not very smart grandson. This application tries to show all the different contents of this TV show. You can search through hundreds of characters, episodes, and discover all the planets that create this universe.
 <br>
 <br>
This application was created with the aim of learning new skills of the iOS development environment, such as the VIPER architecture, UIKit framework, Cocoapods, Kingfisher... and more.
<br>
</p>

<!-- TOC -->

* [How it looks](#how-it-looks)
* [Architecture and Concept](#architecture-and-concept)
* [Folder Structure](#folder-structure)
* [Tools & Frameworks Used](#tools--frameworks-used)
* [Development Environment](#development-environment)

<!-- TOC -->

## How it looks

| List | Detail |
| :-: | :-: |
| <img src="https://github.com/Carlos-Morgado/rick-and-morty-ios/assets/122310905/04d37cfa-38e5-45b8-bf95-6b36266ec0f0"/> | <img src="Settings/Assets/Characters.png"/> | <img src="Settings/Assets/Search.png"/> | <img src="Settings/Assets/Details.png"/>

## Architecture and Concept

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

## Architecture Scheme
  
<p align="center">
  <img width="800" src="./Resources/Architecture.png" alt="">
</p>


## Folder Structure

```markdown
📦rick-and-morty
┣ 📂Resource
┗ 📂Source
  ┣ 📂AppDelegate
  ┣ 📂Common
  ┣ 📂Module
  ┃ ┣ 📂Splash
  ┃ ┣ 📂TabBar
  ┃ ┣ 📂Characters
  ┃ ┣ 📂CharacterDetail
  ┃ ┣ 📂Episodes
  ┃ ┣ 📂EpisodeDetail
  ┃ ┣ 📂Locations
  ┃ ┗ 📂LocationsDetail
  ┣ 📂Domain
  ┃ ┣ 📂GetCharacters
  ┃ ┃ ┣ 📂Interactor
  ┃ ┣ 📂GetCharacterDetail
  ┃ ┃ ┣ 📂Interactor
  ┃ ┣ 📂GetEpisodes
  ┃ ┃ ┣ 📂Interactor
  ┃ ┣ 📂GetEpisodeDetail
  ┃ ┃ ┣ 📂Interactor
  ┃ ┗ 📂GetLocations
  ┃   ┗ 📂Interactor
  ┗ 📂Data
    ┣ 📂Characters
    ┃ ┣ 📂DataSource
    ┃ ┗ 📂DTO
    ┣ 📂Episodes
    ┃ ┣ 📂DataSource
    ┃ ┗ 📂DTO
    ┗ 📂Locations
      ┣ 📂DataSource
      ┗ 📂DTO
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
