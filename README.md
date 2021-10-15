# RappiPlay - Technical Test

Application bassed on The Movie Database API that shows the Most Popular, Top Rated and Upcoming Films and Series

## Application Layers

The app is built following a **MVVC** pattern, that organizes each of the "Scenes" of the app in separated folders, where each one of them contains his related **Model** and **ViewModel** Component, and shares between all a same view(Storyboard). Besides those **Scenes**, there is a module that is responsible for the communication with the API and contains the different **Services** to fetch data from the Database, at the end, there is a **Utilities** Module, that contains functionalities, extensions, and classes that can be used by many other components of the app, due to this, they are stored in a single place that can be instantiated from other modules. Each of the modules and component can be placed on different **Application Layers**

### Presentation Layer

    Landing---> LandingViewController.swift
    ContentDetails---> ContentDetailsViewController.swift
    RappiApp----> Main.storyboard
  
### Bussiness Layer
  
    Landing---> LandingModel.swift
    ContentDetails---> ContentDetailsModel.swift
      
### Data Layer
  
    Services----> MovieService.swift
    Services----> MovieServiceSchemas.swift
    
## Single-responsibility principle and Clean Code

First concept of the SOLID principles, this one states that every component should have only one responsability in the whole application. Following this, helps to build a clean and maintanable solution, that in the case when a bug is found or when implementing a feauture, you will just modify, integrate or fix the classes and components needed, lowering the chance of caussing side-effects in the app and reducing the effort. This is a main characteristic of a Clean code, because helps to code efficiently while building a solid foundation to escalate the Application.

Other important characteristics of a clean code is the clear understandment of it. Nothing feels better than that a peer can undestand and begin working with your code as soon as they se it, that means that your code is legible, organized and very well structured and thought.
