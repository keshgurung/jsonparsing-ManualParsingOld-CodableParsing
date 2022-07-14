# jsonparsing-old
This isa an ald waay of parsing json objects manually.

# MVC ios: 

- Traditional MVC: 
 - View alerts controller for some events particular, 
 - Controller sends signal to modal.
 - model alerts view that it has done the change,
 - View handles and grabs model data and updates itself.

- IOS MVC: 
 - View and model don't connect with each other.
 - controller acts as a middle agent between them.
 - Controllet takes user action and updates model for the task.
 - Model updates as per the logic and notifies controller.
 - Controller is in charge of updating view.


- Model VIew Architecture: 

 - The Model is where our data resides. Things like persistence, model objects, parsers, managers, and networking code live there.
 - The View layer is the face of your app. Its classes are often reusable as they don’t contain any domain-specific logic. For example, a UILabel is a view that presents text on the screen, and it’s reusable and extensible.
 - The Controller mediates between the view and the model via the delegation pattern. In an ideal scenario, the controller entity won’t know the concrete view it’s dealing with. Instead, it will communicate with an abstraction via a protocol. A classic example is the way a UITableView communicates with its data source via the UITableViewDataSource protocol.

 - For IOS MVC :-
  - can be good for small project. 
  - bad for large projects, 