# movie_app_bloc

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

App Flow chart

Movie List Screen: This is the screen where you see the grid list of all the movies.
Movie List Bloc: This is the bridge which will get data from the repository on demand 
and pass it to the Movie List Screen.
Movie Detail Screen: This is the screen where you will see the detail of the movie 
you selected from the list screen. 
Here you can see the name of the movie, rating, release date, 
description and trailers.
Repository: This is the central point from where the data flow is controlled.
API provider: This holds the network call implementation.

![alt text](https://miro.medium.com/v2/resize:fit:828/format:webp/1*dkKlfFewf6CBVbwFIeCNHQ.png)

Scoped Instance (Using Inherited Widget)

Single Instance vs Scoped Instance
As you can see in the diagram both the screens have access to their respective BLoC class.
You can expose these BLoC classes to their respective screens in two ways i.e 
Single Instance or Scoped Instance. When I say Single Instance, 
I mean a single reference(Singleton) of the BLoC class will be exposed to the screen.
This type of BLoC class can be accessed from any part of the app. Any screen can use
a Single Instance BLoC class.

But Scoped Instance BLoC class has limited access. I mean it’s only accessible to the 
screen it’s associated with or exposed to. Here is a small diagram to explain it.

As you can see in the above diagram the bloc is only accessible to the screen widget 
and 2 other custom widgets below the Screen. We are using the InheritedWidget which 
will hold the BLoC inside it. InheritedWidget will wrap the Screen widget and let the
Screen widget along with widgets below it have access to the BLoC. No parent widgets 
of the Screen Widget will have access to the BLoC.

![alt text](https://miro.medium.com/v2/resize:fit:828/format:webp/1*rID6hLMzUfIwSA6m8UkM2g.png)

Publish Subject to Behavior Subject

Transformers mostly helps in chaining two or more Subjects and get the final result.
Idea is, if you want to pass data from one Subject to another after performing some
operations over the data. We will be using transformers to perform operation on the
input data from the first Subject and will pipe it to the next Subject.

In our app we will be adding the movieId to the _movieId which is a PublishSubject.
We will pass the movieId to the ScanStreamTransformer which in turn will make a network
call the trailer API and get the results and pipe it to the _trailers which is a 
BehaviorSubject. Here is a small diagram to illustrate my explanation.

![alt text](https://miro.medium.com/v2/resize:fit:828/format:webp/1*8EKpbLKC61gkS8jstJ_9kQ.png)