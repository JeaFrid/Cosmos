# Cosmos Flutter Paketi ❤️

_Geliştirici: JeaFriday🎶_

## Neden Geliştirildi?

Birçok geliştiricinin çabaları sonucunda oluşturulan zorlayıcı malzemeleri bir araya getiren bu paket sayesinde, hiçbir uygulama sizi kod satırlarıyla uğraştırmayacak!

## Pakette Neler Var?

- **CosmosAlert:** IOS, Material ve özelleştirilebilir gibi seçeneklere sahip bir uyarı görüntüleyici. Ekran olarak kullanın veya sadece uyarıları gösterin.
  
- **Cosmos Button'lar:** Karmaşık düğme işleri yerine, Cosmos paketinde bulunan özelleştirilebilir ve erişimi daha kolay düğmeler.
  
- **CosmosScroller:** Otomatik kaydırılabilir bir düzen. Bu widget ile istediğiniz yönde tam bir kaydırma deneyimi elde edebilirsiniz.
  
- **CosmosBody:** 'body' özelliği için geliştirilmiş hızlı (Column) bir düzen, otomatik kaydırma sunar.
  
- **CosmosTextBox:** Tamamen özelleştirilebilir bir TextField widgeti. Kendi çerçeveleri ve özelleştirilebilir parçaları ile bir başyapıt.
  
- **CosmosFirebase:** Google Firebase için geliştirilmiş bir Flutter paketi. Veritabanına veri kaydetme, veri çekme, profil oluşturma ve çok daha fazlası.
  
- **CosmosTools:** İhtiyacınız olabilecek potansiyel araçları içeren CosmosTools.
  
- **CosmosColor:** Renk araçları.
  
- **CosmosImage:** CosmosImage ile, resimlerinizi otomatik olarak tek bir şekilde algılar, bunların bir ağ veya bir varlık olup olmadığını belirler ve buna göre görüntüler. İnternetten gelen resimleri önbelleğe kaydederek yeniden yükleme sırasında oluşabilecek gecikmeleri önler.
  
- **CosmosTelegram:** Telegram API'sını kullanarak mesaj göndermeyi kolaylaştıran bir araç.
  
- **CosmosTopBar:** Uygulamalarınız için bir üst çubuk oluşturur. Bu çubuk, duyarlı bir düzene sahiptir.
  
- **CosmosSideMenu:** Uygulamanıza bir yan menü ekler.
  
- **openSideMenu:** Yan menüyü açar.
  
- **CosmosNavigation:** Uygulamanıza alt çubuk ekleyerek, istediğiniz gibi bir alt çubuk oluşturur.
  
- **CosmosCheckBox:** Flutter paketinde bulunan aptal CheckBox yerine daha anlaşılır, basit ve çok tatlı bir CheckBox.
  
- **CosmosInfo:** Hızlı bir Tooltip.
  
- **height, width, heightPercentage, widthPercentage:** Ekran boyutu oranları ile işlemler yapmanıza olanak tanır. Biraz 'MediaQuery.sizeOf(context).width' sınıfına benzer şekilde hareket eder.


## Paket Dökümantasyonu

### CosmosBackgroundImage
Uygulamanıza arkaplan görselleri ekleyebilmek, düzenleyebilmek ve daha fazlası için bir örnek.

- **child:** Bunun üzerinden widget ağacını oluşturmaya devam edin.
- **opacity:** Görselin opaklık ayarını yapın.
- **image:** Görsel (Asset) ile arkaplan fotoğrafını seçin. 

**Örnek;**
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
Flutter uygulamanızda saat ve zamanlama hakkında işlevsel fonksiyonlar sunar.

#### CosmosTime.fromMillisecondsToDate()
Milisaniyeden, tarih-saat'e çevirir.

- **milliseconds:** Milisaniye

**Örnek;**
``` dart
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
tarih-saat'i, milisaniyeye çevirir.

- **dateTimeString:** String

**Örnek;**
``` dart
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
Şu an ki milisaniyeyi verir.

**Örnek;**
``` dart
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
Şu an ki tarih-saati verir.


**Örnek;**
``` dart
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
Klasik bir uyarı pop-up'ı getirir.

- **context:** BuildContext
- **title:** String
- **text:** String
- **buttonText:** String
- **onPressed:** void Function()

**Örnek;**
``` dart
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
IOS tipi bir uyarı pop-up'ı getirir.

- **context:** BuildContext
- **title:** String
- **text:** String
- **buttonText:** String
- **onPressed:** void Function()

**Örnek;**
``` dart
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

Özelleştirilmiş bir uyarı pop-up'ı getirir.

- **context:** BuildContext
- **child:** Widget

**Örnek;**
``` dart
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

Uygulamanızda kaydırılabilir bir widget oluşturur. Yatayda ve dikeyde, mouse ile ve dokunarak çalışabilen kaydırılabilir bir widget oluşturur.

- **scrollDirection:** Yatay mı? Dikey mi? (Axis)
- **children:** Çocuklar (List Widget)

**Örnek;**
``` dart
import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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

Duruma göre uygulamanızda kaydırılabilir bir Scaffold>body oluşturur. Yatayda ve dikeyde, mouse ile ve dokunarak çalışabilen kaydırılabilir bir widget oluşturur.

- **scrollDirection:** Yatay mı? Dikey mi? (Axis)
- **scrollable:** Kaydırılabilir mi? (bool)
- **children:** Çocuklar (List Widget)

**Örnek;**
``` dart
import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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

Hızlı bir özelleştirilebilir (Kutu) Cosmos tipinde TextField oluşturur.

- **data:** Hint yazısı (String)

**Örnek;**
``` dart
import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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

Galeriden görsel seçer.

**Örnek;**
``` dart
import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
En hızlı, performanslı ve işlevsel olarak Firebase işlemleri yapabilir.

#### CosmosFirebase.imagePickAndStoreFireStorage()
Galeriden görsel seçer, görseli Firebase Storage içerisinde işler ve geri dönüş olarak String veri tipinde görselin URL'sini döndürür.



**Örnek;**
``` dart
import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
Firebase Realtime Database içerisinde çalışan bu fonksiyon, initState içerisinde çalıştırılır. Veritabanına bir veri eklendiğinde veya silindiğinde çalışır ve mevcut son değeri döndürür.

- **reference:** String
- **onDataChanged:** void Function(Object element)

**Örnek;**
``` dart
import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

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
Firebase Realtime Database içerisinde çalışan bu fonksiyon, veritabanından bir veriyi siler.

- **ref:** String

**Örnek;**
``` dart
import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
Firebase Realtime Database içerisinde çalışan bu fonksiyon, veritabanına bir veri ekler.

- **reference:** String
- **tag:** String
- **valueList:** List

**Örnek;**
``` dart
import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
Firebase Realtime Database içerisinde çalışan bu fonksiyon, veritabanında olan bir üst kategorideki tüm verileri getirir.

- **reference:** String

**Örnek;**
``` dart
import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
Firebase Realtime Database ve Firebase Auth içerisinde çalışan bu fonksiyon, hem Firebase Auth ile bir kullanıcı oluşturur hem de Realtime Database içerisinde 'users' kategorisinde bir kullanıcı girdisi oluşturur.

- **email:** String
- **password:** String
- **userDatas:** List

**Örnek;**
``` dart
import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
Firebase Realtime Database ve Firebase Auth içerisinde çalışan bu fonksiyon, CosmosFirebase.register() ile kayıt olan kullanıcıya giriş yapar.

- **email:** String
- **password:** String

**Örnek;**
``` dart
import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
Firebase Realtime Database ve Firebase Auth içerisinde çalışan bu fonksiyon, CosmosFirebase.login() ile giriş yapan kullanıcıya çıkış yapar.


**Örnek;**
``` dart
import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
Firebase Realtime Database ve Firebase Auth içerisinde çalışan bu fonksiyon, CosmosFirebase.login() ile giriş yapan kullanıcının benzersiz kimliğini getir.


**Örnek;**
``` dart
import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
Firebase Realtime Database ve Firebase Auth içerisinde çalışan bu fonksiyon, kullanıcının giriş yapıp yapmadığını sorar ve true veya false döndürür.


**Örnek;**
``` dart
import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
Firebase Realtime Database içerisinde çalışan bu fonksiyon, veritabanından spesifik bir veriyi çeker.

- **reference:** String
- **fevalue:** bool (Her zaman true yapın.)

**Örnek;**
``` dart
import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
Bir listeyi zaman sıralamasına göre sıralar.

- **list:** List
- **index:** int (Listedeki CosmosTime.getNowTimeString() içeren ögenin sıra numarası.)

**Örnek;**
``` dart
import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

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

#### CosmosTools.to()
Sayfalar arası geçmek için direkt Widget'ı kullanır.

- **context:** BuildContext
- **page:** Widget

**Örnek;**
``` dart
import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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

#### CosmosTools.back()
Önceki sayfaya dönmek için şu an ki ekranı kapat.

- **context:** BuildContext

**Örnek;**
``` dart
import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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

#### CosmosTools.go()
Sayfalar arası geçmek için direkt rota bağlantısını kullanır.

- **context:** BuildContext
- **routeName:** String

**Örnek;**
``` dart
import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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

#### CosmosTools.allCloseAndGo()
Sayfalar arası geçerken önceki ekranı kapatır ve route ile geçiş yapar.

- **context:** BuildContext
- **routeName:** String

**Örnek;**
``` dart
import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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

#### CosmosTools.getRequestContent()
Hedeflenen bağlantıyı getirir.

- **url:** String

**Örnek;**
``` dart
import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
