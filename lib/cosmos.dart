library cosmos;

import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:jeadesing/jeadesing.dart';

class CosmosAlert {
  static Future<void> showAnimatedDialog(
    BuildContext context,
    String title,
    String text, {
    String? buttonText,
    void Function()? onPressed,
  }) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: Text(text),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: onPressed ??
                  () {
                    Navigator.of(context).pop();
                  },
              child: Text(buttonText ?? "Tamam"),
            ),
          ],
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
        );
      },
    );
  }

  static Future<void> showIOSStyleAlert(
    BuildContext context,
    String title,
    String text, {
    String? buttonText,
    void Function()? onPressed,
  }) async {
    await showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(title),
          content: Text(text),
          actions: <Widget>[
            CupertinoDialogAction(
              onPressed: onPressed ??
                  () {
                    Navigator.of(context).pop();
                  },
              child: Text(
                buttonText ?? "Tamam",
                style: const TextStyle(color: Colors.black),
              ),
            ),
          ],
        );
      },
    );
  }

  static Future<void> showCustomAlert(
    BuildContext context,
    Widget child,
  ) async {
    showDialog(
        context: context,
        builder: (context) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            body: Stack(
              alignment: Alignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    width: width(context),
                    height: height(context),
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
                child,
              ],
            ),
          );
        });
  }
}

///TR</br>
///Materyal bir ikon butonu. Bu butonu üst menüde, ara boşluklarda ve dilediğiniz her yerde kullanabilirsiniz.</br></br>
///US</br>
///The material is an icon button. You can use this button in the top menu, in the intermediate spaces and wherever you want.
class CosmosButtonIcon extends StatelessWidget {
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BorderRadius? borderRadius;
  final double? width;
  final Color? backgroundColor;
  final Color? iconColor;
  final Gradient? gradient;
  final double? height;
  final Color? color;
  final IconData iconData;
  final String text;
  final void Function()? onTap;
  final void Function()? onDoubleTap;
  final void Function()? onLongPress;
  final Color? focusColor;
  final Color? hoverColor;
  final List<BoxShadow>? boxShadow;
  final Color? highlightColor;
  final Color? splashColor;
  final TextStyle? textStyle;
  const CosmosButtonIcon({
    super.key,
    this.padding,
    this.margin,
    this.width,
    this.height,
    this.color,
    this.borderRadius,
    this.gradient,
    required this.iconData,
    required this.text,
    this.textStyle,
    this.backgroundColor,
    this.focusColor,
    this.hoverColor,
    this.highlightColor,
    this.splashColor,
    this.iconColor,
    this.onTap,
    this.onDoubleTap,
    this.onLongPress,
    this.boxShadow,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? const EdgeInsets.all(2),
      child: InkWell(
        onTap: onTap ?? () {},
        onDoubleTap: onDoubleTap ?? () {},
        onLongPress: onLongPress ?? () {},
        focusColor: focusColor,
        hoverColor: hoverColor,
        splashColor: splashColor,
        highlightColor: highlightColor,
        borderRadius: borderRadius ?? BorderRadius.circular(5),
        child: Container(
          margin: const EdgeInsets.all(2),
          padding: padding ?? const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: backgroundColor ?? Colors.transparent,
            borderRadius: borderRadius ?? BorderRadius.circular(5),
            boxShadow: boxShadow,
            gradient: gradient,
          ),
          width: width,
          height: height,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                iconData,
                color: iconColor ?? Colors.black,
                size: 18,
              ),
              const SizedBox(width: 5),
              Text(
                text,
                style: textStyle ??
                    const TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.w800,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

///TR</br>
///Materyal tasarımlarınızda kullanabileceğiniz modern bir buton.</br></br>
///US</br>
///A modern button that you can use in your material designs.
class CosmosButton extends StatelessWidget {
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BorderRadius? borderRadius;
  final double? width;
  final Color? backgroundColor;
  final Gradient? gradient;
  final double? height;
  final Color? color;
  final Widget? child;
  final String? data;
  final List<BoxShadow>? boxShadow;
  final void Function()? onTap;
  final Color? focusColor;
  final Color? hoverColor;
  final Color? highlightColor;
  final Color? splashColor;
  final TextStyle? textStyle;
  const CosmosButton(
    this.data, {
    super.key,
    this.padding,
    this.onTap,
    this.margin,
    this.width,
    this.height,
    this.color,
    this.borderRadius,
    this.gradient,
    this.child,
    this.textStyle,
    this.backgroundColor,
    this.focusColor,
    this.hoverColor,
    this.highlightColor,
    this.splashColor,
    this.boxShadow,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ?? () {},
      hoverColor: hoverColor,
      splashColor: splashColor,
      highlightColor: highlightColor,
      borderRadius: borderRadius ?? BorderRadius.circular(5),
      child: Container(
        padding: padding ?? const EdgeInsets.all(8),
        margin: margin,
        decoration: BoxDecoration(
          color: backgroundColor ?? Colors.transparent,
          borderRadius: borderRadius ?? BorderRadius.circular(5),
          gradient: gradient,
          boxShadow: boxShadow,
        ),
        width: width,
        height: height,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            child ??
                Text(
                  data ?? "Hello World JeaFriday!",
                  style: textStyle ??
                      const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.w800),
                ),
          ],
        ),
      ),
    );
  }
}

class CosmosScroller extends StatefulWidget {
  final Axis scrollDirection;
  final List<Widget> children;

  final bool? reverse = false;
  final EdgeInsetsGeometry? padding;
  final bool? primary;
  final MainAxisAlignment? mainAxisAlignment;
  final CrossAxisAlignment? crossAxisAlignment;
  final ScrollPhysics? physics;
  final ScrollController? controller;
  final Clip clipBehavior = Clip.hardEdge;
  final String? restorationId;
  const CosmosScroller({
    super.key,
    required this.scrollDirection,
    required this.children,
    this.padding,
    this.primary,
    this.physics,
    this.controller,
    this.restorationId,
    this.mainAxisAlignment,
    this.crossAxisAlignment,
  });

  @override
  State<CosmosScroller> createState() => _CosmosScrollerState();
}

class _CosmosScrollerState extends State<CosmosScroller> {
  final localeController = ScrollController();

  @override
  Widget build(BuildContext context) {
    if (widget.scrollDirection == Axis.horizontal) {
      return GestureDetector(
        onHorizontalDragUpdate: (details) {
          localeController.jumpTo(localeController.offset - details.delta.dx);
        },
        child: SingleChildScrollView(
          controller: widget.controller ?? localeController,
          clipBehavior: widget.clipBehavior,
          padding: widget.padding,
          physics: widget.physics,
          primary: widget.primary,
          restorationId: widget.restorationId,
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment:
                widget.mainAxisAlignment ?? MainAxisAlignment.start,
            crossAxisAlignment:
                widget.crossAxisAlignment ?? CrossAxisAlignment.center,
            children: [
              const SizedBox(width: 10),
              Row(
                mainAxisAlignment:
                    widget.mainAxisAlignment ?? MainAxisAlignment.start,
                crossAxisAlignment:
                    widget.crossAxisAlignment ?? CrossAxisAlignment.center,
                children: widget.children,
              ),
              const SizedBox(width: 10),
            ],
          ),
        ),
      );
    } else if (widget.scrollDirection == Axis.vertical) {
      return GestureDetector(
        onVerticalDragUpdate: (details) {
          localeController.jumpTo(localeController.offset - details.delta.dy);
        },
        child: SingleChildScrollView(
          controller: widget.controller ?? localeController,
          clipBehavior: widget.clipBehavior,
          padding: widget.padding,
          physics: widget.physics,
          primary: widget.primary,
          restorationId: widget.restorationId,
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment:
                widget.mainAxisAlignment ?? MainAxisAlignment.start,
            crossAxisAlignment:
                widget.crossAxisAlignment ?? CrossAxisAlignment.center,
            children: [
              const SizedBox(width: 10),
              Column(
                mainAxisAlignment:
                    widget.mainAxisAlignment ?? MainAxisAlignment.start,
                crossAxisAlignment:
                    widget.crossAxisAlignment ?? CrossAxisAlignment.center,
                children: widget.children,
              ),
              const SizedBox(width: 10),
            ],
          ),
        ),
      );
    } else {
      return const Placeholder();
    }
  }
}

///TR</br>
///Kaydırılabilir bir [Scaffold] vücudu. Bu widget'ı yalnızca [Scaffold]'un body özelliğinde kullanın.</br></br>
///US</br>
///A slideable [Scaffold] body. Only use this widget in the body property of [Scaffold].
class CosmosBody extends StatelessWidget {
  final bool scrollable;
  final ScrollController? controller;
  final List<Widget>? children;
  final ScrollPhysics? physics;
  final MainAxisAlignment? mainAxisAlignment;
  final MainAxisSize? mainAxisSize;
  final Axis scrollDirection;
  final CrossAxisAlignment? crossAxisAlignment;
  const CosmosBody({
    super.key,
    required this.scrollable,
    this.children,
    this.controller,
    this.physics,
    this.mainAxisAlignment,
    this.mainAxisSize,
    this.crossAxisAlignment,
    required this.scrollDirection,
  });

  @override
  Widget build(BuildContext context) {
    return scrollable == false ? nonscroll() : scroll();
  }

  Widget nonscroll() {
    return Column(
      mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
      crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.center,
      mainAxisSize: mainAxisSize ?? MainAxisSize.max,
      children: children ?? <Widget>[],
    );
  }

  Widget scroll() {
    return CosmosScroller(
      controller: controller,
      physics: physics,
      scrollDirection: scrollDirection,
      children: children ?? <Widget>[],
    );
  }
}

class CosmosTextBox extends StatelessWidget {
  final TextEditingController? controller;
  final String? data;
  final void Function(String)? onChanged;
  final void Function(String, Map<String, dynamic>)? onAppPrivateCommand;
  final void Function(String)? onSubmitted;
  final void Function()? onEditingComplete;
  final void Function()? onTap;
  final void Function(PointerDownEvent)? onTapOutside;
  final Color? color;
  final double? cursorWidth;
  final double? cursorHeight;
  final bool? readOnly;
  final int? maxLines;
  final double? fontSize;
  final TextInputType? keyboardType;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;
  const CosmosTextBox(
    this.data, {
    super.key,
    this.controller,
    this.color,
    this.borderRadius,
    this.padding,
    this.keyboardType,
    this.maxLines,
    this.fontSize,
    this.cursorWidth,
    this.cursorHeight,
    this.onChanged,
    this.onAppPrivateCommand,
    this.onSubmitted,
    this.onEditingComplete,
    this.onTap,
    this.onTapOutside,
    this.readOnly,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.all(0.0),
      child: TextField(
        controller: controller ?? TextEditingController(),
        style: TextStyle(
          color: color?.withOpacity(0.7) ?? Colors.black.withOpacity(0.7),
          fontSize: fontSize,
        ),
        onChanged: onChanged,
        onAppPrivateCommand: onAppPrivateCommand,
        onEditingComplete: onEditingComplete,
        onSubmitted: onSubmitted,
        onTap: onTap,
        onTapOutside: onTapOutside,
        readOnly: readOnly ?? false,
        cursorWidth: cursorWidth ?? 2.0,
        cursorHeight: cursorHeight,
        cursorColor: color?.withOpacity(0.7) ?? Colors.black.withOpacity(0.7),
        keyboardType: keyboardType,
        maxLines: maxLines,
        decoration: InputDecoration(
          hintStyle: TextStyle(
            fontSize: fontSize,
            color: color?.withOpacity(0.3) ?? Colors.black.withOpacity(0.3),
          ),
          labelText: data,
          hintText: data,
          labelStyle: TextStyle(
            color: color?.withOpacity(0.7) ?? Colors.black.withOpacity(0.7),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(5),
            borderSide: BorderSide(
              width: 1,
              color: color?.withOpacity(0.7) ?? Colors.black.withOpacity(0.7),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(5),
            borderSide: BorderSide(
              width: 1,
              color: color?.withOpacity(0.7) ?? Colors.black.withOpacity(0.7),
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(5),
          ),
        ),
      ),
    );
  }
}

class CosmosFirebase {
  static void deleteData(String ref) {
    DatabaseReference databaseReference =
        FirebaseDatabase.instance.ref().child(ref);

    databaseReference.remove().then((_) {
      if (kDebugMode) {
        print("succesful");
      }
    }).catchError((onError) {
      if (kDebugMode) {
        print("Error: $onError");
      }
    });
  }

  static Future<String> storeValue(
      String reference, String tag, List valueList) async {
    try {
      DatabaseReference ref = FirebaseDatabase.instance.ref(reference);
      String val = CosmosFirebase.encode(valueList);
      await ref.child('"$tag"').set(val);
      return "successful";
    } catch (e) {
      return "error: ${e.toString()}";
    }
  }

  static Future<List> getOnce(String reference) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref(reference);
    DataSnapshot snapshot = await ref.get();

    Map mapX = snapshot.value as Map;
    List retVal = [];
    for (var i = 0; i < mapX.keys.length; i++) {
      retVal.add(CosmosFirebase.decodeAndTagAddEndElement(
          mapX.keys.elementAt(i), mapX.values.elementAt(i)));
    }
    return retVal;
  }

  ///It pulls data from Firebase Realtime Database.
  ///<br>Data must be pulled with a password provided by CosmosFirebase.
  ///<br>If you try to pull a different data, an error may occur.

  ///Encrypts the list with a key and converts it to String format.<br>You can store it as a String.
  ///!feValueIndex!
  ///The list has been converted to a String format. Use this to decode: [decode].
  static String encode(List value) {
    String feValue = "";
    for (var count = 0; count < value.length; count++) {
      feValue = "$feValue~~!feValueIndex!~~${value[count]}";
    }
    return feValue;
  }

  ///Decode an encrypted String type data with [encode].
  static List decode(String value) {
    List decodeList = value.split("~~!feValueIndex!~~");
    decodeList.removeAt(0);
    return decodeList;
  }

  ///Decode a String type data encrypted with [encode] and give the tag to the final index.
  static List decodeAndTagAddEndElement(String key, String value) {
    List decodeList = value.split("~~!feValueIndex!~~");
    decodeList.removeAt(0);
    List sendValue = decodeList;
    sendValue.add(key);
    return sendValue;
  }

  ///You can use this function for a quick recording.
  ///</br>It registers using "FirebaseAuth.instance.createUserWithEmailAndPassword()"
  ///</br>and sends the [userDatas] list to the users reference of the Realtime Database
  ///</br>using the "user.user!.uid" tag.
  static Future<List> register(
      String email, String password, List userDatas) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    try {
      var user = await auth.createUserWithEmailAndPassword(
          email: email, password: password);

      await CosmosFirebase.storeValue("users", user.user!.uid, userDatas);
      return [1.toString(), user.user.toString()];
    } catch (e) {
      return [0.toString(), e.toString()];
    }
  }

  ///Sign in with Firebase Auth. When the login is successful,
  ///</br>the first item of the returned list is 1. If it fails, it returns 0.
  ///</br>In case of success, the second item will be user.user. On failure,
  ///</br>the second item of the list returns an error message.
  static Future<List> login(String email, String password) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    try {
      var user = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      return [1, user.user];
    } catch (e) {
      return [0, e.toString()];
    }
  }

  ///Logs out of Firebase Auth.
  static logout() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    auth.signOut();
  }

  ///If the user is logged in, you can request the UID using this function.
  static Future<String> getUID() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    String uid = auth.currentUser!.uid;
    return uid;
  }

  ///Queries whether Firebase Auth is logged in.
  static bool isSignedIn() {
    final FirebaseAuth auth = FirebaseAuth.instance;
    if (auth.currentUser != null) {
      return true;
    } else {
      return false;
    }
  }

  ///Retrieves the reference from the Firebase Realtime Database.
  ///</br>If 'fevalue' is true, it [decode]s the incoming data and returns
  ///</br>the data in list type. If not, it returns the data directly.
  static Future<dynamic> get(String reference, bool fevalue) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref(reference);
    DataSnapshot snapshot = await ref.get();
    if (fevalue == true) {
      return CosmosFirebase.decode(snapshot.value.toString());
    } else {
      return snapshot;
    }
  }

  ///It finds the user in the 'users' reference from the
  ///</br>Firebase Realtime Database and returns its information
  ///</br>as a list. In order for this function to work successfully,
  ///</br>the user must be registered with [register].
  static Future<List> getProfile({String? uid}) async {
    if (uid == null) {
      if (CosmosFirebase.isSignedIn()) {
        FirebaseAuth auth = FirebaseAuth.instance;
        String getUid = auth.currentUser!.uid;
        DatabaseReference ref = FirebaseDatabase.instance.ref("users");
        DataSnapshot snapshot = await ref.get();
        Map mapX = snapshot.value as Map;
        String user = "";
        List mapList = mapX.keys.toList();

        for (var i = 0; i < mapList.length; i++) {
          if (mapList[i].toString().contains(getUid)) {
            user = mapList[i];
          }
        }
        DatabaseReference refer = FirebaseDatabase.instance.ref("users/$user");
        DataSnapshot snapval = await refer.get();

        return CosmosFirebase.decode(snapval.value.toString());
      } else {
        return [];
      }
    } else {
      if (CosmosFirebase.isSignedIn()) {
        String getUid = uid;
        DatabaseReference ref = FirebaseDatabase.instance.ref("users");
        DataSnapshot snapshot = await ref.get();
        Map mapX = snapshot.value as Map;
        String user = "";
        List mapList = mapX.keys.toList();

        for (var i = 0; i < mapList.length; i++) {
          if (mapList[i].toString().contains(getUid)) {
            user = mapList[i];
          }
        }
        DatabaseReference refer = FirebaseDatabase.instance.ref("users/$user");
        DataSnapshot snapval = await refer.get();

        return CosmosFirebase.decode(snapval.value.toString());
      } else {
        return [];
      }
    }
  }
}

class CosmosTools {
  Future<PlatformFile?> imagePicker() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) {
      PlatformFile file = result.files.first;
      return file;
    } else {
      return null;
    }
  }

  Future<String?> imagePickAndGetFilePath() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null) {
      PlatformFile file = result.files.first;
      return file.name;
    }
    return null;
  }

  Future<String?> imagePickAndStoreFireStorage() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null) {
      String int = Random().nextInt(100000).toString();
      PlatformFile file = result.files.first;
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference storageRef = storage.ref().child(int + file.name);
      TaskSnapshot snapshot = await storageRef.putData(file.bytes!);
      String downloadUrl = await snapshot.ref.getDownloadURL();

      return downloadUrl.toString();
    }
    return null;
  }

  ///Switches from the current screen to the target screen.
  static void to(BuildContext context, Widget page) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionDuration: const Duration(milliseconds: 0), // Animasyon süresi
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return child; // Animasyon olmadan doğrudan child widget'ı kullan
        },
      ),
    );
  }

  ///Close this screen and return to the previous screen.
  static void back(BuildContext context) {
    Navigator.pop(context);
  }

  ///Opens a new screen with RouteName. You need to specify 'routes' from within the [MaterialApp] widget for it to work.
  static void go(BuildContext context, String routeName) {
    Navigator.pushNamed(
      context,
      routeName,
    );
  }

  static PageRouteBuilder<dynamic>? pageRouteNonAnimation(name, page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionDuration: const Duration(milliseconds: 0), // Animasyon süresi
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return child; // Animasyon olmadan doğrudan child widget'ı kullan
      },
    );
  }

  ///Closes all screens and opens a new screen with RouteName. You need to specify 'routes' from within the [MaterialApp] widget for it to work.
  static void allCloseAndGo(BuildContext context, String routeName) {
    Navigator.popAndPushNamed(context, routeName);
  }

  ///GetRequest the given link and return the content.
  static dynamic getRequestContent(String url) async {
    final content = await Dio().get(url);
    return content.statusCode == 200
        ? content.data
        : content.statusCode.toString();
  }

  ///GetRequest the given link and return the headers.
  static dynamic getRequestHeaders(String url) async {
    final content = await Dio().get(url);
    return content.statusCode == 200
        ? content.headers
        : content.statusCode.toString();
  }

  ///GetRequest the given link and return the extras.
  static dynamic getRequestExtra(String url) async {
    final content = await Dio().get(url);
    return content.statusCode == 200
        ? content.extra
        : content.statusCode.toString();
  }

  ///Define this function for the desired context when
  ///</br>making screen changes with the [JeaFriday] class.
  ///</br>In the navigatorKey part, give the variable that defines
  ///</br>the [JeaFriday.navigatorKey] function. Please make sure the same
  ///</br>variable is also in the [MaterialApp] widget.
  static BuildContext navigatorKeyContext(
      GlobalKey<NavigatorState> navigatorKey) {
    return navigatorKey.currentState!.context;
  }

  ///It acts as a constructor for the navigatorKey
  ///</br>property of the [MaterialApp] widget. If you
  ///</br>are going to make screen changes using the [JeaFriday]
  ///</br>class, assign this function to a variable and define the
  ///</br>variable in the navigatorKey property of the [MaterialApp] widget.
  static GlobalKey<NavigatorState> navigatorKey() {
    return GlobalKey<NavigatorState>();
  }
}

class CosmosRandom {
  ///Generate a random String value.
  static String string(int length) {
    final List abc = [
      "a",
      "b",
      "c",
      "d",
      "e",
      "f",
      "g",
      "h",
      "i",
      "j",
      "k",
      "l",
      "m",
      "n",
      "o",
      "p",
      "r",
      "s",
      "t",
      "u",
      "v",
      "y",
      "x",
      "w",
      "z",
    ];
    String result = "";
    for (var i = 0; i < length; i++) {
      result = result + abc[Random().nextInt(abc.length)];
    }
    return result;
  }

  ///Generate a random Integer value.
  static int integer(int length) {
    return Random().nextInt(length);
  }

  ///Generate a random Email value.
  static String email() {
    return "${CosmosRandom.string(15)}@gmail.com";
  }

  ///Generate a random Password value.
  static String password() {
    return "${CosmosRandom.string(1).toUpperCase()}${CosmosRandom.string(3).toLowerCase()}${CosmosRandom.integer(2000)}${CosmosRandom.string(4).toLowerCase()}${CosmosRandom.string(3).toUpperCase()}${CosmosRandom.integer(99)}${CosmosRandom.string(4).toLowerCase()}${CosmosRandom.string(1).toUpperCase()}${CosmosRandom.string(3).toLowerCase()}${CosmosRandom.integer(2000)}${CosmosRandom.string(4).toLowerCase()}${CosmosRandom.string(3).toUpperCase()}${CosmosRandom.integer(99)}${CosmosRandom.string(4).toLowerCase()}";
  }
}

class CosmosColor {
  static Color hex(String value) {
    // Hex kodunu uygun formata getirme
    value = value.replaceAll("#", "");

    // Eğer hex kodu 6 karakter değilse veya içinde geçerli hex karakterleri yoksa varsayılan renk döndür
    if (value.length != 6 || !RegExp(r'^[0-9a-fA-F]+$').hasMatch(value)) {
      return Colors.black; // Varsayılan renk
    }

    // Hex kodunu RGBA formatına çevirme
    int hexValue = int.parse(value, radix: 16);
    return Color(
        hexValue | 0xFF000000); // Alpha kanalını ayarlama (0xFF tam opak)
  }
}

class CosmosImage extends StatelessWidget {
  final String? path;
  final double? width;
  final double? height;
  const CosmosImage(this.path, {super.key, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: path ?? "",
      key: UniqueKey(),
      width: width ?? 100,
      fit: BoxFit.cover,
      height: height ?? 100,
      errorWidget: (context, error, stackTrace) {
        return Image(
          image: AssetImage(path ?? ""),
          width: width ?? 100,
          key: UniqueKey(),
          fit: BoxFit.cover,
          height: height ?? 100,
          errorBuilder: (context, error, stackTrace) {
            return SizedBox(
              width: width ?? 100,
              height: height ?? 100,
              child: const Placeholder(color: Colors.red),
            );
          },
        );
      },
    );
  }
}

class CosmosTelegram {
  static Future<void> sendMessage(
      String botToken, String chatId, String text) async {
    final String apiUrl = 'https://api.telegram.org/bot$botToken/sendMessage';

    final Dio dio = Dio();
    final Response response = await dio.post(
      apiUrl,
      options: Options(headers: {'Content-Type': 'application/json'}),
      data: jsonEncode({
        'chat_id': chatId,
        'text': text,
      }),
    );

    if (response.statusCode == 200) {
      if (kDebugMode) {
        print('succesful');
      }
    } else {
      if (kDebugMode) {
        print('Error: ${response.statusCode}');
      }
      if (kDebugMode) {
        print('Error: ${response.data}');
      }
    }
  }

  static Future<void> sendPhotoFile(
      String botToken, String chatId, String caption, File photo) async {
    final String apiUrl = 'https://api.telegram.org/bot$botToken/sendPhoto';

    final Dio dio = Dio();
    final FormData formData = FormData.fromMap({
      'chat_id': chatId,
      'caption': caption,
      'photo': await MultipartFile.fromFile(photo.path, filename: 'photo.jpg'),
    });

    try {
      final Response response = await dio.post(
        apiUrl,
        data: formData,
      );

      if (response.statusCode == 200) {
        if (kDebugMode) {
          print('succesful');
        }
      } else {
        if (kDebugMode) {
          print('Status Code: ${response.statusCode}');
        }
        if (kDebugMode) {
          print('Error: ${response.data}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
    }
  }
}

double width(BuildContext context) {
  return MediaQuery.sizeOf(context).width;
}

double widthPercentage(BuildContext context, double percent) {
  return MediaQuery.sizeOf(context).width * percent;
}

double heightPercentage(BuildContext context, double percent) {
  return MediaQuery.sizeOf(context).height * percent;
}

double height(BuildContext context) {
  return MediaQuery.sizeOf(context).height;
}

///TR</br>
///Duyarlı bir üst menü oluşturun, hem üstte hem de altta kullanın!</br></br>
///US</br>
///Create a responsive top menu, use both top and bottom!
class CosmosTopBar extends StatelessWidget {
  final Widget? logo;
  final IconData? leftIcon;
  final Color? leftIconColor;
  final double? leftIconSize;
  final List<Widget>? children;
  final void Function()? leftIconOnTap;
  final IconData? rightIcon;
  final Color? rightIconColor;
  final double? rightIconSize;
  final void Function()? rightIconOnTap;
  const CosmosTopBar({
    super.key,
    this.logo,
    this.children,
    this.leftIcon,
    this.leftIconColor,
    this.leftIconSize,
    this.leftIconOnTap,
    this.rightIcon,
    this.rightIconColor,
    this.rightIconSize,
    this.rightIconOnTap,
  });

  @override
  Widget build(BuildContext context) {
    return MediaQuery.of(context).size.width < 800 ? mobil(context) : pc();
  }

  Widget mobil(context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          leftIcon == null
              ? const SizedBox()
              : InkWell(
                  borderRadius: BorderRadius.circular(5),
                  onTap: leftIconOnTap ?? () {},
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Icon(
                      leftIcon ?? Icons.menu,
                      color: leftIconColor ?? Colors.white,
                      size: leftIconSize ?? 28,
                    ),
                  ),
                ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 240,
              child: Center(child: logo ?? const SizedBox()),
            ),
          ),
          rightIcon == null
              ? const SizedBox()
              : InkWell(
                  borderRadius: BorderRadius.circular(5),
                  onTap: rightIconOnTap ?? () {},
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Icon(
                      rightIcon ?? Icons.support_agent,
                      color: rightIconColor ?? Colors.white,
                      size: rightIconSize ?? 28,
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  Padding pc() {
    return Padding(
      padding: const EdgeInsets.only(
        top: 16,
        left: 10,
        right: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 300,
              child: Row(
                children: [
                  Row(
                    children: [
                      logo ?? const SizedBox(),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: children ?? [],
          ),
        ],
      ),
    );
  }
}

///TR</br>
///Hızlı ve zahmetsiz bir yan menü oluşturmak hiç bu kadar kolay olmamıştı! El yapımı, hızlı ve verimli bir yan menü oluşturun.</br></br>
///US</br>
///Creating a side menu quickly and effortlessly has never been easier! Create a handcrafted side menu quickly and efficiently.
class CosmosSideMenu extends StatelessWidget {
  final Widget page;
  final List<Widget> children;
  const CosmosSideMenu({
    super.key,
    required this.page,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          page,
          Container(
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height,
            color: Colors.black.withOpacity(0.3),
          ),
          Row(
            children: [
              Container(
                height: MediaQuery.sizeOf(context).height,
                width: MediaQuery.sizeOf(context).width * 0.6,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 10, 10, 10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2), // Gölge rengi
                      spreadRadius: 10, // Gölgenin yayılma miktarı
                      blurRadius: 7, // Gölge bulanıklığı
                      offset: const Offset(
                          4, 0), // Gölgenin yönü (sağ tarafa doğru)
                    ),
                  ],
                ),
                child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    return JeaVerticalScrollViews(
                      child: const SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              InkWell(
                onTap: () => Navigator.pop(context),
                child: SizedBox(
                  height: MediaQuery.sizeOf(context).height,
                  width: MediaQuery.sizeOf(context).width * 0.4,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

void openSideMenu(BuildContext context, Widget page, List<Widget> children) {
  CosmosTools.to(
    context,
    CosmosSideMenu(page: page, children: children),
  );
}

class CosmosNavigation extends StatelessWidget {
  final Widget child;
  final dynamic Function(int) onTap;
  final Color backgroundColor;
  final Color inactiveColor;
  final Color activeColor;
  final int activeIndex;
  final List<IconData> icons;
  final void Function() onPressed;
  const CosmosNavigation({
    super.key,
    required this.child,
    required this.onTap,
    required this.backgroundColor,
    required this.inactiveColor,
    required this.activeColor,
    required this.activeIndex,
    required this.icons,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return MediaQuery.of(context).size.width < 800 ? mobile(context) : child;
  }

  Stack mobile(context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        SizedBox(
          width: MediaQuery.sizeOf(context).width,
          height: MediaQuery.sizeOf(context).height,
          child: child,
        ),
        SizedBox(
          height: 70,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            bottomNavigationBar: NavBar(
              activeColor: activeColor,
              activeIndex: activeIndex,
              backgroundColor: backgroundColor,
              icons: icons,
              inactiveColor: inactiveColor,
              onTap: onTap,
            ),
          ),
        ),
      ],
    );
  }
}

class NavBar extends StatefulWidget {
  final dynamic Function(int) onTap;
  final Color backgroundColor;
  final Color inactiveColor;
  final Color activeColor;
  final int activeIndex;
  final List<IconData> icons;
  const NavBar({
    super.key,
    required this.onTap,
    required this.backgroundColor,
    required this.inactiveColor,
    required this.activeColor,
    required this.activeIndex,
    required this.icons,
  });

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    return AnimatedBottomNavigationBar(
      icons: widget.icons,
      activeIndex: widget.activeIndex,
      gapLocation: GapLocation.none,
      notchSmoothness: NotchSmoothness.softEdge,
      leftCornerRadius: 32,
      rightCornerRadius: 32,
      activeColor: widget.activeColor,
      inactiveColor: widget.inactiveColor,
      backgroundColor: widget.backgroundColor,
      onTap: widget.onTap,
      //other params
    );
  }
}

class CosmosCheckBox extends StatefulWidget {
  final void Function(bool) onTap;
  final void Function(bool)? onLongPress;

  final bool? initStatus;
  const CosmosCheckBox(
      {super.key, required this.onTap, this.initStatus, this.onLongPress});

  @override
  State<CosmosCheckBox> createState() => _CosmosCheckBoxState();
}

class _CosmosCheckBoxState extends State<CosmosCheckBox> {
  bool index = false;
  @override
  void initState() {
    super.initState();
    if (widget.initStatus != null) {
      index = widget.initStatus!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () {
        index = !index;
        if (widget.onLongPress != null) {
          widget.onLongPress!(index);
          setState(() {});
        }
      },
      onTap: () {
        index = !index;
        widget.onTap(index);
        setState(() {});
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(2),
          child: Icon(
            Icons.check,
            color: index == true ? Colors.white : Colors.transparent,
            size: 10,
          ),
        ),
      ),
    );
  }
}

class CosmosInfo extends StatelessWidget {
  final Widget child;
  final String? message;
  final InlineSpan? richMessage;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? verticalOffset;
  final bool? preferBelow;
  final bool? excludeFromSemantics;
  final Decoration? decoration;
  final TextStyle? textStyle;
  final TextAlign? textAlign;
  final Duration? waitDuration;
  final Duration? showDuration;
  final TooltipTriggerMode? triggerMode;
  final bool? enableFeedback;
  final void Function()? onTriggered;
  const CosmosInfo(
      {super.key,
      required this.child,
      this.message,
      this.richMessage,
      this.height,
      this.padding,
      this.margin,
      this.verticalOffset,
      this.preferBelow,
      this.excludeFromSemantics,
      this.decoration,
      this.textStyle,
      this.textAlign,
      this.waitDuration,
      this.showDuration,
      this.triggerMode,
      this.enableFeedback,
      this.onTriggered});

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: message ?? "",
      decoration: decoration ??
          BoxDecoration(
            color: const Color.fromARGB(255, 15, 15, 15),
            borderRadius: BorderRadius.circular(5),
          ),
      enableFeedback: enableFeedback,
      excludeFromSemantics: excludeFromSemantics,
      height: height,
      margin: margin,
      padding: padding,
      onTriggered: onTriggered,
      preferBelow: preferBelow,
      richMessage: richMessage,
      showDuration: showDuration,
      textAlign: textAlign,
      textStyle: textStyle,
      triggerMode: triggerMode,
      verticalOffset: verticalOffset,
      waitDuration: waitDuration,
      child: child,
    );
  }
}
