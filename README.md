
# Credly Take Home Assignment

This project is a take home assignment to test my programming skills. It is written in Swift, and contains unit tests for the view model and the model layers. It is utilizing the MVVM pattern to separate the business logic from the view layer in a way to make it much more testable via dependency injection. 

## Folder Structure
There are three main folders that represent the code structure:
1. **Views**: Contains the views and view controllers that represent the user screen.
2. **ViewModels**: Contains the view model that provides the business logic for the view.
3. **Model**: Contains the raw data models and API request to the user endpoint. 

## CocoaPods
The model layer is utilizing 2 third party CocoaPods, as asked for in the instructions. For networking, I used **AlamoFire**, and for JSON parsing I included **JSONParserSwift**. I would not use either of these in reality since the first party parsing and networking are perfectly fine these days. But again, this at least shows how to utilize cocoa pods within the application as requested.

## Unit Tests
The networking and view model have the ability to inject a mock object into them on initialization. This allows us to test at this specific layer without accessing real network calls. This is achieved through the use of protocols. 

A NetworkManager has been created to represent the real network call that would be made in the app, and uses AlamoFire to make it's request.  It conforms to the NetworkManagerProtocol, which is the type that needs to be passed into the UserAPI on initialization. When running the unit test, we have another class that conforms the NetworkManagerProtocol, but is a mock, and only returns what is set in it's response property. 

View model follows the same protocol logic, but instead of mocking the networking manager, it mocks the UsersAPI layer. This keeps our testing logic constrained to just the view model.


## Other Notes
The View layer utilizes a xib for the tableview cell. This allows us to dynamically create the cell in unit tests without the need for a view controller.

Error Handling for network and parsing errors has been implemented. It is a limited subset of the possible errors, but is mostly just demonstrating how error handling can be achieved with different error types. For simplification purposes, the view ends up with a string describing the error, and presents it to the users in an alert, but this could be improved upon based on business requirements.

A standard Refresh control has been added to the table view.

## Demo
![](https://github.com/vegemanis/CredlyTakeHome/blob/main/Resources/Demo.gif)
