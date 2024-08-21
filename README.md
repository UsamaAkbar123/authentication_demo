# authentication_demo

A demo firebase authentication with email and password using cubit state management.

## Steps to run the project

# Step 1
From master branch, clone or download the project.

# Step 2
Open the project with your prefer IDE(Android Studio, or VS Code), and then setup the dart sdk path, usualy the sdk path are in your-flutter-folder/bin/cache/dart-sdk

# Step 3
In the project terminal run the below command 
flutter pub get

# Step 4
Run the project

## Challenging Part

# 1: Slow Internet issue
  Due to internet issue, flutterfire CLI, and firebase project setup takes too much times

# 2: Automatically Create the User
   In normal cases, login and signup are the two saperate features inside the application, but in this task, the main requirenment is, if sign in option through the exception then according to FirebaseAuthException , we will decide what to show to the user, but in my case , in any senario i got the only one exception "the supplied auth credential is incorrect, malformed, or has expired", because firebase apply a "EMAIL ENUMARATION PROTECTION" for security purpose, so when this open is enable in the firebase project, we will got only above FirebaseAuthException, so to resolve this issue , i disable the check from firebase project,  
   After that, i got the different exception messages, so we can proceed according to the task requirnment.
   examples
   "user not found exception": create the user
   "password excaption": pasword is invalid etc
