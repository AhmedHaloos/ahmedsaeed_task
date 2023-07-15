# ahmedsaeedtask

astratech task

## Getting Started

This project is a starting point for a Flutter application.

in this project i used MVP design architecture, but for simplicity i did not use it in all screens.
first i created a registeration screen and login screen using controller, presenter and  backend using firebase for it,
then i created login and splash screen and i used getx library in both login and registeration to 
handle state management.
after that i created ImageUploadScreen to upload images and DisplayImageScreen and ImageListScreen.
each of them has its own controller, presenter and backend.
# controller
created for getx and handle state of the screen
# presenter
created for each feature of the task, like LoginPresenter, and responsible for handle all logic for login, 
connect to both backend and view.
# backend or model 
this component is responsible for handle all the backend logic, like authentication and storage for firebase.

for simplicity of the work as it contains a lot of work, i have broken the arch. role and used backend 
directly form the view, this is not allowed in real work.