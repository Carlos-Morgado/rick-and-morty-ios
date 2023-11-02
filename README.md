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
* [Architecture Design](#architecture-design)
* [Folder Structure](#folder-structure)
* [Tools & Frameworks Used](#tools--frameworks-used)
* [Development Environment](#development-environment)

<!-- TOC -->

## How it looks

| List | Detail |
| :-: | :-: |
| <img width="200" src="https://github.com/Carlos-Morgado/rick-and-morty-ios/assets/122310905/96ff88bf-c539-4973-a618-46c92dffecd2"/> | <img width="200" src="https://github.com/Carlos-Morgado/rick-and-morty-ios/assets/122310905/9ef85441-f92b-4403-93fd-736406996144"/> | <img src="Settings/Assets/Search.png"/> | <img src="Settings/Assets/Details.png"/>

## Architecture Design

This project uses Clean Architecture and is separated into four main layers:

* **Data**: In this folder are the **(DTO)** data models, which are the object representation of the JSON request, and the **Data Source**, which is in charge of the data request to obtain the characters, episodes, or locations.
* **Domain**: La información conseguida por el DataSource va al Interactor, cuya misión es pasar dicha información al presenter.
* **Module**: Dentro de esta capa nos encontramos 3 piezas fundamentales en el desarrollo de la arquitectura:
  * El **Presenter** es el componente más importante de VIPER junto con el interactor ya que actúa como puente entre los módulos de VIPER y contiene la lógica de negocio. Recibe los eventos de la vista y reacciona a ellos pidiendo los datos necesarios al interactor. En sentido opuesto recibe los datos del interactor, aplica la lógica y prepara el contenido para pasárselo a la vista y que esta lo muestre.
  * El **Router** es el encargado de la navegación y de pasar datos entre vistas. Debe implementar un protocolo que incluya todas las posibilidades de navegación entre módulos.
  * La **View** es básicamente un ViewController que contiene sub vistas implementadas programaticamente. La vista tiene como única responsabilidad mostrar en la interfaz la información que llega desde el presenter y recoger eventos del usuario delegándolos al presentador.
* **Common**: Contains the common code between the other layers, like the extensions and the dependency injection code, reusable cells for all the aplication, the API base url...

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
* Xcode 14.0
* Swift 5.7
* iOS Deployment Target 16.0

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
