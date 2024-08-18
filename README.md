# Cosmos Flutter Package ❤️

_Developer: JeaFriday🎶_


![Cosmos Banner](https://raw.githubusercontent.com/JeaFrid/Cosmos/main/assets/cosmosbanner.png)

[![Build Status](https://img.shields.io/badge/Developer-JeaFriday-purple)](https://t.me/JeaFrid) [![Build Status](https://img.shields.io/badge/YouTube-Kırmızı_Patika-red)](https://www.youtube.com/channel/UC02BVsVHvdYqYkjrfE6eMXw) 



## Why Was It Developed?

<img src="https://raw.githubusercontent.com/JeaFrid/Cosmos/main/assets/confetti.png" width="50" height="50">



This package was developed to bring together challenging materials created as a result of the efforts of many developers, ensuring that no application will make you struggle with lines of code!

## Included in the Package

<img src="https://raw.githubusercontent.com/JeaFrid/Cosmos/main/assets/flask.png" width="50" height="50">

- **CosmosAlert:** An alert viewer with options such as IOS, Material, and customizable. Use it as a screen or just show alerts.
  
- **Cosmos Buttons:** Instead of complicated button stuff, customizable and easier to access buttons included in the Cosmos package.
  
- **CosmosScroller:** An auto-scrollable layout. With this widget, you can get a complete scrolling experience in the desired direction.
  
- **CosmosBody:** A fast (Column) layout developed for the 'body' feature of the Scaffold widget, offering automatic scrolling.
  
- **CosmosTextBox:** A fully customizable TextField widget. It's a masterpiece with its own frames and customizable parts.
  
- **CosmosFirebase:** A Flutter package developed for Google Firebase. Saving data to the database, extracting data, creating profiles, and much more.
  
- **CosmosTools:** CosmosTools contains the potential tools you may need.
  
- **CosmosColor:** Color tools.
  
- **CosmosImage:** With CosmosImage, it automatically detects your images in a single way, determines whether they are a network or an asset, and displays them accordingly. It prevents delays that may occur in reloads by saving images coming from the internet to the cache.
  
- **CosmosTelegram:** A tool that makes it easy for you to send messages using the Telegram API.
  
- **CosmosTopBar:** Creates a top bar for your apps. This bar has a responsive layout.
  
- **CosmosSideMenu:** Adds a side menu to your application.
  
- **openSideMenu:** Side opens the menu.
  
- **CosmosNavigation:** By adding a bottom bar to your app, it will create a bottomBar as you want.
  
- **CosmosCheckBox:** It is a more understandable, simple, and very sweet CheckBox instead of the stupid CheckBox found in the Flutter package.
  
- **CosmosInfo:** A quick Tooltip.
  
- **height, width, heightPercentage, widthPercentage:** It allows you to perform operations with screen aspect ratios. It acts somewhat like the 'MediaQuery.sizeOf(context).width' class.

## Package Documentation

<img src="https://raw.githubusercontent.com/JeaFrid/Cosmos/main/assets/diary.png" width="50" height="50">

### CosmosBackgroundImage
An example for adding, editing, and more background images to your application.

- **child:** Continue building the widget tree on top of this.
- **opacity:** Set the opacity of the image.
- **image:** Select the background photo with an image (Asset).

**Example;**
``` dart
import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CosmosBackgroundImage(
        image: "assets/image.jpg",
        child: Center(),
      ),
    );
  }
}
```

### CosmosTime

Provides functional features for time and timing in your Flutter application.

#### CosmosTime.fromMillisecondsToDate()
Converts from milliseconds to date-time.

- **milliseconds:** Milliseconds

**Example:**
```dart
import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () {
            CosmosTime.fromMillisecondsToDate(1750124800000);
          },
          child: const Text("data"),
        ),
      ),
    );
  }
}
```

#### CosmosTime.getMilliseconds()
Converts date-time to milliseconds.

- **dateTimeString:** String

**Example:**
```dart
import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () {
            String time = CosmosTime.getNowTimeString();
            CosmosTime.getMilliseconds(time);
          },
          child: const Text("data"),
        ),
      ),
    );
  }
}
```

#### CosmosTime.millisecond()
Returns the current millisecond.

**Example:**
```dart
import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () {
            String millisecond = CosmosTime.millisecond();
            print(millisecond);
          },
          child: const Text("data"),
        ),
      ),
    );
  }
}

```


#### CosmosTime.getNowTimeString()
Returns the current date and time.

**Example:**
```dart
import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () {
            String dateTime = CosmosTime.getNowTimeString();
            print(dateTime);
          },
          child: const Text("data"),
        ),
      ),
    );
  }
}
```

### CosmosAlert

#### CosmosAlert.showAnimatedDialog()
Brings a classic alert pop-up.

- **context:** BuildContext
- **title:** String
- **text:** String
- **buttonText:** String
- **onPressed:** void Function()

**Example:**
```dart
import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () {
            CosmosAlert.showAnimatedDialog(
              context,
              "title",
              "text",
            );
          },
          child: const Text("data"),
        ),
      ),
    );
  }
}


```

#### CosmosAlert.showIOSStyleAlert()
Brings an IOS style alert pop-up.

- **context:** BuildContext
- **title:** String
- **text:** String
- **buttonText:** String
- **onPressed:** void Function()

**Example:**
```dart
import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () {
            CosmosAlert.showIOSStyleAlert(
              context,
              "title",
              "text",
            );
          },
          child: const Text("data"),
        ),
      ),
    );
  }
}


```

#### CosmosAlert.showCustomAlert()

Brings a custom alert pop-up.

- **context:** BuildContext
- **child:** Widget

**Example:**
```dart
import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () {
            CosmosAlert.showCustomAlert(
              context,
              const Text("Hello World!"),
            );
          },
          child: const Text("data"),
        ),
      ),
    );
  }
}


```

### CosmosScroller

Creates a scrollable widget in your application. Creates a scrollable widget that can work horizontally and vertically, with mouse and touch.

- **scrollDirection:** Horizontal or vertical? (Axis)
- **children:** Children (List Widget)

**Example:**
```dart
import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CosmosScroller(
          scrollDirection: Axis.horizontal,
          children: [
            TextButton(
              onPressed: () {
                CosmosAlert.showCustomAlert(
                  context,
                  const Text("Hello World!"),
                );
              },
              child: const Text("data"),
            ),
            TextButton(
              onPressed: () {
                CosmosAlert.showCustomAlert(
                  context,
                  const Text("Hello World!"),
                );
              },
              child: const Text("data"),
            ),
            TextButton(
              onPressed: () {
                CosmosAlert.showCustomAlert(
                  context,
                  const Text("Hello World!"),
                );
              },
              child: const Text("data"),
            ),
          ],
        ),
      ),
    );
  }
}


```

### CosmosBody

Creates a scrollable Scaffold>body in your application based on the situation. Creates a scrollable widget that can work horizontally and vertically, with mouse and touch.

- **scrollDirection:** Horizontal or vertical? (Axis)
- **scrollable:** Is it scrollable? (bool)
- **children:** Children (List Widget)

**Example:**
```dart
import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CosmosBody(
          scrollDirection: Axis.vertical,
          scrollable: true,
          children: [
            TextButton(
              onPressed: () {
                CosmosAlert.showCustomAlert(
                  context,
                  const Text("Hello World!"),
                );
              },
              child: const Text("data"),
            ),
          ],
        ),
      ),
    );
  }
}


```

### CosmosTextBox

Creates a quick customizable (Box) TextField of Cosmos type.

- **data:** Hint text (String)

**Example:**
```dart
import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CosmosBody(
          scrollDirection: Axis.vertical,
          scrollable: true,
          children: [
            const CosmosTextBox("Example TextBox"),
            TextButton(
              onPressed: () {
                CosmosAlert.showCustomAlert(
                  context,
                  const Text("Hello World!"),
                );
              },
              child: const Text("data"),
            ),
          ],
        ),
      ),
    );
  }
}


```
### pickImage()

Selects an image from the gallery.

**Example:**
```dart
import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CosmosBody(
          scrollDirection: Axis.vertical,
          scrollable: true,
          children: [
            const CosmosTextBox("Example TextBox"),
            TextButton(
              onPressed: () async {
                String? imagePath = await pickImage();
              },
              child: const Text("data"),
            ),
          ],
        ),
      ),
    );
  }
}



```

### CosmosFirebase

You can perform Firebase operations most quickly, efficiently, and functionally.

#### CosmosFirebase.imagePickAndStoreFireStorage()

Selects an image from the gallery, processes the image in Firebase Storage, and returns the URL of the image as a String data type.

**Example:**
```dart
import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CosmosBody(
          scrollDirection: Axis.vertical,
          scrollable: true,
          children: [
            TextButton(
              onPressed: () async {
                String? imagePath =
                    await CosmosFirebase.imagePickAndStoreFireStorage();
              },
              child: const Text("data"),
            ),
          ],
        ),
      ),
    );
  }
}


```

#### CosmosFirebase.dataChanged()

This function, working within Firebase Realtime Database, is executed in the initState. It runs when data is added or deleted from the database and returns the current last value.

- **reference:** String
- **onDataChanged:** void Function(Object element)

**Example:**
```dart
import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    CosmosFirebase.dataChanged(
      reference: "users",
      onDataChanged: (element) {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}



```
#### CosmosFirebase.deleteData()

This function, working within Firebase Realtime Database, deletes data from the database.

- **ref:** String

**Example:**
```dart
import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CosmosBody(
          scrollDirection: Axis.vertical,
          scrollable: true,
          children: [
            TextButton(
              onPressed: () async {
                CosmosFirebase.deleteData("users/131643464");
              },
              child: const Text("data"),
            ),
          ],
        ),
      ),
    );
  }
}



```

#### CosmosFirebase.storeValue()

This function, working within Firebase Realtime Database, adds data to the database.

- **reference:** String
- **tag:** String
- **valueList:** List

**Example:**
```dart
import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CosmosBody(
          scrollDirection: Axis.vertical,
          scrollable: true,
          children: [
            TextButton(
              onPressed: () async {
                await CosmosFirebase.storeValue(
                  "users",
                  "13136546413",
                  [
                    "username",
                    "surname",
                    "age",
                  ],
                );
              },
              child: const Text("data"),
            ),
          ],
        ),
      ),
    );
  }
}


```

#### CosmosFirebase.getOnce()

This function, working within Firebase Realtime Database, retrieves all data in a top-level category in the database.

- **reference:** String

**Example:**
```dart
import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CosmosBody(
          scrollDirection: Axis.vertical,
          scrollable: true,
          children: [
            TextButton(
              onPressed: () async {
                List getAllData = await CosmosFirebase.getOnce("users");
              },
              child: const Text("data"),
            ),
          ],
        ),
      ),
    );
  }
}


```

#### CosmosFirebase.register()

This function, working within Firebase Realtime Database and Firebase Auth, creates a user with Firebase Auth and also creates a user entry in the 'users' category within the Realtime Database.

- **email:** String
- **password:** String
- **userDatas:** List

**Example:**
```dart
import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CosmosBody(
          scrollDirection: Axis.vertical,
          scrollable: true,
          children: [
            TextButton(
              onPressed: () async {
                await CosmosFirebase.register(
                  "email@gmail.com",
                  "aaaaaa",
                  [],
                );
              },
              child: const Text("data"),
            ),
          ],
        ),
      ),
    );
  }
}


```

#### CosmosFirebase.login()

This function, working within Firebase Realtime Database and Firebase Auth, logs in the user who registered with CosmosFirebase.register().

- **email:** String
- **password:** String

**Example:**
```dart
import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CosmosBody(
          scrollDirection: Axis.vertical,
          scrollable: true,
          children: [
            TextButton(
              onPressed: () async {
                await CosmosFirebase.login(
                  "email@gmail.com",
                  "aaaaaa",
                );
              },
              child: const Text("data"),
            ),
          ],
        ),
      ),
    );
  }
}


```

#### CosmosFirebase.logout()

This function, working within Firebase Realtime Database and Firebase Auth, logs out the user who logged in with CosmosFirebase.login().

**Example:**
```dart
import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CosmosBody(
          scrollDirection: Axis.vertical,
          scrollable: true,
          children: [
            TextButton(
              onPressed: () async {
                await CosmosFirebase.logout();
              },
              child: const Text("data"),
            ),
          ],
        ),
      ),
    );
  }
}



```


#### CosmosFirebase.getUID()

This function, working within Firebase Realtime Database and Firebase Auth, retrieves the unique identifier of the user who logged in with CosmosFirebase.login().

**Example:**
```dart
import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CosmosBody(
          scrollDirection: Axis.vertical,
          scrollable: true,
          children: [
            TextButton(
              onPressed: () async {
                String getMyUID = await CosmosFirebase.getUID();
              },
              child: const Text("data"),
            ),
          ],
        ),
      ),
    );
  }
}


```


#### CosmosFirebase.isSignedIn()

This function, working within Firebase Realtime Database and Firebase Auth, checks whether the user is signed in or not, and returns true or false.

**Example:**
```dart
import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CosmosBody(
          scrollDirection: Axis.vertical,
          scrollable: true,
          children: [
            TextButton(
              onPressed: () async {
                if (CosmosFirebase.isSignedIn()) {
                  print(true);
                }
              },
              child: const Text("data"),
            ),
          ],
        ),
      ),
    );
  }
}


```

#### CosmosFirebase.get()

This function, working within Firebase Realtime Database, retrieves a specific data from the database.

- **reference:** String
- **fevalue:** bool (Always set to true.)

**Example:**
```dart
import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CosmosBody(
          scrollDirection: Axis.vertical,
          scrollable: true,
          children: [
            TextButton(
              onPressed: () async {
                List getValue = await CosmosFirebase.get("users/64645654", true);
              },
              child: const Text("data"),
            ),
          ],
        ),
      ),
    );
  }
}



```

### CosmosTools

#### CosmosTools.sortFromList()

Sorts a list by time order.

- **list:** List
- **index:** int (The sequence number of the element containing CosmosTime.getNowTimeString() in the list.)

**Example:**
```dart
import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List example = [
    "a",
    "b",
    "c",
    "d",
    "e",
    CosmosTime.getNowTimeString(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CosmosBody(
          scrollDirection: Axis.vertical,
          scrollable: true,
          children: [
            TextButton(
              onPressed: () async {
                List getList = CosmosTools.sortFromList(example, 5);
                List reversedList = getList.reversed.toList();
              },
              child: const Text("data"),
            ),
          ],
        ),
      ),
    );
  }
}



```


### CosmosTools

#### CosmosTools.to()

Directly uses the widget to navigate between pages.

- **context:** BuildContext
- **page:** Widget

**Example:**
```dart
import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CosmosBody(
          scrollDirection: Axis.vertical,
          scrollable: true,
          children: [
            TextButton(
              onPressed: () async {
                CosmosTools.to(context, MyHomePage());
              },
              child: const Text("data"),
            ),
          ],
        ),
      ),
    );
  }
}


```

### CosmosTools

#### CosmosTools.back()

Close the current screen to return to the previous one.

- **context:** BuildContext

**Example:**
```dart
import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CosmosBody(
          scrollDirection: Axis.vertical,
          scrollable: true,
          children: [
            TextButton(
              onPressed: () async {
                CosmosTools.back(context);
              },
              child: const Text("data"),
            ),
          ],
        ),
      ),
    );
  }
}



```

### CosmosTools

#### CosmosTools.go()

Directly navigates between pages using route names.

- **context:** BuildContext
- **routeName:** String

**Example:**
```dart
import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CosmosBody(
          scrollDirection: Axis.vertical,
          scrollable: true,
          children: [
            TextButton(
              onPressed: () async {
                CosmosTools.go(context, "/home");
              },
              child: const Text("data"),
            ),
          ],
        ),
      ),
    );
  }
}



```

### CosmosTools

#### CosmosTools.allCloseAndGo()

Closes the previous screen and navigates between pages using routes.

- **context:** BuildContext
- **routeName:** String

**Example:**
```dart
import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CosmosBody(
          scrollDirection: Axis.vertical,
          scrollable: true,
          children: [
            TextButton(
              onPressed: () async {
                CosmosTools.allCloseAndGo(context, "/home");
              },
              child: const Text("data"),
            ),
          ],
        ),
      ),
    );
  }
}



```


### CosmosTools

#### CosmosTools.getRequestContent()

Fetches the content of the specified URL.

- **url:** String

**Example:**
```dart
import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CosmosBody(
          scrollDirection: Axis.vertical,
          scrollable: true,
          children: [
            TextButton(
              onPressed: () async {
                var get = await CosmosTools.getRequestContent("https://bybug.net");
              },
              child: const Text("data"),
            ),
          ],
        ),
      ),
    );
  }
}

```

Thanks for using it in your project! ♥
