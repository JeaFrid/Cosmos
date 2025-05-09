// ignore_for_file: unused_import

library cosmos;

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/gestures.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
    as datetime;
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart' as slider;
import 'package:file_picker/file_picker.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:clipboard/clipboard.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';
import 'package:encrypt/encrypt.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

///TR</br>
///Uygulamanın arkaplanına bir görsel ekler. Şeffaflık ayarı düşürüldükçe, arkaplan rengine kaynaşır.</br></br>
///US</br>
///Adds an image to the background of the application. As the transparency setting is lowered, it blends into the background color.
class CosmosBackgroundImage extends StatelessWidget {
  final Widget child;
  final double? opacity;
  final String? image;
  const CosmosBackgroundImage({
    super.key,
    required this.child,
    this.opacity,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Opacity(
                  opacity: opacity ?? 0.30,
                  child: CosmosImage(
                    image ?? "",
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
              ),
            ],
          ),
          child,
        ],
      ),
    );
  }
}

class CosmosCrypto {
  final key = encrypt.Key.fromUtf8('32characterslongpassphrasehere!!');
  String encryptText(String plainText) {
    final iv = IV.fromSecureRandom(16);
    final encrypter = Encrypter(AES(key, mode: AESMode.cbc, padding: 'PKCS7'));

    final encrypted = encrypter.encrypt(plainText, iv: iv);
    final encryptedWithIv = iv.base64 + encrypted.base64;
    return encryptedWithIv;
  }

  String decryptText(String encryptedTextWithIv) {
    final iv = IV.fromBase64(encryptedTextWithIv.substring(0, 24));
    final encryptedText = encryptedTextWithIv.substring(24);

    final encrypter = Encrypter(AES(key, mode: AESMode.cbc, padding: 'PKCS7'));
    final decrypted = encrypter.decrypt64(encryptedText, iv: iv);
    return decrypted;
  }
}

class CosmosTime {
  static DateTime getDateTime(dateTimeString) {
    DateFormat format = DateFormat('dd/MM/yyyy HH:mm:ss');
    DateTime dateTime = format.parse(dateTimeString);
    return dateTime;
  }

  static String getDateTR(DateTime dateTime) {
    String day = DateFormat.d().format(dateTime);
    String month = DateFormat.MMMM('tr').format(dateTime);
    String year = DateFormat.y().format(dateTime);
    String weekday = DateFormat.EEEE('tr').format(dateTime);

    String formattedDate =
        '$day $month $year, $weekday, ${DateFormat("HH:mm").format(dateTime)}';

    return formattedDate;
  }

  static String fromMillisecondsToDate(int milliseconds) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(milliseconds);

    String formattedDateTime =
        "${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute}:${dateTime.second}";

    return formattedDateTime;
  }

  static int getMilliseconds(String dateTimeString) {
    List<String> dateTimeParts = dateTimeString.split(" ");
    List<String> dateParts = dateTimeParts[0].split("/");
    List<String> timeParts = dateTimeParts[1].split(":");

    int year = int.parse(dateParts[2]);
    int month = int.parse(dateParts[1]);
    int day = int.parse(dateParts[0]);
    int hour = int.parse(timeParts[0]);
    int minute = int.parse(timeParts[1]);
    int second = int.parse(timeParts[2]);

    DateTime dateTime = DateTime(year, month, day, hour, minute, second);

    int millisecondsSinceEpoch = dateTime.millisecondsSinceEpoch;
    return millisecondsSinceEpoch;
  }

  static void timer(
      {required Duration duration, required void Function(Timer timer) event}) {
    Timer.periodic(duration, event);
  }

  static String day() {
    if (DateTime.now().day.toString().length == 1) {
      return "0${DateTime.now().day}";
    } else {
      return DateTime.now().day.toString();
    }
  }

  static String month() {
    if (DateTime.now().month.toString().length == 1) {
      return "0${DateTime.now().month}";
    } else {
      return DateTime.now().month.toString();
    }
  }

  static String year() {
    if (DateTime.now().year.toString().length == 1) {
      return "0${DateTime.now().year}";
    } else {
      return DateTime.now().year.toString();
    }
  }

  static String hour() {
    if (DateTime.now().hour.toString().length == 1) {
      return "0${DateTime.now().hour}";
    } else {
      return DateTime.now().hour.toString();
    }
  }

  static String minute() {
    if (DateTime.now().minute.toString().length == 1) {
      return "0${DateTime.now().minute}";
    } else {
      return DateTime.now().minute.toString();
    }
  }

  static String second() {
    if (DateTime.now().second.toString().length == 1) {
      return "0${DateTime.now().second}";
    } else {
      return DateTime.now().second.toString();
    }
  }

  static String millisecond() {
    if (DateTime.now().millisecond.toString().length == 1) {
      return "0${DateTime.now().millisecond}";
    } else {
      return DateTime.now().millisecond.toString();
    }
  }

  static String getNowTimeString() {
    return "${CosmosTime.day()}/${CosmosTime.month()}/${CosmosTime.year()} ${CosmosTime.hour()}:${CosmosTime.minute()}:${CosmosTime.second()}";
  }
}

class CosmosAlert {
  static void showToast(
    BuildContext context, {
    required Widget child,
    Color? backgroundColor,
    EdgeInsetsGeometry? margin,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 12,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(200),
        ),
        backgroundColor:
            backgroundColor ?? const Color.fromARGB(255, 16, 16, 16),
        behavior: SnackBarBehavior.floating,
        margin: margin ??
            const EdgeInsets.symmetric(
              horizontal: 150,
              vertical: 80,
            ),
        content: child,
      ),
    );
  }

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

  static loading(BuildContext context, {Color? color}) {
    return CosmosAlert.showCustomAlert(
      context,
      Scaffold(
        backgroundColor: Colors.transparent,
        body: SizedBox(
          width: width(context),
          height: height(context),
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  color: color,
                  strokeWidth: 5,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  static loadingIOS(BuildContext context, {Color? color}) {
    return CosmosAlert.showCustomAlert(
      context,
      Scaffold(
        backgroundColor: Colors.transparent,
        body: SizedBox(
          width: width(context),
          height: height(context),
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: SizedBox(
                width: 20,
                height: 20,
                child: CupertinoActivityIndicator(
                  color: color ?? Colors.white,
                  radius: 12,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  static showMessage(BuildContext context, String title, String subtitle,
      {String? button,
      Color? color,
      Color? backgroundColor,
      void Function()? onTap}) {
    return CosmosAlert.showCustomAlert(
      context,
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            width: width(context) < 600 ? widthPercentage(context, 0.8) : 400,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: backgroundColor ?? Colors.white,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: color ?? Colors.black,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        subtitle,
                        style: TextStyle(
                          color: color ?? Colors.black.withOpacity(0.7),
                          fontSize: 12,
                          overflow: TextOverflow.clip,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: onTap ??
                          () {
                            Navigator.pop(context);
                          },
                      borderRadius: BorderRadius.circular(10),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          button ?? "OK",
                          style: TextStyle(
                            color: color ?? Colors.black.withOpacity(0.7),
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ).then((value) {
      onTap!();
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
  final bool? obscureText;
  final void Function()? onEditingComplete;
  final void Function()? onTap;
  final void Function(PointerDownEvent)? onTapOutside;
  final Color? color;
  final InputBorder? focusedBorder;
  final double? cursorWidth;
  final InputBorder? enabledBorder;
  final double? cursorHeight;
  final bool? label;
  final void Function()? onPressedTabKey;
  final InputBorder? border;
  final TextStyle? labelStyle;
  final bool? readOnly;
  final int? maxLines;
  final InputDecoration? decoration;
  final double? fontSize;
  final TextInputType? keyboardType;
  final BorderRadius? borderRadius;

  const CosmosTextBox(
    this.data, {
    super.key,
    this.controller,
    this.color,
    this.borderRadius,
    this.keyboardType,
    this.maxLines,
    this.label,
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
    this.focusedBorder,
    this.enabledBorder,
    this.border,
    this.decoration,
    this.labelStyle,
    this.obscureText,
    this.onPressedTabKey,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
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
      obscureText: obscureText ?? false,
      decoration: decoration ??
          InputDecoration(
            hintStyle: TextStyle(
              fontSize: fontSize,
              color: color?.withOpacity(0.3) ?? Colors.black.withOpacity(0.3),
            ),
            labelText: label ?? false == true ? data : null,
            hintText: data,
            labelStyle: TextStyle(
              color: color?.withOpacity(0.7) ?? Colors.black.withOpacity(0.7),
            ),
            focusedBorder: focusedBorder ??
                OutlineInputBorder(
                  borderRadius: borderRadius ?? BorderRadius.circular(5),
                  borderSide: BorderSide(
                    width: 1,
                    color: color?.withOpacity(0.7) ??
                        Colors.black.withOpacity(0.7),
                  ),
                ),
            enabledBorder: enabledBorder ??
                OutlineInputBorder(
                  borderRadius: borderRadius ?? BorderRadius.circular(5),
                  borderSide: BorderSide(
                    width: 1,
                    color: color?.withOpacity(0.7) ??
                        Colors.black.withOpacity(0.7),
                  ),
                ),
            border: border ??
                OutlineInputBorder(
                  borderRadius: borderRadius ?? BorderRadius.circular(5),
                ),
          ),
    );
  }
}

Future<String?> pickImage() async {
  if (kIsWeb) {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null) {
      PlatformFile file = result.files.first;

      return file.path;
    }
    return null;
  } else {
    final picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      return pickedFile.path;
    }
  }
  return null;
}

class CosmosFirebase {
  static Future<String?> imagePickAndStoreFireStorage() async {
    if (kIsWeb) {
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
    } else {
      final picker = ImagePicker();
      final XFile? pickedFile =
          await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        String int = Random().nextInt(100000).toString();

        FirebaseStorage storage = FirebaseStorage.instance;
        Reference storageRef = storage.ref().child(int + pickedFile.name);

        try {
          TaskSnapshot snapshot =
              await storageRef.putFile(File(pickedFile.path));
          String downloadUrl = await snapshot.ref.getDownloadURL();
          return downloadUrl;
        } catch (error) {
          if (kDebugMode) {
            throw Exception("CosmosFirebase Storage Error: $error");
          }
        }
      }
    }
    return null;
  }

  static void dataChanged(
      {required String reference,
      required void Function(Object element) onDataChanged}) {
    try {
      late DatabaseReference messagesRef;
      messagesRef = FirebaseDatabase.instance.ref().child(reference);

      messagesRef.onChildAdded.listen((event) {
        var element = event.snapshot.value;
        if (element != null) {
          onDataChanged(CosmosFirebase.decode(element.toString()));
        }
      });
    } catch (e) {
      throw Exception("CosmosFirebase DataChanged Problem: $e");
    }
  }

  @Deprecated(
      'Use delete() instead. This function will be removed in the next release.')
  static void deleteData(String ref) async {
    try {
      DatabaseReference databaseReference =
          FirebaseDatabase.instance.ref().child(ref);

      await databaseReference.remove().then((_) {
        if (kDebugMode) {
          print("succesful");
        }
      }).catchError((onError) {
        if (kDebugMode) {
          print("Error: $onError");
        }
      });
    } catch (e) {
      throw Exception("CosmosFirebase $e");
    }
  }

  static Future<void> delete(
    String ref, {
    void Function()? onSuccess,
    void Function(Object e)? onError,
  }) async {
    try {
      DatabaseReference databaseReference =
          FirebaseDatabase.instance.ref().child(ref);

      await databaseReference.remove().then((_) {
        if (onSuccess != null) {
          onSuccess();
        }
      }).catchError((onError) {
        if (onError != null) {
          onError(e);
        }
      });
    } catch (e) {
      if (onError != null) {
        onError(e);
      }
      throw Exception("CosmosFirebase $e");
    }
  }

  @Deprecated(
      'Use add() instead. This function will be removed in the next release.')
  static Future<String> storeValue(
    String reference,
    String tag,
    List valueList,
    void Function()? onSuccess,
    void Function()? onError,
  ) async {
    try {
      DatabaseReference ref = FirebaseDatabase.instance.ref(reference);
      String val = CosmosFirebase.encode(valueList);
      await ref.child('"$tag"').set(val);
      if (onSuccess != null) {
        onSuccess();
      }
      return "successful";
    } catch (e) {
      if (onError != null) {
        onError();
      }
      return "error: ${e.toString()}";
    }
  }

  static Future<void> add({
    required String reference,
    required String tag,
    required List value,
    void Function()? onSuccess,
    void Function(Object e)? onError,
  }) async {
    try {
      DatabaseReference ref = FirebaseDatabase.instance.ref(reference);
      String val = CosmosFirebase.encode(value);
      await ref.child('"$tag"').set(val);
      if (onSuccess != null) {
        onSuccess();
      }
    } catch (e) {
      if (onError != null) {
        onError(e);
      }
      throw Exception("CosmosFirebase add() Problem: $e");
    }
  }

  static Future<List> getOnce(
    String reference,
  ) async {
    try {
      DatabaseReference ref = FirebaseDatabase.instance.ref(reference);
      DataSnapshot snapshot = await ref.get();

      Map mapX = snapshot.value as Map;
      List retVal = [];
      for (var i = 0; i < mapX.keys.length; i++) {
        retVal.add(CosmosFirebase.decodeAndTagAddEndElement(
            mapX.keys.elementAt(i), mapX.values.elementAt(i)));
      }
      return retVal;
    } catch (e) {
      throw Exception("CosmosFirebase getOnce() Problem: $e");
    }
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
  @Deprecated(
      'Use signUp() instead. This function will be removed in the next release.')
  static Future<List> register(
      String email, String password, List userDatas) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    try {
      var user = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await CosmosFirebase.add(
        reference: "users",
        tag: user.user!.uid,
        value: userDatas,
      );

      return [1.toString(), user.user.toString()];
    } catch (e) {
      return [0.toString(), e.toString()];
    }
  }

  static Future<void> signUp(
      {required String email,
      required String password,
      required List userDatas,
      void Function()? onSuccess,
      void Function(String error)? onError,
      bool? trError}) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    try {
      var user = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await CosmosFirebase.add(
        reference: "users",
        tag: user.user!.uid,
        value: userDatas,
      );
      if (onSuccess != null) {
        onSuccess();
      }
    } catch (e) {
      if (trError == null) {
        if (onError != null) {
          onError(e.toString());
        }
      } else if (trError == true) {
        if (e.toString().contains("invalid-email")) {
          if (onError != null) {
            onError("Geçersiz e-posta adresi");
          }
        } else if (e.toString().contains("email-already-in-use")) {
          if (onError != null) {
            onError("Bu e-posta adresiyle zaten bir hesap mevcut.");
          }
        } else if (e.toString().contains("user-not-found")) {
          if (onError != null) {
            onError("Kullanıcı bulunamadı.");
          }
        } else if (e.toString().contains("wrong-password")) {
          if (onError != null) {
            onError("Yanlış parola.");
          }
        } else if (e.toString().contains("too-many-requests")) {
          if (onError != null) {
            onError(
                "Çok fazla istek yapıldı. Tekrar denemeden önce bir süre bekleyin.");
          }
        } else if (e.toString().contains("user-disabled")) {
          if (onError != null) {
            onError("Kullanıcı devre dışı bırakıldı.");
          }
        } else if (e.toString().contains("operation-not-allowed")) {
          if (onError != null) {
            onError("Bu işlem kullanıcılar için etkinleştirilmemiş.");
          }
        } else if (e.toString().contains("network-request-failed")) {
          if (onError != null) {
            onError(
                "Ağ isteği başarısız oldu. Lütfen internet bağlantınızı kontrol edin.");
          }
        } else if (e.toString().contains("user-mismatch")) {
          if (onError != null) {
            onError(
                "Giriş yapmaya çalışırken kullanıcı e-posta adresi ve parolası eşleşmiyor.");
          }
        } else if (e.toString().contains("invalid-credential")) {
          if (onError != null) {
            onError("Geçersiz kimlik bilgisi");
          }
        } else if (e.toString().contains("app-deleted")) {
          if (onError != null) {
            onError(
                "Proje, geliştiriciler tarafından artık geliştirilmediği için giriş denemesi başarısız oldu. Lütfen geliştirici ile iletişime geçin.");
          }
        } else if (e.toString().contains("weak-password")) {
          if (onError != null) {
            onError("Şifreniz en az altı karakterden oluşmalıdır.");
          }
        } else if (e.toString().contains("invalid-verification-code")) {
          if (onError != null) {
            onError("Doğrulama kodu geçersiz veya süresi dolmuş.");
          }
        } else if (e.toString().contains("missing-verification-code")) {
          if (onError != null) {
            onError("Doğrulama kodu eksik.");
          }
        } else if (e.toString().contains("invalid-verification-id")) {
          if (onError != null) {
            onError("Geçersiz doğrulama kimliği.");
          }
        } else if (e.toString().contains("session-expired")) {
          if (onError != null) {
            onError("Oturumun süresi dolmuş.");
          }
        } else {
          if (onError != null) {
            onError("Bilinmeyen bir hata oluştu.\n\n$e");
          }
        }
      }
    }
  }

  ///Sign in with Firebase Auth. When the login is successful,
  ///</br>the first item of the returned list is 1. If it fails, it returns 0.
  ///</br>In case of success, the second item will be user.user. On failure,
  ///</br>the second item of the list returns an error message.
  @Deprecated(
      'Use signIn() instead. This function will be removed in the next release.')
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

  static Future<void> signIn(
      {required String email,
      required String password,
      void Function()? onSuccess,
      void Function(String error)? onError,
      bool? trError}) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      if (onSuccess != null) {
        onSuccess();
      }
    } catch (e) {
      if (trError == null) {
        onError != null ? onError(e.toString()) : null;
      } else if (trError == true) {
        if (e.toString().contains("invalid-email")) {
          onError != null ? onError("Geçersiz e-posta adresi") : null;
        } else if (e.toString().contains("email-already-in-use")) {
          onError != null
              ? onError("Bu e-posta adresiyle zaten bir hesap mevcut.")
              : null;
        } else if (e.toString().contains("user-not-found")) {
          onError != null ? onError("Kullanıcı bulunamadı.") : null;
        } else if (e.toString().contains("wrong-password")) {
          onError != null ? onError("Yanlış parola.") : null;
        } else if (e.toString().contains("too-many-requests")) {
          onError != null
              ? onError(
                  "Çok fazla istek yapıldı. Tekrar denemeden önce bir süre bekleyin.")
              : null;
        } else if (e.toString().contains("user-disabled")) {
          onError != null ? onError("Kullanıcı devre dışı bırakıldı.") : null;
        } else if (e.toString().contains("operation-not-allowed")) {
          onError != null
              ? onError("Bu işlem kullanıcılar için etkinleştirilmemiş.")
              : null;
        } else if (e.toString().contains("network-request-failed")) {
          onError != null
              ? onError(
                  "Ağ isteği başarısız oldu. Lütfen internet bağlantınızı kontrol edin.")
              : null;
        } else if (e.toString().contains("user-mismatch")) {
          onError != null
              ? onError(
                  "Giriş yapmaya çalışırken kullanıcı e-posta adresi ve parolası eşleşmiyor.")
              : null;
        } else if (e.toString().contains("invalid-credential")) {
          onError != null ? onError("Geçersiz kimlik bilgisi") : null;
        } else if (e.toString().contains("app-deleted")) {
          onError != null
              ? onError(
                  "Proje, geliştiriciler tarafından artık geliştirilmediği için giriş denemesi başarısız oldu. Lütfen geliştirici ile iletişime geçin.")
              : null;
        } else if (e.toString().contains("invalid-verification-code")) {
          onError != null
              ? onError("Doğrulama kodu geçersiz veya süresi dolmuş.")
              : null;
        } else if (e.toString().contains("missing-verification-code")) {
          onError != null ? onError("Doğrulama kodu eksik.") : null;
        } else if (e.toString().contains("invalid-verification-id")) {
          onError != null ? onError("Geçersiz doğrulama kimliği.") : null;
        } else if (e.toString().contains("weak-password")) {
          onError != null
              ? onError("Şifreniz en az altı karakterden oluşmalıdır.")
              : null;
        } else if (e.toString().contains("session-expired")) {
          onError != null ? onError("Oturumun süresi dolmuş.") : null;
        } else {
          onError != null ? onError("Bilinmeyen bir hata oluştu.\n\n$e") : null;
        }
      }
    }
  }

  ///Logs out of Firebase Auth.
  static Future<void> logout({
    void Function()? onSuccess,
    void Function(Object e)? onError,
  }) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    try {
      await auth.signOut();
      if (onSuccess != null) {
        onSuccess();
      }
    } catch (e) {
      if (onError != null) {
        onError(e);
      }
    }
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
    try {
      DatabaseReference ref = FirebaseDatabase.instance.ref(reference);
      DataSnapshot snapshot = await ref.get();
      if (fevalue == true) {
        return CosmosFirebase.decode(snapshot.value.toString());
      } else {
        return snapshot;
      }
    } catch (e) {
      throw Exception("CosmosFirebase get() Problem: $e");
    }
  }

  ///It finds the user in the 'users' reference from the
  ///</br>Firebase Realtime Database and returns its information
  ///</br>as a list. In order for this function to work successfully,
  ///</br>the user must be registered with [signUp].
  static Future<dynamic> getProfile({String? uid}) async {
    try {
      if (uid == null) {
        return await CosmosFirebase.get(
            'users/"${uid!.replaceAll('"', "")}"', true);
      } else {
        String uids = await CosmosFirebase.getUID();
        return await CosmosFirebase.get('users/"$uids"', true);
      }
    } catch (e) {
      throw Exception("CosmosFirebase getProfile() Problem: $e");
    }
  }
}

class CosmosTools {
  static List sortFromList(List list, int index) {
    List listCurrent = [];
    for (var element in list) {
      List elementCurrent = element;
      elementCurrent[index] =
          CosmosTime.getMilliseconds(elementCurrent[index]).toString();

      listCurrent.add(elementCurrent);
    }
    List sortList = [];
    listCurrent
        .sort((a, b) => (int.parse(a[index])).compareTo(int.parse(b[index])));
    for (var element in listCurrent) {
      List elementCurrent = element;
      elementCurrent[index] =
          CosmosTime.fromMillisecondsToDate(int.parse(elementCurrent[index]))
              .toString();
      sortList.add(elementCurrent);
    }
    return sortList;
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
}

class CosmosRandom {
  static String randomTag() {
    return CosmosTime.day() +
        CosmosTime.month() +
        CosmosTime.year() +
        CosmosTime.hour() +
        CosmosTime.minute() +
        CosmosTime.second();
  }

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
  final BoxFit? fit;
  final ImageProvider<Object>? errorImage;
  const CosmosImage(this.path,
      {super.key, this.width, this.height, this.errorImage, this.fit});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: path ?? "",
      key: UniqueKey(),
      width: width ?? 100,
      fit: fit ?? BoxFit.cover,
      height: height ?? 100,
      errorWidget: (context, error, stackTrace) {
        return Image(
          image: AssetImage(path ?? ""),
          width: width ?? 100,
          key: UniqueKey(),
          fit: fit ?? BoxFit.cover,
          height: height ?? 100,
          errorBuilder: (context, error, stackTrace) {
            return errorImage == null
                ? SizedBox(
                    width: width ?? 100,
                    height: height ?? 100,
                    child: const Placeholder(color: Colors.red),
                  )
                : Image(
                    image: errorImage ?? const AssetImage("assets/user.png"),
                    width: width ?? 100,
                    key: UniqueKey(),
                    fit: fit ?? BoxFit.cover,
                    height: height ?? 100,
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

class CosmosNavigation extends StatelessWidget {
  final bool? visible;
  final Widget child;
  final dynamic Function(int) onTap;
  final Color? backgroundColor;
  final Color? inactiveColor;
  final Color? activeColor;
  final int? activeIndex;
  final List<IconData> icons;
  final double? iconSize;

  const CosmosNavigation({
    super.key,
    required this.child,
    required this.onTap,
    this.backgroundColor,
    this.inactiveColor,
    this.activeColor,
    this.activeIndex,
    required this.icons,
    this.visible,
    this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    return MediaQuery.of(context).size.width < 800 ? mobile(context) : child;
  }

  Widget mobile(context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        SizedBox(
          width: MediaQuery.sizeOf(context).width,
          height: MediaQuery.sizeOf(context).height,
          child: child,
        ),
        Visibility(
          visible: visible ?? true,
          child: SizedBox(
            height: 70,
            child: Scaffold(
              backgroundColor: Colors.transparent,
              bottomNavigationBar: NavBar(
                iconSize: iconSize,
                activeColor: activeColor ?? Colors.black,
                activeIndex: activeIndex ?? 0,
                backgroundColor: backgroundColor ?? Colors.white,
                icons: icons,
                inactiveColor: inactiveColor ?? Colors.black38,
                onTap: onTap,
              ),
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
  final double? iconSize;
  final List<IconData> icons;
  const NavBar({
    super.key,
    required this.onTap,
    required this.backgroundColor,
    required this.inactiveColor,
    required this.activeColor,
    required this.activeIndex,
    required this.icons,
    this.iconSize,
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
      iconSize: widget.iconSize,
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
  final Color? color;
  final bool? initStatus;
  const CosmosCheckBox(
      {super.key,
      required this.onTap,
      this.initStatus,
      this.onLongPress,
      this.color});

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
            color: widget.color ?? Colors.white,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(2),
          child: Icon(
            Icons.check,
            color: index == true
                ? widget.color ?? Colors.white
                : Colors.transparent,
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

class CosmosTR {
  static List<Map<String, dynamic>> turkeyData = [
    {
      "plate": "1",
      "name": "ADANA",
      "districts": [
        {"district_id": "973", "name": "ALADA\u011e"},
        {"district_id": "974", "name": "CEYHAN"},
        {"district_id": "7595729", "name": "\u00c7UKUROVA"},
        {"district_id": "975", "name": "FEKE"},
        {"district_id": "976", "name": "\u0130MAMO\u011eLU"},
        {"district_id": "977", "name": "KARA\u0130SALI"},
        {"district_id": "978", "name": "KARATA\u015e"},
        {"district_id": "979", "name": "KOZAN"},
        {"district_id": "980", "name": "POZANTI"},
        {"district_id": "981", "name": "SA\u0130MBEYL\u0130"},
        {"district_id": "7595571", "name": "SARI\u00c7AM"},
        {"district_id": "982", "name": "SEYHAN"},
        {"district_id": "983", "name": "TUFANBEYL\u0130"},
        {"district_id": "984", "name": "YUMURTALIK"},
        {"district_id": "985", "name": "Y\u00dcRE\u011e\u0130R"}
      ]
    },
    {
      "plate": "2",
      "name": "ADIYAMAN",
      "districts": [
        {"district_id": "986", "name": "BESN\u0130"},
        {"district_id": "987", "name": "\u00c7EL\u0130KHAN"},
        {"district_id": "988", "name": "GERGER"},
        {"district_id": "989", "name": "G\u00d6LBA\u015eI"},
        {"district_id": "990", "name": "KAHTA"},
        {"district_id": "135", "name": "MERKEZ"},
        {"district_id": "991", "name": "SAMSAT"},
        {"district_id": "992", "name": "S\u0130NC\u0130K"},
        {"district_id": "993", "name": "TUT"}
      ]
    },
    {
      "plate": "3",
      "name": "AFYONKARAH\u0130SAR",
      "districts": [
        {"district_id": "994", "name": "BA\u015eMAK\u00c7I"},
        {"district_id": "995", "name": "BAYAT"},
        {"district_id": "996", "name": "BOLVAD\u0130N"},
        {"district_id": "997", "name": "\u00c7AY"},
        {"district_id": "998", "name": "\u00c7OBANLAR"},
        {"district_id": "999", "name": "DAZKIRI"},
        {"district_id": "1000", "name": "D\u0130NAR"},
        {"district_id": "1001", "name": "EM\u0130RDA\u011e"},
        {"district_id": "1002", "name": "EVC\u0130LER"},
        {"district_id": "1003", "name": "HOCALAR"},
        {"district_id": "1004", "name": "\u0130HSAN\u0130YE"},
        {"district_id": "1005", "name": "\u0130SCEH\u0130SAR"},
        {"district_id": "1006", "name": "KIZIL\u00d6REN"},
        {"district_id": "144", "name": "MERKEZ"},
        {"district_id": "1007", "name": "SANDIKLI"},
        {"district_id": "4128609", "name": "S\u0130NANPA\u015eA"},
        {"district_id": "1010", "name": "SULTANDA\u011eI"},
        {"district_id": "1009", "name": "\u015eUHUT"}
      ]
    },
    {
      "plate": "4",
      "name": "A\u011eRI",
      "districts": [
        {"district_id": "1011", "name": "D\u0130YAD\u0130N"},
        {"district_id": "1012", "name": "DO\u011eUBAYAZIT"},
        {"district_id": "1013", "name": "ELE\u015eK\u0130RT"},
        {"district_id": "1014", "name": "HAMUR"},
        {"district_id": "162", "name": "MERKEZ"},
        {"district_id": "1015", "name": "PATNOS"},
        {"district_id": "1016", "name": "TA\u015eLI\u00c7AY"},
        {"district_id": "1017", "name": "TUTAK"}
      ]
    },
    {
      "plate": "68",
      "name": "AKSARAY",
      "districts": [
        {"district_id": "1752", "name": "A\u011eA\u00c7\u00d6REN"},
        {"district_id": "1753", "name": "ESK\u0130L"},
        {"district_id": "1754", "name": "G\u00dcLA\u011eA\u00c7"},
        {"district_id": "1755", "name": "G\u00dcZELYURT"},
        {"district_id": "59829", "name": "MERKEZ"},
        {"district_id": "1756", "name": "ORTAK\u00d6Y"},
        {"district_id": "1757", "name": "SARIYAH\u015e\u0130"},
        {"district_id": "7713790", "name": "SULTANHANI"}
      ]
    },
    {
      "plate": "5",
      "name": "AMASYA",
      "districts": [
        {"district_id": "1018", "name": "G\u00d6YN\u00dcCEK"},
        {"district_id": "1019", "name": "G\u00dcM\u00dc\u015eHACIK\u00d6Y"},
        {"district_id": "1020", "name": "HAMAM\u00d6Z\u00dc"},
        {"district_id": "170", "name": "MERKEZ"},
        {"district_id": "1021", "name": "MERZ\u0130FON"},
        {"district_id": "1022", "name": "SULUOVA"},
        {"district_id": "1023", "name": "TA\u015eOVA"}
      ]
    },
    {
      "plate": "6",
      "name": "ANKARA",
      "districts": [
        {"district_id": "1024", "name": "AKYURT"},
        {"district_id": "1025", "name": "ALTINDA\u011e"},
        {"district_id": "1026", "name": "AYA\u015e"},
        {"district_id": "1027", "name": "BALA"},
        {"district_id": "1028", "name": "BEYPAZARI"},
        {"district_id": "1029", "name": "\u00c7AMLIDERE"},
        {"district_id": "1030", "name": "\u00c7ANKAYA"},
        {"district_id": "1031", "name": "\u00c7UBUK"},
        {"district_id": "1032", "name": "ELMADA\u011e"},
        {"district_id": "1033", "name": "ET\u0130MESGUT"},
        {"district_id": "1034", "name": "EVREN"},
        {"district_id": "1035", "name": "G\u00d6LBA\u015eI"},
        {"district_id": "1036", "name": "G\u00dcD\u00dcL"},
        {"district_id": "1037", "name": "HAYMANA"},
        {"district_id": "1039", "name": "KAHRAMANKAZAN"},
        {"district_id": "1038", "name": "KALEC\u0130K"},
        {"district_id": "1040", "name": "KE\u00c7\u0130\u00d6REN"},
        {"district_id": "1041", "name": "KIZILCAHAMAM"},
        {"district_id": "1042", "name": "MAMAK"},
        {"district_id": "1043", "name": "NALLIHAN"},
        {"district_id": "1044", "name": "POLATLI"},
        {"district_id": "7597869", "name": "PURSAKLAR"},
        {"district_id": "1046", "name": "S\u0130NCAN"},
        {"district_id": "1045", "name": "\u015eEREFL\u0130KO\u00c7H\u0130SAR"},
        {"district_id": "1047", "name": "YEN\u0130MAHALLE"}
      ]
    },
    {
      "plate": "7",
      "name": "ANTALYA",
      "districts": [
        {"district_id": "1048", "name": "AKSEK\u0130"},
        {"district_id": "7595783", "name": "AKSU"},
        {"district_id": "1049", "name": "ALANYA"},
        {"district_id": "1055", "name": "DEMRE"},
        {"district_id": "7595909", "name": "D\u00d6\u015eEMEALTI"},
        {"district_id": "1050", "name": "ELMALI"},
        {"district_id": "1051", "name": "F\u0130N\u0130KE"},
        {"district_id": "1052", "name": "GAZ\u0130PA\u015eA"},
        {"district_id": "1053", "name": "G\u00dcNDO\u011eMU\u015e"},
        {"district_id": "1054", "name": "\u0130BRADI"},
        {"district_id": "1056", "name": "KA\u015e"},
        {"district_id": "1057", "name": "KEMER"},
        {"district_id": "7595991", "name": "KEPEZ"},
        {"district_id": "7596032", "name": "KONYAALTI"},
        {"district_id": "1058", "name": "KORKUTEL\u0130"},
        {"district_id": "1059", "name": "KUMLUCA"},
        {"district_id": "1060", "name": "MANAVGAT"},
        {"district_id": "7596201", "name": "MURATPA\u015eA"},
        {"district_id": "1061", "name": "SER\u0130K"}
      ]
    },
    {
      "plate": "75",
      "name": "ARDAHAN",
      "districts": [
        {"district_id": "1787", "name": "\u00c7ILDIR"},
        {"district_id": "1788", "name": "DAMAL"},
        {"district_id": "1789", "name": "G\u00d6LE"},
        {"district_id": "1790", "name": "HANAK"},
        {"district_id": "86174", "name": "MERKEZ"},
        {"district_id": "1791", "name": "POSOF"}
      ]
    },
    {
      "plate": "8",
      "name": "ARTV\u0130N",
      "districts": [
        {"district_id": "1062", "name": "ARDANU\u00c7"},
        {"district_id": "1063", "name": "ARHAV\u0130"},
        {"district_id": "1064", "name": "BOR\u00c7KA"},
        {"district_id": "1065", "name": "HOPA"},
        {"district_id": "7713788", "name": "KEMALPA\u015eA"},
        {"district_id": "217", "name": "MERKEZ"},
        {"district_id": "1066", "name": "MURGUL"},
        {"district_id": "1067", "name": "\u015eAV\u015eAT"},
        {"district_id": "1068", "name": "YUSUFEL\u0130"}
      ]
    },
    {
      "plate": "9",
      "name": "AYDIN",
      "districts": [
        {"district_id": "1069", "name": "BOZDO\u011eAN"},
        {"district_id": "1070", "name": "BUHARKENT"},
        {"district_id": "1071", "name": "\u00c7\u0130NE"},
        {"district_id": "1072", "name": "D\u0130D\u0130M"},
        {"district_id": "7710125", "name": "EFELER"},
        {"district_id": "1073", "name": "GERMENC\u0130K"},
        {"district_id": "1074", "name": "\u0130NC\u0130RL\u0130OVA"},
        {"district_id": "1075", "name": "KARACASU"},
        {"district_id": "1076", "name": "KARPUZLU"},
        {"district_id": "1077", "name": "KO\u00c7ARLI"},
        {"district_id": "1078", "name": "K\u00d6\u015eK"},
        {"district_id": "1079", "name": "KU\u015eADASI"},
        {"district_id": "1080", "name": "KUYUCAK"},
        {"district_id": "1081", "name": "NAZ\u0130LL\u0130"},
        {"district_id": "1082", "name": "S\u00d6KE"},
        {"district_id": "1083", "name": "SULTANH\u0130SAR"},
        {"district_id": "1084", "name": "YEN\u0130PAZAR"}
      ]
    },
    {
      "plate": "10",
      "name": "BALIKES\u0130R",
      "districts": [
        {"district_id": "7710128", "name": "ALTIEYL\u00dcL"},
        {"district_id": "1085", "name": "AYVALIK"},
        {"district_id": "1086", "name": "BALYA"},
        {"district_id": "1087", "name": "BANDIRMA"},
        {"district_id": "1088", "name": "B\u0130GAD\u0130\u00c7"},
        {"district_id": "1089", "name": "BURHAN\u0130YE"},
        {"district_id": "1090", "name": "DURSUNBEY"},
        {"district_id": "1091", "name": "EDREM\u0130T"},
        {"district_id": "1092", "name": "ERDEK"},
        {"district_id": "1093", "name": "G\u00d6ME\u00c7"},
        {"district_id": "1094", "name": "G\u00d6NEN"},
        {"district_id": "1095", "name": "HAVRAN"},
        {"district_id": "1096", "name": "\u0130VR\u0130ND\u0130"},
        {"district_id": "7710126", "name": "KARES\u0130"},
        {"district_id": "1097", "name": "KEPSUT"},
        {"district_id": "1098", "name": "MANYAS"},
        {"district_id": "1099", "name": "MARMARA"},
        {"district_id": "1100", "name": "SAVA\u015eTEPE"},
        {"district_id": "1101", "name": "SINDIRGI"},
        {"district_id": "1102", "name": "SUSURLUK"}
      ]
    },
    {
      "plate": "74",
      "name": "BARTIN",
      "districts": [
        {"district_id": "1784", "name": "AMASRA"},
        {"district_id": "1785", "name": "KURUCA\u015e\u0130LE"},
        {"district_id": "86155", "name": "MERKEZ"},
        {"district_id": "1786", "name": "ULUS"}
      ]
    },
    {
      "plate": "72",
      "name": "BATMAN",
      "districts": [
        {"district_id": "1773", "name": "BE\u015e\u0130R\u0130"},
        {"district_id": "1774", "name": "GERC\u00dc\u015e"},
        {"district_id": "1775", "name": "HASANKEYF"},
        {"district_id": "1776", "name": "KOZLUK"},
        {"district_id": "85681", "name": "MERKEZ"},
        {"district_id": "1777", "name": "SASON"}
      ]
    },
    {
      "plate": "69",
      "name": "BAYBURT",
      "districts": [
        {"district_id": "1758", "name": "AYDINTEPE"},
        {"district_id": "1759", "name": "DEM\u0130R\u00d6Z\u00dc"},
        {"district_id": "60002", "name": "MERKEZ"}
      ]
    },
    {
      "plate": "11",
      "name": "B\u0130LEC\u0130K",
      "districts": [
        {"district_id": "1103", "name": "BOZ\u00dcY\u00dcK"},
        {"district_id": "1104", "name": "G\u00d6LPAZARI"},
        {"district_id": "1105", "name": "\u0130NH\u0130SAR"},
        {"district_id": "261", "name": "MERKEZ"},
        {"district_id": "1106", "name": "OSMANEL\u0130"},
        {"district_id": "1107", "name": "PAZARYER\u0130"},
        {"district_id": "1108", "name": "S\u00d6\u011e\u00dcT"},
        {"district_id": "1109", "name": "YEN\u0130PAZAR"}
      ]
    },
    {
      "plate": "12",
      "name": "B\u0130NG\u00d6L",
      "districts": [
        {"district_id": "1110", "name": "ADAKLI"},
        {"district_id": "1111", "name": "GEN\u00c7"},
        {"district_id": "1112", "name": "KARLIOVA"},
        {"district_id": "1113", "name": "K\u0130\u011eI"},
        {"district_id": "269", "name": "MERKEZ"},
        {"district_id": "1114", "name": "SOLHAN"},
        {"district_id": "1115", "name": "YAYLADERE"},
        {"district_id": "1116", "name": "YED\u0130SU"}
      ]
    },
    {
      "plate": "13",
      "name": "B\u0130TL\u0130S",
      "districts": [
        {"district_id": "1117", "name": "AD\u0130LCEVAZ"},
        {"district_id": "1118", "name": "AHLAT"},
        {"district_id": "1119", "name": "G\u00dcROYMAK"},
        {"district_id": "1120", "name": "H\u0130ZAN"},
        {"district_id": "277", "name": "MERKEZ"},
        {"district_id": "1121", "name": "MUTK\u0130"},
        {"district_id": "1122", "name": "TATVAN"}
      ]
    },
    {
      "plate": "14",
      "name": "BOLU",
      "districts": [
        {"district_id": "1123", "name": "D\u00d6RTD\u0130VAN"},
        {"district_id": "1124", "name": "GEREDE"},
        {"district_id": "1125", "name": "G\u00d6YN\u00dcK"},
        {"district_id": "1126", "name": "KIBRISCIK"},
        {"district_id": "1127", "name": "MENGEN"},
        {"district_id": "284", "name": "MERKEZ"},
        {"district_id": "1128", "name": "MUDURNU"},
        {"district_id": "1129", "name": "SEBEN"},
        {"district_id": "1130", "name": "YEN\u0130\u00c7A\u011eA"}
      ]
    },
    {
      "plate": "15",
      "name": "BURDUR",
      "districts": [
        {"district_id": "1131", "name": "A\u011eLASUN"},
        {"district_id": "1132", "name": "ALTINYAYLA"},
        {"district_id": "1133", "name": "BUCAK"},
        {"district_id": "1134", "name": "\u00c7AVDIR"},
        {"district_id": "1135", "name": "\u00c7ELT\u0130K\u00c7\u0130"},
        {"district_id": "1136", "name": "G\u00d6LH\u0130SAR"},
        {"district_id": "1137", "name": "KARAMANLI"},
        {"district_id": "1138", "name": "KEMER"},
        {"district_id": "300", "name": "MERKEZ"},
        {"district_id": "1139", "name": "TEFENN\u0130"},
        {"district_id": "1140", "name": "YE\u015e\u0130LOVA"}
      ]
    },
    {
      "plate": "16",
      "name": "BURSA",
      "districts": [
        {"district_id": "1141", "name": "B\u00dcY\u00dcKORHAN"},
        {"district_id": "1142", "name": "GEML\u0130K"},
        {"district_id": "1143", "name": "G\u00dcRSU"},
        {"district_id": "1144", "name": "HARMANCIK"},
        {"district_id": "1145", "name": "\u0130NEG\u00d6L"},
        {"district_id": "1146", "name": "\u0130ZN\u0130K"},
        {"district_id": "1147", "name": "KARACABEY"},
        {"district_id": "1148", "name": "KELES"},
        {"district_id": "1149", "name": "KESTEL"},
        {"district_id": "1151", "name": "MUDANYA"},
        {"district_id": "1150", "name": "MUSTAFAKEMALPA\u015eA"},
        {"district_id": "1152", "name": "N\u0130L\u00dcFER"},
        {"district_id": "1153", "name": "ORHANEL\u0130"},
        {"district_id": "1154", "name": "ORHANGAZ\u0130"},
        {"district_id": "1155", "name": "OSMANGAZ\u0130"},
        {"district_id": "1156", "name": "YEN\u0130\u015eEH\u0130R"},
        {"district_id": "1157", "name": "YILDIRIM"}
      ]
    },
    {
      "plate": "17",
      "name": "\u00c7ANAKKALE",
      "districts": [
        {"district_id": "1158", "name": "AYVACIK"},
        {"district_id": "1159", "name": "BAYRAM\u0130\u00c7"},
        {"district_id": "1160", "name": "B\u0130GA"},
        {"district_id": "1161", "name": "BOZCAADA"},
        {"district_id": "1162", "name": "\u00c7AN"},
        {"district_id": "1163", "name": "ECEABAT"},
        {"district_id": "1164", "name": "EZ\u0130NE"},
        {"district_id": "1165", "name": "GEL\u0130BOLU"},
        {"district_id": "1166", "name": "G\u00d6K\u00c7EADA"},
        {"district_id": "1167", "name": "LAPSEK\u0130"},
        {"district_id": "329", "name": "MERKEZ"},
        {"district_id": "1168", "name": "YEN\u0130CE"}
      ]
    },
    {
      "plate": "18",
      "name": "\u00c7ANKIRI",
      "districts": [
        {"district_id": "1169", "name": "ATKARACALAR"},
        {"district_id": "1170", "name": "BAYRAM\u00d6REN"},
        {"district_id": "1171", "name": "\u00c7ERKE\u015e"},
        {"district_id": "1172", "name": "ELD\u0130VAN"},
        {"district_id": "1173", "name": "ILGAZ"},
        {"district_id": "1174", "name": "KIZILIRMAK"},
        {"district_id": "1175", "name": "KORGUN"},
        {"district_id": "1176", "name": "KUR\u015eUNLU"},
        {"district_id": "341", "name": "MERKEZ"},
        {"district_id": "1177", "name": "ORTA"},
        {"district_id": "1178", "name": "\u015eABAN\u00d6Z\u00dc"},
        {"district_id": "1179", "name": "YAPRAKLI"}
      ]
    },
    {
      "plate": "19",
      "name": "\u00c7ORUM",
      "districts": [
        {"district_id": "1180", "name": "ALACA"},
        {"district_id": "1181", "name": "BAYAT"},
        {"district_id": "1182", "name": "BO\u011eAZKALE"},
        {"district_id": "1183", "name": "DODURGA"},
        {"district_id": "1184", "name": "\u0130SK\u0130L\u0130P"},
        {"district_id": "1185", "name": "KARGI"},
        {"district_id": "1186", "name": "LA\u00c7\u0130N"},
        {"district_id": "1187", "name": "MEC\u0130T\u00d6Z\u00dc"},
        {"district_id": "353", "name": "MERKEZ"},
        {"district_id": "1188", "name": "O\u011eUZLAR"},
        {"district_id": "1189", "name": "ORTAK\u00d6Y"},
        {"district_id": "1190", "name": "OSMANCIK"},
        {"district_id": "1191", "name": "SUNGURLU"},
        {"district_id": "1192", "name": "U\u011eURLUDA\u011e"}
      ]
    },
    {
      "plate": "20",
      "name": "DEN\u0130ZL\u0130",
      "districts": [
        {"district_id": "1193", "name": "ACIPAYAM"},
        {"district_id": "1195", "name": "BABADA\u011e"},
        {"district_id": "1196", "name": "BAKLAN"},
        {"district_id": "1197", "name": "BEK\u0130LL\u0130"},
        {"district_id": "1198", "name": "BEYA\u011eA\u00c7"},
        {"district_id": "1199", "name": "BOZKURT"},
        {"district_id": "1200", "name": "BULDAN"},
        {"district_id": "1201", "name": "\u00c7AL"},
        {"district_id": "1202", "name": "\u00c7AMEL\u0130"},
        {"district_id": "1203", "name": "\u00c7ARDAK"},
        {"district_id": "1204", "name": "\u00c7\u0130VR\u0130L"},
        {"district_id": "1205", "name": "G\u00dcNEY"},
        {"district_id": "1206", "name": "HONAZ"},
        {"district_id": "1207", "name": "KALE"},
        {"district_id": "7710129", "name": "MERKEZEFEND\u0130"},
        {"district_id": "1194", "name": "PAMUKKALE"},
        {"district_id": "1208", "name": "SARAYK\u00d6Y"},
        {"district_id": "1209", "name": "SER\u0130NH\u0130SAR"},
        {"district_id": "1210", "name": "TAVAS"}
      ]
    },
    {
      "plate": "21",
      "name": "D\u0130YARBAKIR",
      "districts": [
        {"district_id": "7596141", "name": "BA\u011eLAR"},
        {"district_id": "1211", "name": "B\u0130SM\u0130L"},
        {"district_id": "1212", "name": "\u00c7ERM\u0130K"},
        {"district_id": "1213", "name": "\u00c7INAR"},
        {"district_id": "1214", "name": "\u00c7\u00dcNG\u00dc\u015e"},
        {"district_id": "1215", "name": "D\u0130CLE"},
        {"district_id": "1216", "name": "E\u011e\u0130L"},
        {"district_id": "1217", "name": "ERGAN\u0130"},
        {"district_id": "1218", "name": "HAN\u0130"},
        {"district_id": "1219", "name": "HAZRO"},
        {"district_id": "7596211", "name": "KAYAPINAR"},
        {"district_id": "1220", "name": "KOCAK\u00d6Y"},
        {"district_id": "1221", "name": "KULP"},
        {"district_id": "1222", "name": "L\u0130CE"},
        {"district_id": "1223", "name": "S\u0130LVAN"},
        {"district_id": "7596268", "name": "SUR"},
        {"district_id": "7596261", "name": "YEN\u0130\u015eEH\u0130R"}
      ]
    },
    {
      "plate": "81",
      "name": "D\u00dcZCE",
      "districts": [
        {"district_id": "1815", "name": "AK\u00c7AKOCA"},
        {"district_id": "1814", "name": "CUMAYER\u0130"},
        {"district_id": "1816", "name": "\u00c7\u0130L\u0130ML\u0130"},
        {"district_id": "1817", "name": "G\u00d6LYAKA"},
        {"district_id": "1818", "name": "G\u00dcM\u00dc\u015eOVA"},
        {"district_id": "1819", "name": "KAYNA\u015eLI"},
        {"district_id": "651637", "name": "MERKEZ"},
        {"district_id": "1820", "name": "YI\u011eILCA"}
      ]
    },
    {
      "plate": "22",
      "name": "ED\u0130RNE",
      "districts": [
        {"district_id": "1224", "name": "ENEZ"},
        {"district_id": "1225", "name": "HAVSA"},
        {"district_id": "1226", "name": "\u0130PSALA"},
        {"district_id": "1227", "name": "KE\u015eAN"},
        {"district_id": "1228", "name": "LALAPA\u015eA"},
        {"district_id": "1229", "name": "MER\u0130\u00c7"},
        {"district_id": "400", "name": "MERKEZ"},
        {"district_id": "1230", "name": "S\u00dcLO\u011eLU"},
        {"district_id": "1231", "name": "UZUNK\u00d6PR\u00dc"}
      ]
    },
    {
      "plate": "23",
      "name": "ELAZI\u011e",
      "districts": [
        {"district_id": "1232", "name": "A\u011eIN"},
        {"district_id": "1233", "name": "ALACAKAYA"},
        {"district_id": "1234", "name": "ARICAK"},
        {"district_id": "1235", "name": "BASK\u0130L"},
        {"district_id": "1236", "name": "KARAKO\u00c7AN"},
        {"district_id": "1237", "name": "KEBAN"},
        {"district_id": "1238", "name": "KOVANCILAR"},
        {"district_id": "1239", "name": "MADEN"},
        {"district_id": "409", "name": "MERKEZ"},
        {"district_id": "1240", "name": "PALU"},
        {"district_id": "1241", "name": "S\u0130VR\u0130CE"}
      ]
    },
    {
      "plate": "24",
      "name": "ERZ\u0130NCAN",
      "districts": [
        {"district_id": "1242", "name": "\u00c7AYIRLI"},
        {"district_id": "1243", "name": "\u0130L\u0130\u00c7"},
        {"district_id": "1244", "name": "KEMAH"},
        {"district_id": "1245", "name": "KEMAL\u0130YE"},
        {"district_id": "420", "name": "MERKEZ"},
        {"district_id": "1246", "name": "OTLUKBEL\u0130"},
        {"district_id": "1247", "name": "REFAH\u0130YE"},
        {"district_id": "1248", "name": "TERCAN"},
        {"district_id": "1249", "name": "\u00dcZ\u00dcML\u00dc"}
      ]
    },
    {
      "plate": "25",
      "name": "ERZURUM",
      "districts": [
        {"district_id": "1250", "name": "A\u015eKALE"},
        {"district_id": "1254", "name": "AZ\u0130Z\u0130YE"},
        {"district_id": "1251", "name": "\u00c7AT"},
        {"district_id": "1252", "name": "HINIS"},
        {"district_id": "1253", "name": "HORASAN"},
        {"district_id": "1255", "name": "\u0130SP\u0130R"},
        {"district_id": "1256", "name": "KARA\u00c7OBAN"},
        {"district_id": "1257", "name": "KARAYAZI"},
        {"district_id": "1258", "name": "K\u00d6PR\u00dcK\u00d6Y"},
        {"district_id": "1259", "name": "NARMAN"},
        {"district_id": "1260", "name": "OLTU"},
        {"district_id": "1261", "name": "OLUR"},
        {"district_id": "7597483", "name": "PALAND\u00d6KEN"},
        {"district_id": "1262", "name": "PAS\u0130NLER"},
        {"district_id": "1263", "name": "PAZARYOLU"},
        {"district_id": "1264", "name": "\u015eENKAYA"},
        {"district_id": "1265", "name": "TEKMAN"},
        {"district_id": "1266", "name": "TORTUM"},
        {"district_id": "1267", "name": "UZUNDERE"},
        {"district_id": "7597507", "name": "YAKUT\u0130YE"}
      ]
    },
    {
      "plate": "26",
      "name": "ESK\u0130\u015eEH\u0130R",
      "districts": [
        {"district_id": "1268", "name": "ALPU"},
        {"district_id": "1269", "name": "BEYL\u0130KOVA"},
        {"district_id": "1270", "name": "\u00c7\u0130FTELER"},
        {"district_id": "1271", "name": "G\u00dcNY\u00dcZ\u00dc"},
        {"district_id": "1272", "name": "HAN"},
        {"district_id": "1273", "name": "\u0130N\u00d6N\u00dc"},
        {"district_id": "1274", "name": "MAHMUD\u0130YE"},
        {"district_id": "1275", "name": "M\u0130HALGAZ\u0130"},
        {"district_id": "1276", "name": "M\u0130HALI\u00c7\u00c7IK"},
        {"district_id": "7597532", "name": "ODUNPAZARI"},
        {"district_id": "1277", "name": "SARICAKAYA"},
        {"district_id": "1278", "name": "SEY\u0130TGAZ\u0130"},
        {"district_id": "1279", "name": "S\u0130VR\u0130H\u0130SAR"},
        {"district_id": "7601778", "name": "TEPEBA\u015eI"}
      ]
    },
    {
      "plate": "27",
      "name": "GAZ\u0130ANTEP",
      "districts": [
        {"district_id": "1280", "name": "ARABAN"},
        {"district_id": "1281", "name": "\u0130SLAH\u0130YE"},
        {"district_id": "1282", "name": "KARKAMI\u015e"},
        {"district_id": "1283", "name": "N\u0130Z\u0130P"},
        {"district_id": "1284", "name": "NURDA\u011eI"},
        {"district_id": "1285", "name": "O\u011eUZEL\u0130"},
        {"district_id": "1286", "name": "\u015eAH\u0130NBEY"},
        {"district_id": "1287", "name": "\u015eEH\u0130TKAM\u0130L"},
        {"district_id": "1288", "name": "YAVUZEL\u0130"}
      ]
    },
    {
      "plate": "28",
      "name": "G\u0130RESUN",
      "districts": [
        {"district_id": "1289", "name": "ALUCRA"},
        {"district_id": "1290", "name": "BULANCAK"},
        {"district_id": "1291", "name": "\u00c7AMOLUK"},
        {"district_id": "1292", "name": "\u00c7ANAK\u00c7I"},
        {"district_id": "1293", "name": "DEREL\u0130"},
        {"district_id": "1294", "name": "DO\u011eANKENT"},
        {"district_id": "1295", "name": "ESP\u0130YE"},
        {"district_id": "1296", "name": "EYNES\u0130L"},
        {"district_id": "1297", "name": "G\u00d6RELE"},
        {"district_id": "1298", "name": "G\u00dcCE"},
        {"district_id": "1299", "name": "KE\u015eAP"},
        {"district_id": "471", "name": "MERKEZ"},
        {"district_id": "1300", "name": "P\u0130RAZ\u0130Z"},
        {"district_id": "1301", "name": "\u015eEB\u0130NKARAH\u0130SAR"},
        {"district_id": "1302", "name": "T\u0130REBOLU"},
        {"district_id": "1303", "name": "YA\u011eLIDERE"}
      ]
    },
    {
      "plate": "29",
      "name": "G\u00dcM\u00dc\u015eHANE",
      "districts": [
        {"district_id": "1304", "name": "KELK\u0130T"},
        {"district_id": "1305", "name": "K\u00d6SE"},
        {"district_id": "1306", "name": "K\u00dcRT\u00dcN"},
        {"district_id": "487", "name": "MERKEZ"},
        {"district_id": "1307", "name": "\u015e\u0130RAN"},
        {"district_id": "1308", "name": "TORUL"}
      ]
    },
    {
      "plate": "30",
      "name": "HAKKAR\u0130",
      "districts": [
        {"district_id": "1309", "name": "\u00c7UKURCA"},
        {"district_id": "101814452", "name": "DEREC\u0130K"},
        {"district_id": "493", "name": "MERKEZ"},
        {"district_id": "1310", "name": "\u015eEMD\u0130NL\u0130"},
        {"district_id": "1311", "name": "Y\u00dcKSEKOVA"}
      ]
    },
    {
      "plate": "31",
      "name": "HATAY",
      "districts": [
        {"district_id": "1312", "name": "ALTIN\u00d6Z\u00dc"},
        {"district_id": "7710130", "name": "ANTAKYA"},
        {"district_id": "38952", "name": "ARSUZ"},
        {"district_id": "1313", "name": "BELEN"},
        {"district_id": "7710131", "name": "DEFNE"},
        {"district_id": "1314", "name": "D\u00d6RTYOL"},
        {"district_id": "1315", "name": "ERZ\u0130N"},
        {"district_id": "1316", "name": "HASSA"},
        {"district_id": "1317", "name": "\u0130SKENDERUN"},
        {"district_id": "1318", "name": "KIRIKHAN"},
        {"district_id": "1319", "name": "KUMLU"},
        {"district_id": "38939", "name": "PAYAS"},
        {"district_id": "1320", "name": "REYHANLI"},
        {"district_id": "1321", "name": "SAMANDA\u011e"},
        {"district_id": "1322", "name": "YAYLADA\u011eI"}
      ]
    },
    {
      "plate": "76",
      "name": "I\u011eDIR",
      "districts": [
        {"district_id": "1792", "name": "ARALIK"},
        {"district_id": "1793", "name": "KARAKOYUNLU"},
        {"district_id": "87482", "name": "MERKEZ"},
        {"district_id": "1794", "name": "TUZLUCA"}
      ]
    },
    {
      "plate": "32",
      "name": "ISPARTA",
      "districts": [
        {"district_id": "1826", "name": "AKSU"},
        {"district_id": "1323", "name": "ATABEY"},
        {"district_id": "1324", "name": "E\u011e\u0130RD\u0130R"},
        {"district_id": "1325", "name": "GELENDOST"},
        {"district_id": "1326", "name": "G\u00d6NEN"},
        {"district_id": "1327", "name": "KE\u00c7\u0130BORLU"},
        {"district_id": "509", "name": "MERKEZ"},
        {"district_id": "1329", "name": "SEN\u0130RKENT"},
        {"district_id": "1330", "name": "S\u00dcT\u00c7\u00dcLER"},
        {"district_id": "1328", "name": "\u015eARK\u0130KARAA\u011eA\u00c7"},
        {"district_id": "1331", "name": "ULUBORLU"},
        {"district_id": "1332", "name": "YALVA\u00c7"},
        {"district_id": "1333", "name": "YEN\u0130\u015eARBADEML\u0130"}
      ]
    },
    {
      "plate": "34",
      "name": "\u0130STANBUL",
      "districts": [
        {"district_id": "1343", "name": "ADALAR"},
        {"district_id": "7597625", "name": "ARNAVUTK\u00d6Y"},
        {"district_id": "7597650", "name": "ATA\u015eEH\u0130R"},
        {"district_id": "1344", "name": "AVCILAR"},
        {"district_id": "1345", "name": "BA\u011eCILAR"},
        {"district_id": "1346", "name": "BAH\u00c7EL\u0130EVLER"},
        {"district_id": "1347", "name": "BAKIRK\u00d6Y"},
        {"district_id": "7597652", "name": "BA\u015eAK\u015eEH\u0130R"},
        {"district_id": "1348", "name": "BAYRAMPA\u015eA"},
        {"district_id": "1349", "name": "BE\u015e\u0130KTA\u015e"},
        {"district_id": "1350", "name": "BEYKOZ"},
        {"district_id": "7597661", "name": "BEYL\u0130KD\u00dcZ\u00dc"},
        {"district_id": "1351", "name": "BEYO\u011eLU"},
        {"district_id": "1352", "name": "B\u00dcY\u00dcK\u00c7EKMECE"},
        {"district_id": "1353", "name": "\u00c7ATALCA"},
        {"district_id": "7597672", "name": "\u00c7EKMEK\u00d6Y"},
        {"district_id": "1355", "name": "ESENLER"},
        {"district_id": "7597688", "name": "ESENYURT"},
        {"district_id": "1356", "name": "EY\u00dcPSULTAN"},
        {"district_id": "1357", "name": "FAT\u0130H"},
        {"district_id": "1358", "name": "GAZ\u0130OSMANPA\u015eA"},
        {"district_id": "1359", "name": "G\u00dcNG\u00d6REN"},
        {"district_id": "1360", "name": "KADIK\u00d6Y"},
        {"district_id": "1361", "name": "KA\u011eITHANE"},
        {"district_id": "1362", "name": "KARTAL"},
        {"district_id": "1363", "name": "K\u00dc\u00c7\u00dcK\u00c7EKMECE"},
        {"district_id": "1364", "name": "MALTEPE"},
        {"district_id": "1365", "name": "PEND\u0130K"},
        {"district_id": "7597818", "name": "SANCAKTEPE"},
        {"district_id": "1366", "name": "SARIYER"},
        {"district_id": "1368", "name": "S\u0130L\u0130VR\u0130"},
        {"district_id": "1370", "name": "SULTANBEYL\u0130"},
        {"district_id": "7597826", "name": "SULTANGAZ\u0130"},
        {"district_id": "1367", "name": "\u015e\u0130LE"},
        {"district_id": "1369", "name": "\u015e\u0130\u015eL\u0130"},
        {"district_id": "1371", "name": "TUZLA"},
        {"district_id": "1372", "name": "\u00dcMRAN\u0130YE"},
        {"district_id": "1373", "name": "\u00dcSK\u00dcDAR"},
        {"district_id": "1374", "name": "ZEYT\u0130NBURNU"}
      ]
    },
    {
      "plate": "35",
      "name": "\u0130ZM\u0130R",
      "districts": [
        {"district_id": "1375", "name": "AL\u0130A\u011eA"},
        {"district_id": "1376", "name": "BAL\u00c7OVA"},
        {"district_id": "1377", "name": "BAYINDIR"},
        {"district_id": "7597836", "name": "BAYRAKLI"},
        {"district_id": "1378", "name": "BERGAMA"},
        {"district_id": "1379", "name": "BEYDA\u011e"},
        {"district_id": "1380", "name": "BORNOVA"},
        {"district_id": "1381", "name": "BUCA"},
        {"district_id": "1382", "name": "\u00c7E\u015eME"},
        {"district_id": "1383", "name": "\u00c7\u0130\u011eL\u0130"},
        {"district_id": "1384", "name": "D\u0130K\u0130L\u0130"},
        {"district_id": "1385", "name": "FO\u00c7A"},
        {"district_id": "1386", "name": "GAZ\u0130EM\u0130R"},
        {"district_id": "1387", "name": "G\u00dcZELBAH\u00c7E"},
        {"district_id": "7597840", "name": "KARABA\u011eLAR"},
        {"district_id": "1388", "name": "KARABURUN"},
        {"district_id": "1389", "name": "KAR\u015eIYAKA"},
        {"district_id": "1390", "name": "KEMALPA\u015eA"},
        {"district_id": "1391", "name": "KINIK"},
        {"district_id": "1392", "name": "K\u0130RAZ"},
        {"district_id": "1393", "name": "KONAK"},
        {"district_id": "1394", "name": "MENDERES"},
        {"district_id": "1395", "name": "MENEMEN"},
        {"district_id": "1396", "name": "NARLIDERE"},
        {"district_id": "1397", "name": "\u00d6DEM\u0130\u015e"},
        {"district_id": "1398", "name": "SEFER\u0130H\u0130SAR"},
        {"district_id": "1399", "name": "SEL\u00c7UK"},
        {"district_id": "1400", "name": "T\u0130RE"},
        {"district_id": "1401", "name": "TORBALI"},
        {"district_id": "1402", "name": "URLA"}
      ]
    },
    {
      "plate": "46",
      "name": "KAHRAMANMARA\u015e",
      "districts": [
        {"district_id": "1534", "name": "AF\u015e\u0130N"},
        {"district_id": "1535", "name": "ANDIRIN"},
        {"district_id": "1536", "name": "\u00c7A\u011eLAYANCER\u0130T"},
        {"district_id": "7710134", "name": "DULKAD\u0130RO\u011eLU"},
        {"district_id": "1537", "name": "EK\u0130N\u00d6Z\u00dc"},
        {"district_id": "1538", "name": "ELB\u0130STAN"},
        {"district_id": "1539", "name": "G\u00d6KSUN"},
        {"district_id": "1540", "name": "NURHAK"},
        {"district_id": "7710135", "name": "ON\u0130K\u0130\u015eUBAT"},
        {"district_id": "1541", "name": "PAZARCIK"},
        {"district_id": "1542", "name": "T\u00dcRKO\u011eLU"}
      ]
    },
    {
      "plate": "78",
      "name": "KARAB\u00dcK",
      "districts": [
        {"district_id": "1800", "name": "EFLAN\u0130"},
        {"district_id": "1801", "name": "ESK\u0130PAZAR"},
        {"district_id": "87491", "name": "MERKEZ"},
        {"district_id": "1802", "name": "OVACIK"},
        {"district_id": "1803", "name": "SAFRANBOLU"},
        {"district_id": "1804", "name": "YEN\u0130CE"}
      ]
    },
    {
      "plate": "70",
      "name": "KARAMAN",
      "districts": [
        {"district_id": "1760", "name": "AYRANCI"},
        {"district_id": "1761", "name": "BA\u015eYAYLA"},
        {"district_id": "1762", "name": "ERMENEK"},
        {"district_id": "1763", "name": "KAZIMKARABEK\u0130R"},
        {"district_id": "60042", "name": "MERKEZ"},
        {"district_id": "1764", "name": "SARIVEL\u0130LER"}
      ]
    },
    {
      "plate": "36",
      "name": "KARS",
      "districts": [
        {"district_id": "1403", "name": "AKYAKA"},
        {"district_id": "1404", "name": "ARPA\u00c7AY"},
        {"district_id": "1405", "name": "D\u0130GOR"},
        {"district_id": "1406", "name": "KA\u011eIZMAN"},
        {"district_id": "594", "name": "MERKEZ"},
        {"district_id": "1407", "name": "SARIKAMI\u015e"},
        {"district_id": "1408", "name": "SEL\u0130M"},
        {"district_id": "1409", "name": "SUSUZ"}
      ]
    },
    {
      "plate": "37",
      "name": "KASTAMONU",
      "districts": [
        {"district_id": "1410", "name": "ABANA"},
        {"district_id": "1411", "name": "A\u011eLI"},
        {"district_id": "1412", "name": "ARA\u00c7"},
        {"district_id": "1413", "name": "AZDAVAY"},
        {"district_id": "1414", "name": "BOZKURT"},
        {"district_id": "1416", "name": "C\u0130DE"},
        {"district_id": "1415", "name": "\u00c7ATALZEYT\u0130N"},
        {"district_id": "1417", "name": "DADAY"},
        {"district_id": "1418", "name": "DEVREKAN\u0130"},
        {"district_id": "1419", "name": "DO\u011eANYURT"},
        {"district_id": "1420", "name": "HAN\u00d6N\u00dc"},
        {"district_id": "1421", "name": "\u0130HSANGAZ\u0130"},
        {"district_id": "1422", "name": "\u0130NEBOLU"},
        {"district_id": "1423", "name": "K\u00dcRE"},
        {"district_id": "602", "name": "MERKEZ"},
        {"district_id": "1424", "name": "PINARBA\u015eI"},
        {"district_id": "1426", "name": "SEYD\u0130LER"},
        {"district_id": "1425", "name": "\u015eENPAZAR"},
        {"district_id": "1427", "name": "TA\u015eK\u00d6PR\u00dc"},
        {"district_id": "1428", "name": "TOSYA"}
      ]
    },
    {
      "plate": "38",
      "name": "KAYSER\u0130",
      "districts": [
        {"district_id": "1429", "name": "AKKI\u015eLA"},
        {"district_id": "1430", "name": "B\u00dcNYAN"},
        {"district_id": "1431", "name": "DEVEL\u0130"},
        {"district_id": "1432", "name": "FELAH\u0130YE"},
        {"district_id": "1433", "name": "HACILAR"},
        {"district_id": "1434", "name": "\u0130NCESU"},
        {"district_id": "1435", "name": "KOCAS\u0130NAN"},
        {"district_id": "1436", "name": "MEL\u0130KGAZ\u0130"},
        {"district_id": "1437", "name": "\u00d6ZVATAN"},
        {"district_id": "1438", "name": "PINARBA\u015eI"},
        {"district_id": "1439", "name": "SARIO\u011eLAN"},
        {"district_id": "1440", "name": "SARIZ"},
        {"district_id": "1441", "name": "TALAS"},
        {"district_id": "1442", "name": "TOMARZA"},
        {"district_id": "1443", "name": "YAHYALI"},
        {"district_id": "1444", "name": "YE\u015e\u0130LH\u0130SAR"}
      ]
    },
    {
      "plate": "71",
      "name": "KIRIKKALE",
      "districts": [
        {"district_id": "1765", "name": "BAH\u015e\u0130L\u0130"},
        {"district_id": "1766", "name": "BALI\u015eEYH"},
        {"district_id": "1767", "name": "\u00c7ELEB\u0130"},
        {"district_id": "1768", "name": "DEL\u0130CE"},
        {"district_id": "1769", "name": "KARAKE\u00c7\u0130L\u0130"},
        {"district_id": "1770", "name": "KESK\u0130N"},
        {"district_id": "60230", "name": "MERKEZ"},
        {"district_id": "1771", "name": "SULAKYURT"},
        {"district_id": "1772", "name": "YAH\u015e\u0130HAN"}
      ]
    },
    {
      "plate": "39",
      "name": "KIRKLAREL\u0130",
      "districts": [
        {"district_id": "1445", "name": "BABAESK\u0130"},
        {"district_id": "1446", "name": "DEM\u0130RK\u00d6Y"},
        {"district_id": "1447", "name": "KOF\u00c7AZ"},
        {"district_id": "1448", "name": "L\u00dcLEBURGAZ"},
        {"district_id": "639", "name": "MERKEZ"},
        {"district_id": "1449", "name": "PEHL\u0130VANK\u00d6Y"},
        {"district_id": "1450", "name": "PINARH\u0130SAR"},
        {"district_id": "1451", "name": "V\u0130ZE"}
      ]
    },
    {
      "plate": "40",
      "name": "KIR\u015eEH\u0130R",
      "districts": [
        {"district_id": "1452", "name": "AK\u00c7AKENT"},
        {"district_id": "1453", "name": "AKPINAR"},
        {"district_id": "1454", "name": "BOZTEPE"},
        {"district_id": "1455", "name": "\u00c7\u0130\u00c7EKDA\u011eI"},
        {"district_id": "1456", "name": "KAMAN"},
        {"district_id": "647", "name": "MERKEZ"},
        {"district_id": "1457", "name": "MUCUR"}
      ]
    },
    {
      "plate": "79",
      "name": "K\u0130L\u0130S",
      "districts": [
        {"district_id": "1805", "name": "ELBEYL\u0130"},
        {"district_id": "87496", "name": "MERKEZ"},
        {"district_id": "1806", "name": "MUSABEYL\u0130"},
        {"district_id": "1807", "name": "POLATEL\u0130"}
      ]
    },
    {
      "plate": "41",
      "name": "KOCAEL\u0130",
      "districts": [
        {"district_id": "7597863", "name": "BA\u015e\u0130SKELE"},
        {"district_id": "7598014", "name": "\u00c7AYIROVA"},
        {"district_id": "7598010", "name": "DARICA"},
        {"district_id": "1821", "name": "DER\u0130NCE"},
        {"district_id": "7598066", "name": "D\u0130LOVASI"},
        {"district_id": "1458", "name": "GEBZE"},
        {"district_id": "1459", "name": "G\u00d6LC\u00dcK"},
        {"district_id": "7598104", "name": "\u0130ZM\u0130T"},
        {"district_id": "1460", "name": "KANDIRA"},
        {"district_id": "1461", "name": "KARAM\u00dcRSEL"},
        {"district_id": "7598357", "name": "KARTEPE"},
        {"district_id": "1462", "name": "K\u00d6RFEZ"}
      ]
    },
    {
      "plate": "42",
      "name": "KONYA",
      "districts": [
        {"district_id": "1463", "name": "AHIRLI"},
        {"district_id": "1464", "name": "AK\u00d6REN"},
        {"district_id": "1465", "name": "AK\u015eEH\u0130R"},
        {"district_id": "1466", "name": "ALTINEK\u0130N"},
        {"district_id": "1467", "name": "BEY\u015eEH\u0130R"},
        {"district_id": "1468", "name": "BOZKIR"},
        {"district_id": "1470", "name": "C\u0130HANBEYL\u0130"},
        {"district_id": "1469", "name": "\u00c7ELT\u0130K"},
        {"district_id": "1471", "name": "\u00c7UMRA"},
        {"district_id": "1472", "name": "DERBENT"},
        {"district_id": "1473", "name": "DEREBUCAK"},
        {"district_id": "1474", "name": "DO\u011eANH\u0130SAR"},
        {"district_id": "1475", "name": "EM\u0130RGAZ\u0130"},
        {"district_id": "1476", "name": "ERE\u011eL\u0130"},
        {"district_id": "1477", "name": "G\u00dcNEYSINIR"},
        {"district_id": "1478", "name": "HAD\u0130M"},
        {"district_id": "1479", "name": "HALKAPINAR"},
        {"district_id": "1480", "name": "H\u00dcY\u00dcK"},
        {"district_id": "1481", "name": "ILGIN"},
        {"district_id": "1482", "name": "KADINHANI"},
        {"district_id": "1483", "name": "KARAPINAR"},
        {"district_id": "1484", "name": "KARATAY"},
        {"district_id": "1485", "name": "KULU"},
        {"district_id": "1486", "name": "MERAM"},
        {"district_id": "1487", "name": "SARAY\u00d6N\u00dc"},
        {"district_id": "1488", "name": "SEL\u00c7UKLU"},
        {"district_id": "1489", "name": "SEYD\u0130\u015eEH\u0130R"},
        {"district_id": "1490", "name": "TA\u015eKENT"},
        {"district_id": "1491", "name": "TUZLUK\u00c7U"},
        {"district_id": "1492", "name": "YALIH\u00dcY\u00dcK"},
        {"district_id": "1493", "name": "YUNAK"}
      ]
    },
    {
      "plate": "43",
      "name": "K\u00dcTAHYA",
      "districts": [
        {"district_id": "1494", "name": "ALTINTA\u015e"},
        {"district_id": "1495", "name": "ASLANAPA"},
        {"district_id": "1496", "name": "\u00c7AVDARH\u0130SAR"},
        {"district_id": "1497", "name": "DOMAN\u0130\u00c7"},
        {"district_id": "1498", "name": "DUMLUPINAR"},
        {"district_id": "1499", "name": "EMET"},
        {"district_id": "1500", "name": "GED\u0130Z"},
        {"district_id": "1501", "name": "H\u0130SARCIK"},
        {"district_id": "692", "name": "MERKEZ"},
        {"district_id": "1502", "name": "PAZARLAR"},
        {"district_id": "1504", "name": "S\u0130MAV"},
        {"district_id": "1503", "name": "\u015eAPHANE"},
        {"district_id": "1505", "name": "TAV\u015eANLI"}
      ]
    },
    {
      "plate": "44",
      "name": "MALATYA",
      "districts": [
        {"district_id": "1506", "name": "AK\u00c7ADA\u011e"},
        {"district_id": "1507", "name": "ARAPG\u0130R"},
        {"district_id": "1508", "name": "ARGUVAN"},
        {"district_id": "1509", "name": "BATTALGAZ\u0130"},
        {"district_id": "1510", "name": "DARENDE"},
        {"district_id": "1511", "name": "DO\u011eAN\u015eEH\u0130R"},
        {"district_id": "1512", "name": "DO\u011eANYOL"},
        {"district_id": "1513", "name": "HEK\u0130MHAN"},
        {"district_id": "1514", "name": "KALE"},
        {"district_id": "1515", "name": "KULUNCAK"},
        {"district_id": "1516", "name": "P\u00dcT\u00dcRGE"},
        {"district_id": "1517", "name": "YAZIHAN"},
        {"district_id": "1518", "name": "YE\u015e\u0130LYURT"}
      ]
    },
    {
      "plate": "45",
      "name": "MAN\u0130SA",
      "districts": [
        {"district_id": "1519", "name": "AHMETL\u0130"},
        {"district_id": "1520", "name": "AKH\u0130SAR"},
        {"district_id": "1521", "name": "ALA\u015eEH\u0130R"},
        {"district_id": "1522", "name": "DEM\u0130RC\u0130"},
        {"district_id": "1523", "name": "G\u00d6LMARMARA"},
        {"district_id": "1524", "name": "G\u00d6RDES"},
        {"district_id": "1525", "name": "KIRKA\u011eA\u00c7"},
        {"district_id": "1526", "name": "K\u00d6PR\u00dcBA\u015eI"},
        {"district_id": "1527", "name": "KULA"},
        {"district_id": "1528", "name": "SAL\u0130HL\u0130"},
        {"district_id": "1529", "name": "SARIG\u00d6L"},
        {"district_id": "1530", "name": "SARUHANLI"},
        {"district_id": "1531", "name": "SELEND\u0130"},
        {"district_id": "1532", "name": "SOMA"},
        {"district_id": "7710132", "name": "\u015eEHZADELER"},
        {"district_id": "1533", "name": "TURGUTLU"},
        {"district_id": "7710150", "name": "YUNUSEMRE"}
      ]
    },
    {
      "plate": "47",
      "name": "MARD\u0130N",
      "districts": [
        {"district_id": "7710136", "name": "ARTUKLU"},
        {"district_id": "1543", "name": "DARGE\u00c7\u0130T"},
        {"district_id": "1544", "name": "DER\u0130K"},
        {"district_id": "1545", "name": "KIZILTEPE"},
        {"district_id": "1546", "name": "MAZIDA\u011eI"},
        {"district_id": "1547", "name": "M\u0130DYAT"},
        {"district_id": "1548", "name": "NUSAYB\u0130N"},
        {"district_id": "1549", "name": "\u00d6MERL\u0130"},
        {"district_id": "1550", "name": "SAVUR"},
        {"district_id": "1551", "name": "YE\u015e\u0130LL\u0130"}
      ]
    },
    {
      "plate": "33",
      "name": "MERS\u0130N",
      "districts": [
        {"district_id": "7598432", "name": "AKDEN\u0130Z"},
        {"district_id": "1334", "name": "ANAMUR"},
        {"district_id": "1335", "name": "AYDINCIK"},
        {"district_id": "1336", "name": "BOZYAZI"},
        {"district_id": "1337", "name": "\u00c7AMLIYAYLA"},
        {"district_id": "1338", "name": "ERDEML\u0130"},
        {"district_id": "1339", "name": "G\u00dcLNAR"},
        {"district_id": "7598494", "name": "MEZ\u0130TL\u0130"},
        {"district_id": "1340", "name": "MUT"},
        {"district_id": "1341", "name": "S\u0130L\u0130FKE"},
        {"district_id": "1342", "name": "TARSUS"},
        {"district_id": "7601331", "name": "TOROSLAR"},
        {"district_id": "7601774", "name": "YEN\u0130\u015eEH\u0130R"}
      ]
    },
    {
      "plate": "48",
      "name": "MU\u011eLA",
      "districts": [
        {"district_id": "1552", "name": "BODRUM"},
        {"district_id": "1553", "name": "DALAMAN"},
        {"district_id": "1554", "name": "DAT\u00c7A"},
        {"district_id": "1555", "name": "FETH\u0130YE"},
        {"district_id": "1556", "name": "KAVAKLIDERE"},
        {"district_id": "1557", "name": "K\u00d6YCE\u011e\u0130Z"},
        {"district_id": "1558", "name": "MARMAR\u0130S"},
        {"district_id": "7710137", "name": "MENTE\u015eE"},
        {"district_id": "1559", "name": "M\u0130LAS"},
        {"district_id": "1560", "name": "ORTACA"},
        {"district_id": "39881", "name": "SEYD\u0130KEMER"},
        {"district_id": "1561", "name": "ULA"},
        {"district_id": "1562", "name": "YATA\u011eAN"}
      ]
    },
    {
      "plate": "49",
      "name": "MU\u015e",
      "districts": [
        {"district_id": "1563", "name": "BULANIK"},
        {"district_id": "1564", "name": "HASK\u00d6Y"},
        {"district_id": "1565", "name": "KORKUT"},
        {"district_id": "1566", "name": "MALAZG\u0130RT"},
        {"district_id": "767", "name": "MERKEZ"},
        {"district_id": "1567", "name": "VARTO"}
      ]
    },
    {
      "plate": "50",
      "name": "NEV\u015eEH\u0130R",
      "districts": [
        {"district_id": "1568", "name": "ACIG\u00d6L"},
        {"district_id": "1569", "name": "AVANOS"},
        {"district_id": "1570", "name": "DER\u0130NKUYU"},
        {"district_id": "1571", "name": "G\u00dcL\u015eEH\u0130R"},
        {"district_id": "1572", "name": "HACIBEKTA\u015e"},
        {"district_id": "1573", "name": "KOZAKLI"},
        {"district_id": "773", "name": "MERKEZ"},
        {"district_id": "1574", "name": "\u00dcRG\u00dcP"}
      ]
    },
    {
      "plate": "51",
      "name": "N\u0130\u011eDE",
      "districts": [
        {"district_id": "1575", "name": "ALTUNH\u0130SAR"},
        {"district_id": "1576", "name": "BOR"},
        {"district_id": "1577", "name": "\u00c7AMARDI"},
        {"district_id": "1578", "name": "\u00c7\u0130FTL\u0130K"},
        {"district_id": "781", "name": "MERKEZ"},
        {"district_id": "1579", "name": "ULUKI\u015eLA"}
      ]
    },
    {
      "plate": "52",
      "name": "ORDU",
      "districts": [
        {"district_id": "1580", "name": "AKKU\u015e"},
        {"district_id": "7710243", "name": "ALTINORDU"},
        {"district_id": "1581", "name": "AYBASTI"},
        {"district_id": "1582", "name": "\u00c7AMA\u015e"},
        {"district_id": "1583", "name": "\u00c7ATALPINAR"},
        {"district_id": "1584", "name": "\u00c7AYBA\u015eI"},
        {"district_id": "1585", "name": "FATSA"},
        {"district_id": "1586", "name": "G\u00d6LK\u00d6Y"},
        {"district_id": "1587", "name": "G\u00dcLYALI"},
        {"district_id": "1588", "name": "G\u00dcRGENTEPE"},
        {"district_id": "1589", "name": "\u0130K\u0130ZCE"},
        {"district_id": "1590", "name": "KABAD\u00dcZ"},
        {"district_id": "1591", "name": "KABATA\u015e"},
        {"district_id": "1592", "name": "KORGAN"},
        {"district_id": "1593", "name": "KUMRU"},
        {"district_id": "1594", "name": "MESUD\u0130YE"},
        {"district_id": "1595", "name": "PER\u015eEMBE"},
        {"district_id": "1596", "name": "ULUBEY"},
        {"district_id": "1597", "name": "\u00dcNYE"}
      ]
    },
    {
      "plate": "80",
      "name": "OSMAN\u0130YE",
      "districts": [
        {"district_id": "1808", "name": "BAH\u00c7E"},
        {"district_id": "1809", "name": "D\u00dcZ\u0130\u00c7\u0130"},
        {"district_id": "1810", "name": "HASANBEYL\u0130"},
        {"district_id": "1811", "name": "KAD\u0130RL\u0130"},
        {"district_id": "87498", "name": "MERKEZ"},
        {"district_id": "1812", "name": "SUMBAS"},
        {"district_id": "1813", "name": "TOPRAKKALE"}
      ]
    },
    {
      "plate": "53",
      "name": "R\u0130ZE",
      "districts": [
        {"district_id": "1598", "name": "ARDE\u015eEN"},
        {"district_id": "1599", "name": "\u00c7AMLIHEM\u015e\u0130N"},
        {"district_id": "1600", "name": "\u00c7AYEL\u0130"},
        {"district_id": "1601", "name": "DEREPAZARI"},
        {"district_id": "1602", "name": "FINDIKLI"},
        {"district_id": "1603", "name": "G\u00dcNEYSU"},
        {"district_id": "1604", "name": "HEM\u015e\u0130N"},
        {"district_id": "1605", "name": "\u0130K\u0130ZDERE"},
        {"district_id": "1606", "name": "\u0130Y\u0130DERE"},
        {"district_id": "1607", "name": "KALKANDERE"},
        {"district_id": "806", "name": "MERKEZ"},
        {"district_id": "1608", "name": "PAZAR"}
      ]
    },
    {
      "plate": "54",
      "name": "SAKARYA",
      "districts": [
        {"district_id": "7601475", "name": "ADAPAZARI"},
        {"district_id": "1609", "name": "AKYAZI"},
        {"district_id": "7601477", "name": "AR\u0130F\u0130YE"},
        {"district_id": "7601479", "name": "ERENLER"},
        {"district_id": "1610", "name": "FER\u0130ZL\u0130"},
        {"district_id": "1611", "name": "GEYVE"},
        {"district_id": "1612", "name": "HENDEK"},
        {"district_id": "1613", "name": "KARAP\u00dcR\u00c7EK"},
        {"district_id": "1614", "name": "KARASU"},
        {"district_id": "1615", "name": "KAYNARCA"},
        {"district_id": "1616", "name": "KOCAAL\u0130"},
        {"district_id": "1617", "name": "PAMUKOVA"},
        {"district_id": "1618", "name": "SAPANCA"},
        {"district_id": "7601482", "name": "SERD\u0130VAN"},
        {"district_id": "1619", "name": "S\u00d6\u011e\u00dcTL\u00dc"},
        {"district_id": "1620", "name": "TARAKLI"}
      ]
    },
    {
      "plate": "55",
      "name": "SAMSUN",
      "districts": [
        {"district_id": "1621", "name": "19 MAYIS"},
        {"district_id": "1622", "name": "ALA\u00c7AM"},
        {"district_id": "1623", "name": "ASARCIK"},
        {"district_id": "7601718", "name": "ATAKUM"},
        {"district_id": "1624", "name": "AYVACIK"},
        {"district_id": "1625", "name": "BAFRA"},
        {"district_id": "7601720", "name": "CAN\u0130K"},
        {"district_id": "1626", "name": "\u00c7AR\u015eAMBA"},
        {"district_id": "1627", "name": "HAVZA"},
        {"district_id": "7601722", "name": "\u0130LKADIM"},
        {"district_id": "1628", "name": "KAVAK"},
        {"district_id": "1629", "name": "LAD\u0130K"},
        {"district_id": "1630", "name": "SALIPAZARI"},
        {"district_id": "1631", "name": "TEKKEK\u00d6Y"},
        {"district_id": "1632", "name": "TERME"},
        {"district_id": "1633", "name": "VEZ\u0130RK\u00d6PR\u00dc"},
        {"district_id": "1634", "name": "YAKAKENT"}
      ]
    },
    {
      "plate": "56",
      "name": "S\u0130\u0130RT",
      "districts": [
        {"district_id": "1636", "name": "BAYKAN"},
        {"district_id": "1637", "name": "ERUH"},
        {"district_id": "1638", "name": "KURTALAN"},
        {"district_id": "846", "name": "MERKEZ"},
        {"district_id": "1639", "name": "PERVAR\u0130"},
        {"district_id": "1640", "name": "\u015e\u0130RVAN"},
        {"district_id": "1635", "name": "T\u0130LLO"}
      ]
    },
    {
      "plate": "57",
      "name": "S\u0130NOP",
      "districts": [
        {"district_id": "1641", "name": "AYANCIK"},
        {"district_id": "1642", "name": "BOYABAT"},
        {"district_id": "1643", "name": "D\u0130KMEN"},
        {"district_id": "1644", "name": "DURA\u011eAN"},
        {"district_id": "1645", "name": "ERFELEK"},
        {"district_id": "1646", "name": "GERZE"},
        {"district_id": "853", "name": "MERKEZ"},
        {"district_id": "1647", "name": "SARAYD\u00dcZ\u00dc"},
        {"district_id": "1648", "name": "T\u00dcRKEL\u0130"}
      ]
    },
    {
      "plate": "58",
      "name": "S\u0130VAS",
      "districts": [
        {"district_id": "1649", "name": "AKINCILAR"},
        {"district_id": "1650", "name": "ALTINYAYLA"},
        {"district_id": "1651", "name": "D\u0130VR\u0130\u011e\u0130"},
        {"district_id": "1652", "name": "DO\u011eAN\u015eAR"},
        {"district_id": "1653", "name": "GEMEREK"},
        {"district_id": "1654", "name": "G\u00d6LOVA"},
        {"district_id": "1655", "name": "G\u00dcR\u00dcN"},
        {"district_id": "1656", "name": "HAF\u0130K"},
        {"district_id": "1657", "name": "\u0130MRANLI"},
        {"district_id": "1658", "name": "KANGAL"},
        {"district_id": "1659", "name": "KOYULH\u0130SAR"},
        {"district_id": "862", "name": "MERKEZ"},
        {"district_id": "1661", "name": "SU\u015eEHR\u0130"},
        {"district_id": "1660", "name": "\u015eARKI\u015eLA"},
        {"district_id": "1662", "name": "ULA\u015e"},
        {"district_id": "1663", "name": "YILDIZEL\u0130"},
        {"district_id": "1664", "name": "ZARA"}
      ]
    },
    {
      "plate": "63",
      "name": "\u015eANLIURFA",
      "districts": [
        {"district_id": "1708", "name": "AK\u00c7AKALE"},
        {"district_id": "1709", "name": "B\u0130REC\u0130K"},
        {"district_id": "1710", "name": "BOZOVA"},
        {"district_id": "1711", "name": "CEYLANPINAR"},
        {"district_id": "7710141", "name": "EYY\u00dcB\u0130YE"},
        {"district_id": "1712", "name": "HALFET\u0130"},
        {"district_id": "7710140", "name": "HAL\u0130L\u0130YE"},
        {"district_id": "1713", "name": "HARRAN"},
        {"district_id": "1714", "name": "H\u0130LVAN"},
        {"district_id": "7710185", "name": "KARAK\u00d6PR\u00dc"},
        {"district_id": "1715", "name": "S\u0130VEREK"},
        {"district_id": "1716", "name": "SURU\u00c7"},
        {"district_id": "1717", "name": "V\u0130RAN\u015eEH\u0130R"}
      ]
    },
    {
      "plate": "73",
      "name": "\u015eIRNAK",
      "districts": [
        {"district_id": "1778", "name": "BEYT\u00dc\u015e\u015eEBAP"},
        {"district_id": "1779", "name": "C\u0130ZRE"},
        {"district_id": "1780", "name": "G\u00dc\u00c7L\u00dcKONAK"},
        {"district_id": "1781", "name": "\u0130D\u0130L"},
        {"district_id": "86131", "name": "MERKEZ"},
        {"district_id": "1782", "name": "S\u0130LOP\u0130"},
        {"district_id": "1783", "name": "ULUDERE"}
      ]
    },
    {
      "plate": "59",
      "name": "TEK\u0130RDA\u011e",
      "districts": [
        {"district_id": "1665", "name": "\u00c7ERKEZK\u00d6Y"},
        {"district_id": "1666", "name": "\u00c7ORLU"},
        {"district_id": "7710186", "name": "ERGENE"},
        {"district_id": "1667", "name": "HAYRABOLU"},
        {"district_id": "7710187", "name": "KAPAKLI"},
        {"district_id": "1668", "name": "MALKARA"},
        {"district_id": "1669", "name": "MARMARAERE\u011eL\u0130S\u0130"},
        {"district_id": "1670", "name": "MURATLI"},
        {"district_id": "1671", "name": "SARAY"},
        {"district_id": "7710143", "name": "S\u00dcLEYMANPA\u015eA"},
        {"district_id": "1672", "name": "\u015eARK\u00d6Y"}
      ]
    },
    {
      "plate": "60",
      "name": "TOKAT",
      "districts": [
        {"district_id": "1673", "name": "ALMUS"},
        {"district_id": "1674", "name": "ARTOVA"},
        {"district_id": "1675", "name": "BA\u015e\u00c7\u0130FTL\u0130K"},
        {"district_id": "1676", "name": "ERBAA"},
        {"district_id": "888", "name": "MERKEZ"},
        {"district_id": "1677", "name": "N\u0130KSAR"},
        {"district_id": "1678", "name": "PAZAR"},
        {"district_id": "1679", "name": "RE\u015eAD\u0130YE"},
        {"district_id": "1680", "name": "SULUSARAY"},
        {"district_id": "1681", "name": "TURHAL"},
        {"district_id": "1682", "name": "YE\u015e\u0130LYURT"},
        {"district_id": "1683", "name": "Z\u0130LE"}
      ]
    },
    {
      "plate": "61",
      "name": "TRABZON",
      "districts": [
        {"district_id": "1684", "name": "AK\u00c7AABAT"},
        {"district_id": "1685", "name": "ARAKLI"},
        {"district_id": "1686", "name": "ARS\u0130N"},
        {"district_id": "1687", "name": "BE\u015e\u0130KD\u00dcZ\u00dc"},
        {"district_id": "1688", "name": "\u00c7AR\u015eIBA\u015eI"},
        {"district_id": "1689", "name": "\u00c7AYKARA"},
        {"district_id": "1690", "name": "DERNEKPAZARI"},
        {"district_id": "1691", "name": "D\u00dcZK\u00d6Y"},
        {"district_id": "1692", "name": "HAYRAT"},
        {"district_id": "1693", "name": "K\u00d6PR\u00dcBA\u015eI"},
        {"district_id": "1694", "name": "MA\u00c7KA"},
        {"district_id": "1695", "name": "OF"},
        {"district_id": "7710142", "name": "ORTAH\u0130SAR"},
        {"district_id": "1697", "name": "S\u00dcRMENE"},
        {"district_id": "1696", "name": "\u015eALPAZARI"},
        {"district_id": "1698", "name": "TONYA"},
        {"district_id": "1699", "name": "VAKFIKEB\u0130R"},
        {"district_id": "1700", "name": "YOMRA"}
      ]
    },
    {
      "plate": "62",
      "name": "TUNCEL\u0130",
      "districts": [
        {"district_id": "1701", "name": "\u00c7EM\u0130\u015eGEZEK"},
        {"district_id": "1702", "name": "HOZAT"},
        {"district_id": "1703", "name": "MAZG\u0130RT"},
        {"district_id": "918", "name": "MERKEZ"},
        {"district_id": "1704", "name": "NAZIM\u0130YE"},
        {"district_id": "1705", "name": "OVACIK"},
        {"district_id": "1706", "name": "PERTEK"},
        {"district_id": "1707", "name": "P\u00dcL\u00dcM\u00dcR"}
      ]
    },
    {
      "plate": "64",
      "name": "U\u015eAK",
      "districts": [
        {"district_id": "1718", "name": "BANAZ"},
        {"district_id": "1719", "name": "E\u015eME"},
        {"district_id": "1720", "name": "KARAHALLI"},
        {"district_id": "937", "name": "MERKEZ"},
        {"district_id": "1721", "name": "S\u0130VASLI"},
        {"district_id": "1722", "name": "ULUBEY"}
      ]
    },
    {
      "plate": "65",
      "name": "VAN",
      "districts": [
        {"district_id": "1723", "name": "BAH\u00c7ESARAY"},
        {"district_id": "1724", "name": "BA\u015eKALE"},
        {"district_id": "1725", "name": "\u00c7ALDIRAN"},
        {"district_id": "1726", "name": "\u00c7ATAK"},
        {"district_id": "1727", "name": "EDREM\u0130T"},
        {"district_id": "1728", "name": "ERC\u0130\u015e"},
        {"district_id": "1729", "name": "GEVA\u015e"},
        {"district_id": "1730", "name": "G\u00dcRPINAR"},
        {"district_id": "7710138", "name": "\u0130PEKYOLU"},
        {"district_id": "1731", "name": "MURAD\u0130YE"},
        {"district_id": "1732", "name": "\u00d6ZALP"},
        {"district_id": "1733", "name": "SARAY"},
        {"district_id": "7710139", "name": "TU\u015eBA"}
      ]
    },
    {
      "plate": "77",
      "name": "YALOVA",
      "districts": [
        {"district_id": "1795", "name": "ALTINOVA"},
        {"district_id": "1796", "name": "ARMUTLU"},
        {"district_id": "1798", "name": "\u00c7INARCIK"},
        {"district_id": "1797", "name": "\u00c7\u0130FTL\u0130KK\u00d6Y"},
        {"district_id": "87489", "name": "MERKEZ"},
        {"district_id": "1799", "name": "TERMAL"}
      ]
    },
    {
      "plate": "66",
      "name": "YOZGAT",
      "districts": [
        {"district_id": "1734", "name": "AKDA\u011eMADEN\u0130"},
        {"district_id": "1735", "name": "AYDINCIK"},
        {"district_id": "1736", "name": "BO\u011eAZLIYAN"},
        {"district_id": "1737", "name": "\u00c7ANDIR"},
        {"district_id": "1738", "name": "\u00c7AYIRALAN"},
        {"district_id": "1739", "name": "\u00c7EKEREK"},
        {"district_id": "1740", "name": "KADI\u015eEHR\u0130"},
        {"district_id": "955", "name": "MERKEZ"},
        {"district_id": "1741", "name": "SARAYKENT"},
        {"district_id": "1742", "name": "SARIKAYA"},
        {"district_id": "1744", "name": "SORGUN"},
        {"district_id": "1743", "name": "\u015eEFAATL\u0130"},
        {"district_id": "1745", "name": "YEN\u0130FAKILI"},
        {"district_id": "1746", "name": "YERK\u00d6Y"}
      ]
    },
    {
      "plate": "67",
      "name": "ZONGULDAK",
      "districts": [
        {"district_id": "1747", "name": "ALAPLI"},
        {"district_id": "1748", "name": "\u00c7AYCUMA"},
        {"district_id": "1749", "name": "DEVREK"},
        {"district_id": "1751", "name": "ERE\u011eL\u0130"},
        {"district_id": "1750", "name": "G\u00d6K\u00c7EBEY"},
        {"district_id": "7710144", "name": "K\u0130L\u0130ML\u0130"},
        {"district_id": "7710393", "name": "KOZLU"},
        {"district_id": "969", "name": "MERKEZ"}
      ]
    }
  ];
  static List getCity() {
    List city = [];
    for (var element in CosmosTR.turkeyData) {
      city.add(element["name"]);
    }
    return city;
  }

  static List getCountry(String city) {
    List countryList = [];
    for (var element in CosmosTR.turkeyData) {
      if (element["name"] == city) {
        for (var element in element["districts"]) {
          countryList.add(element["name"]);
        }
      }
    }
    return countryList;
  }
}

// 29.02.2024

Future<void> copy(String text) async {
  await FlutterClipboard.copy(text);
}

Future<String> paste() async {
  return await FlutterClipboard.paste();
}

// datePicker(BuildContext context) {
//   datetime.DatePicker.showDatePicker(context,
//       showTitleActions: true,
//       theme: const datetime.DatePickerTheme(),
//       minTime: DateTime(2018, 3, 5),
//       maxTime: DateTime(2019, 6, 7), onChanged: (date) {
//     print('change $date');
//   }, onConfirm: (date) {
//     print('confirm $date');
//   }, currentTime: DateTime.now(), locale: datetime.LocaleType.tr);
// }

class CosmosOneSignal {
  static Future<String> sendTitle(String appID, String apiKey, String message,
      {String? androidSmallIcon,
      List<String>? includedSegments,
      String? priority}) async {
    final dio = Dio();

    final body = jsonEncode({
      'app_id': appID,
      'android_small_icon': androidSmallIcon ?? "ic_stat_onesignal_default",
      'included_segments': includedSegments ?? ['All'],
      'contents': {'en': message},
      'priority': priority ?? 'high',
    });

    try {
      final response = await dio.post(
        'https://onesignal.com/api/v1/notifications',
        data: body,
        options: Options(
          headers: {
            'Content-Type': 'application/json; charset=utf-8',
            'Authorization': 'Basic $apiKey', // API anahtarı
          },
        ),
      );

      if (response.statusCode == 200) {
        return "success";
      } else {
        throw Exception('CosmosOneSignal Error: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('CosmosOneSignal Error: $e');
    }
  }

  static Future<String> sendTitleAndSubtitle(
      String appID, String apiKey, String title, String message,
      {String? androidSmallIcon,
      List<String>? includedSegments,
      String? priority}) async {
    final dio = Dio();

    final body = jsonEncode({
      'app_id': appID,
      'android_small_icon': androidSmallIcon ?? "ic_stat_onesignal_default",
      'included_segments': includedSegments ?? ['All'],
      'headings': {'en': title},
      'contents': {'en': message},
      'priority': priority ?? 'high',
    });

    try {
      final response = await dio.post(
        'https://onesignal.com/api/v1/notifications',
        data: body,
        options: Options(
          headers: {
            'Content-Type': 'application/json; charset=utf-8',
            'Authorization': 'Basic $apiKey', // API anahtarı
          },
        ),
      );

      if (response.statusCode == 200) {
        return "success";
      } else {
        throw Exception('CosmosOneSignal Error: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('CosmosOneSignal Error: $e');
    }
  }
}

class CosmosSlider {
  static Widget classic(
    List data, {
    double? imageWidth,
    double? imageHeight,
    bool? autoPlay,
    Duration? autoPlayAnimationDuration,
  }) {
    return slider.CarouselSlider.builder(
      itemCount: data.length,
      options: slider.CarouselOptions(
        autoPlay: autoPlay ?? true,
        aspectRatio: 2.0,
        enlargeCenterPage: true,
        autoPlayAnimationDuration:
            autoPlayAnimationDuration ?? const Duration(milliseconds: 800),
      ),
      itemBuilder: (context, index, realIdx) {
        return Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              imageUrl: data[index],
              fit: BoxFit.cover,
              width: imageWidth ?? width(context),
              height: imageHeight ?? height(context) * 0.25,
            ),
          ),
        );
      },
    );
  }

  static Widget custom(
    List data,
    Widget Function(BuildContext context, int index, int realIdx)?
        itemBuilder, {
    bool? autoPlay,
    Duration? autoPlayAnimationDuration,
  }) {
    return slider.CarouselSlider.builder(
      itemCount: data.length,
      options: slider.CarouselOptions(
        autoPlay: autoPlay ?? true,
        aspectRatio: 2.0,
        enlargeCenterPage: true,
        autoPlayAnimationDuration:
            autoPlayAnimationDuration ?? const Duration(milliseconds: 800),
      ),
      itemBuilder: itemBuilder,
    );
  }
}

class CosmosTextSlide extends StatefulWidget {
  final List<String> items;
  final bool replay;
  final Duration? duration;
  final TextStyle? style;
  final StrutStyle? strutStyle;
  final TextAlign? textAlign;
  final Locale? locale;
  final bool? softWrap;
  final TextOverflow? overflow;
  final double? textScaleFactor;
  final TextScaler? textScaler;
  final int? maxLines;
  const CosmosTextSlide({
    super.key,
    required this.items,
    required this.replay,
    this.duration,
    this.style,
    this.strutStyle,
    this.textAlign,
    this.locale,
    this.softWrap,
    this.overflow,
    this.textScaleFactor,
    this.textScaler,
    this.maxLines,
  });

  @override
  State<CosmosTextSlide> createState() => _CosmosTextSlideState();
}

class _CosmosTextSlideState extends State<CosmosTextSlide> {
  late StreamController<String> _controller;
  late Stream<String> _stream;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = StreamController<String>();
    _stream = _controller.stream;

    _startTicker();
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }

  void _startTicker() {
    Timer.periodic(widget.duration ?? const Duration(seconds: 1), (timer) {
      if (_currentIndex < widget.items.length) {
        _controller.add(widget.items[_currentIndex]);
        _currentIndex++;
      } else {
        if (widget.replay) {
          _currentIndex = 0;
        } else {
          timer.cancel();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
      stream: _stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(
            snapshot.data!,
            style: widget.style,
            locale: widget.locale,
            maxLines: widget.maxLines,
            overflow: widget.overflow,
            softWrap: widget.softWrap,
            strutStyle: widget.strutStyle,
            textAlign: widget.textAlign,

            // ignore: deprecated_member_use
            textScaleFactor: widget.textScaleFactor,
            textScaler: widget.textScaler,
          );
        } else {
          return const Text('');
        }
      },
    );
  }
}

// class CosmosText extends StatefulWidget {
//   final String text;
//   final TextStyle style;
//   final Axis scrollAxis;
//   final double speed;

//   final void Function()? onDone;

//   const CosmosText({
//     super.key,
//     required this.text,
//     this.style = const TextStyle(fontSize: 16.0),
//     this.scrollAxis = Axis.horizontal,
//     this.speed = 70,
//     this.onDone,
//   });

//   @override
//   State<CosmosText> createState() => _CosmosTextState();
// }

// class _CosmosTextState extends State<CosmosText> {
//   @override
//   Widget build(BuildContext context) {
//     return Marquee(
//       text: widget.text,
//       style: widget.style,
//       scrollAxis: widget.scrollAxis,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       blankSpace: 20.0,
//       velocity: widget.speed,
//       pauseAfterRound: const Duration(seconds: 1),
//       startPadding: 10.0,
//       accelerationDuration: const Duration(seconds: 1),
//       accelerationCurve: Curves.linear,
//       decelerationDuration: const Duration(milliseconds: 500),
//       decelerationCurve: Curves.easeOut,
//       onDone: widget.onDone,
//     );
//   }
// }

class CosmosWeb {
  static Future<Map> get(String uri) async {
    try {
      Dio dio = Dio();
      Response response = await dio.get(uri);
      if (response.statusCode == 200) {
        return {
          "data": response.data,
          "extra": response.extra,
          "headers": response.headers,
          "isRedirect": response.isRedirect,
          "realUri": response.realUri,
          "redirects": response.redirects,
          "requestOptions": response.requestOptions,
          "statusCode": response.statusCode,
          "statusMessage": response.statusMessage,
        };
      } else {
        throw Exception("CosmosWeb/Get Error: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("CosmosWeb/Get Error: $e");
    }
  }
}

class CosmosButton {
  static Widget button(
      {required String text,
      void Function()? onTap,
      String? uri,
      EdgeInsetsGeometry? padding,
      BoxDecoration? decoration,
      Color? color,
      double? fontSize,
      double? height,
      double? width,
      EdgeInsetsGeometry? margin,
      TextStyle? style,
      Color? backgroundColor,
      BorderRadius? borderRadius}) {
    return Padding(
      padding: margin ?? const EdgeInsets.all(2),
      child: InkWell(
        onTap: uri == null
            ? onTap
            : () {
                launchUrl(Uri.parse(uri));
              },
        borderRadius: borderRadius ?? BorderRadius.circular(5),
        child: Container(
          width: width,
          height: height,
          padding:
              padding ?? const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: decoration ??
              BoxDecoration(
                color: backgroundColor ?? Colors.blue.withOpacity(0.5),
                borderRadius: borderRadius ?? BorderRadius.circular(5),
              ),
          child: Text(
            text,
            style: style ??
                TextStyle(
                  color: color ?? Colors.white,
                  fontSize: fontSize ?? 12,
                ),
          ),
        ),
      ),
    );
  }

  static Widget borderButton(
      {required String text,
      void Function()? onTap,
      String? uri,
      double? height,
      double? width,
      double? borderWidth,
      EdgeInsetsGeometry? padding,
      BoxDecoration? decoration,
      EdgeInsetsGeometry? margin,
      Color? color,
      double? fontSize,
      TextStyle? style,
      Color? borderColor,
      BorderRadius? borderRadius}) {
    return Padding(
      padding: margin ?? const EdgeInsets.all(2),
      child: InkWell(
        onTap: uri == null
            ? onTap
            : () {
                launchUrl(Uri.parse(uri));
              },
        borderRadius: borderRadius ?? BorderRadius.circular(5),
        child: Container(
          width: width,
          height: height,
          padding:
              padding ?? const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: decoration ??
              BoxDecoration(
                border: Border.all(
                  color: borderColor ?? Colors.blue,
                  width: borderWidth ?? 1,
                ),
                borderRadius: borderRadius ?? BorderRadius.circular(5),
              ),
          child: Text(
            text,
            style: style ??
                TextStyle(
                  color: color ?? Colors.white,
                  fontSize: fontSize ?? 12,
                ),
          ),
        ),
      ),
    );
  }

  static Widget iconButton(
      {required IconData icon,
      void Function()? onTap,
      String? uri,
      double? height,
      double? width,
      EdgeInsetsGeometry? padding,
      BoxDecoration? decoration,
      EdgeInsetsGeometry? margin,
      Color? color,
      Color? backgroundColor,
      double? size,
      Color? borderColor,
      BorderRadius? borderRadius}) {
    return Padding(
      padding: margin ?? const EdgeInsets.all(2),
      child: InkWell(
        onTap: uri == null
            ? onTap
            : () {
                launchUrl(Uri.parse(uri));
              },
        borderRadius: borderRadius ?? BorderRadius.circular(1020),
        child: Container(
          width: width,
          height: height,
          padding: padding ?? const EdgeInsets.all(8),
          decoration: decoration ??
              BoxDecoration(
                borderRadius: borderRadius ?? BorderRadius.circular(1020),
                color: backgroundColor ?? Colors.blue.withOpacity(0.5),
              ),
          child: Icon(
            icon,
            color: color ?? Colors.white,
            size: size ?? 12,
          ),
        ),
      ),
    );
  }
}

class CosmosSideMenu {
  static PageController pageController = PageController(initialPage: 1);
  static Future<void> openSideMenu() async {
    await pageController.previousPage(
      duration: const Duration(milliseconds: 200),
      curve: Curves.linear,
    );
  }

  static Future<void> closeSideMenu() async {
    await pageController.nextPage(
      duration: const Duration(milliseconds: 200),
      curve: Curves.linear,
    );
  }

  static Widget builder({
    required Widget sideMenu,
    required Widget home,
  }) {
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        pageController.position
            .moveTo(pageController.position.pixels - details.delta.dx);
      },
      child: PageView(
        controller: pageController,
        children: [
          sideMenu,
          home,
        ],
      ),
    );
  }

  static Widget sideMenu(
      {required List<Widget> children,
      bool? scrollable,
      Color? backgroundColor}) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: CosmosBody(
        scrollable: scrollable ?? true,
        scrollDirection: Axis.vertical,
        children: children,
      ),
    );
  }
}

class CosmosNavigator {
  static Future<T?> pushFromRightToLeft<T extends Object?>(
    BuildContext context,
    Widget route, {
    Duration? transitionDuration,
  }) async {
    return Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
        ) {
          return route;
        },
        transitionsBuilder: (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
          Widget child,
        ) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 200),
      ),
    );
  }

  static Future<T?> pushFromLeftToRight<T extends Object?>(
    BuildContext context,
    Widget route, {
    Duration? transitionDuration,
  }) async {
    return Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
        ) {
          return route;
        },
        transitionsBuilder: (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
          Widget child,
        ) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(-1.0, 0.0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 200),
      ),
    );
  }

  static Future<T?> pushDownFromTop<T extends Object?>(
    BuildContext context,
    Widget route, {
    Duration? transitionDuration,
  }) async {
    return Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
        ) {
          return route;
        },
        transitionsBuilder: (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
          Widget child,
        ) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0.0, -1.0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 200),
      ),
    );
  }

  static Future<T?> pushTopFromDown<T extends Object?>(
    BuildContext context,
    Widget route, {
    Duration? transitionDuration,
  }) async {
    return Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
        ) {
          return route;
        },
        transitionsBuilder: (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
          Widget child,
        ) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0.0, 1.0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 200),
      ),
    );
  }

  ///Switches from the current screen to the target screen.
  static Future<T?> pushNonAnimated<T extends Object?>(
      BuildContext context, Widget page) {
    return Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionDuration: const Duration(
          milliseconds: 0,
        ),
        transitionsBuilder: (
          context,
          animation,
          secondaryAnimation,
          child,
        ) {
          return child;
        },
      ),
    );
  }

  //REPLACE;

  static Future<T?> pushFromRightToLeftReplacement<T extends Object?>(
    BuildContext context,
    Widget route, {
    Duration? transitionDuration,
  }) async {
    return Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
        ) {
          return route;
        },
        transitionsBuilder: (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
          Widget child,
        ) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 200),
      ),
    );
  }

  static Future<T?> pushFromLeftToRightReplacement<T extends Object?>(
    BuildContext context,
    Widget route, {
    Duration? transitionDuration,
  }) async {
    return Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
        ) {
          return route;
        },
        transitionsBuilder: (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
          Widget child,
        ) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(-1.0, 0.0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 200),
      ),
    );
  }

  static Future<T?> pushDownFromTopReplacement<T extends Object?>(
    BuildContext context,
    Widget route, {
    Duration? transitionDuration,
  }) async {
    return Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
        ) {
          return route;
        },
        transitionsBuilder: (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
          Widget child,
        ) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0.0, -1.0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 200),
      ),
    );
  }

  static Future<T?> pushTopFromDownReplacement<T extends Object?>(
    BuildContext context,
    Widget route, {
    Duration? transitionDuration,
  }) async {
    return Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
        ) {
          return route;
        },
        transitionsBuilder: (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
          Widget child,
        ) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0.0, 1.0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 200),
      ),
    );
  }

  ///Switches from the current screen to the target screen.
  static Future<T?> pushNonAnimatedReplacement<T extends Object?>(
      BuildContext context, Widget page) {
    return Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionDuration: const Duration(
          milliseconds: 0,
        ),
        transitionsBuilder: (
          context,
          animation,
          secondaryAnimation,
          child,
        ) {
          return child;
        },
      ),
    );
  }

  ///Close this screen and return to the previous screen.
  static void pop(BuildContext context) {
    Navigator.pop(context);
  }
}

class CosmosMenu {
  static Widget builder(
    BuildContext context, {
    required List<PopupMenuEntry<dynamic>> items,
    required Widget child,
    Color? backgroundColor,
  }) {
    return GestureDetector(
      onTapDown: (details) {
        double left = details.globalPosition.dx;
        double top = details.globalPosition.dy;
        double right = width(context) - left;
        double bottom = height(context) - top;
        showMenu(
          shadowColor: Colors.black,
          elevation: 4,
          surfaceTintColor: backgroundColor ?? Colors.black,
          color: backgroundColor ?? Colors.black,
          context: context,
          position: RelativeRect.fromLTRB(left, top, right, bottom),
          items: items,
        );
      },
      child: child,
    );
  }

  static PopupMenuItem iconItem(
    IconData icon,
    String text, {
    void Function()? onTap,
    Color? textColor,
  }) {
    return PopupMenuItem(
      height: 1,
      padding: const EdgeInsets.all(8),
      onTap: onTap,
      child: Row(
        children: [
          Icon(
            icon,
            color: textColor,
            size: 12,
          ),
          const SizedBox(width: 5),
          Text(
            text,
            style: TextStyle(
              color: textColor,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  static PopupMenuItem item(
    String text, {
    void Function()? onTap,
    Color? textColor,
  }) {
    return PopupMenuItem(
      height: 1,
      padding: const EdgeInsets.all(8),
      onTap: onTap,
      child: Row(
        children: [
          const SizedBox(width: 5),
          Text(
            text,
            style: TextStyle(
              color: textColor,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

class CosmosLinkText extends StatelessWidget {
  final String text;
  final int? maxLines;
  final TextStyle? style;
  final TextOverflow? overflow;
  final Future<void> Function(String link)? onTapLink;

  const CosmosLinkText({
    super.key,
    required this.text,
    this.maxLines,
    this.style,
    this.onTapLink,
    this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      maxLines: maxLines,
      overflow: maxLines == null ? TextOverflow.clip : TextOverflow.ellipsis,
      text: TextSpan(
        children: _parseText(text),
        style: const TextStyle(
          color: Colors.grey,
        ),
      ),
    );
  }

  List<TextSpan> _parseText(String text) {
    List<TextSpan> spans = [];
    RegExp linkRegex = RegExp(r"(?:https?|ftp):\/\/[\w/\-?=%.]+\.[\w/\-?=%.]+",
        caseSensitive: false);

    text.splitMapJoin(linkRegex, onMatch: (match) {
      String link = match.group(0)!;
      spans.add(TextSpan(
          text: link,
          style: const TextStyle(
            color: Colors.blue,
          ),
          recognizer: TapGestureRecognizer()
            ..onTap = () async {
              await onTapLink!(link);
            }));
      return '';
    }, onNonMatch: (nonMatch) {
      spans.add(TextSpan(text: nonMatch));
      return '';
    });

    return spans;
  }
}

Future<bool> openUrl(String url) async {
  return await launchUrl(Uri.parse(url));
}
