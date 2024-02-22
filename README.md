# Cosmos Flutter Package ❤️

_Developer: JeaFriday🎶_

## Why Was It Developed?

This package was developed to bring together challenging materials created as a result of the efforts of many developers, ensuring that no application will make you struggle with lines of code!

## Included in the Package

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



```



```



```



```




```



```



```



```



```



```




```




```




```




```




```




```




```




```




```




```




```




```


