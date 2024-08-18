import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';

void main() => runApp(const CosmosExample());

class CosmosExample extends StatelessWidget {
  const CosmosExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Cosmos Example App',
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: CosmosBody(
        scrollable: true,
        scrollDirection: Axis.vertical,
        children: [
          CosmosTopBar(
            logo: const Text(
              "Cosmos!",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.white,
              ),
            ),
            leftIcon: Icons.menu,
            rightIcon: Icons.whatshot,
            children: [
              CosmosButton.button(
                text: "Classic Button",
                onTap: () {},
              ),
              CosmosButton.borderButton(
                text: "Border Button",
                onTap: () {},
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                width: 2,
                height: 20,
                color: Colors.white,
              ),
              CosmosButton.iconButton(
                icon: Icons.link,
                uri: "https://bybug.net",
              ),
              CosmosButton.iconButton(
                icon: Icons.menu,
                onTap: () {
                  CosmosSideMenu.openSideMenu();
                },
              ),
              CosmosButton.iconButton(
                icon: Icons.person,
                uri: "https://bybug.net",
              ),
            ],
          ),
          CosmosButton.borderButton(
            text: "Go to NewPage! (pushFromRightToLeft)",
            onTap: () {
              CosmosNavigator.pushFromRightToLeft(
                context,
                const NewPage(),
              );
            },
          ),
          CosmosButton.borderButton(
            text: "Go to NewPage! (pushFromLeftToRight)",
            onTap: () {
              CosmosNavigator.pushFromLeftToRight(
                context,
                const NewPage(),
              );
            },
          ),
          CosmosButton.borderButton(
            text: "Go to NewPage! (pushDownFromTop)",
            onTap: () {
              CosmosNavigator.pushDownFromTop(
                context,
                const NewPage(),
              );
            },
          ),
          CosmosButton.borderButton(
            text: "Go to NewPage! (pushTopFromDown)",
            onTap: () {
              CosmosNavigator.pushTopFromDown(
                context,
                const NewPage(),
              );
            },
          ),
          CosmosButton.borderButton(
            text: "Go to NewPage! (pushNonAnimated)",
            onTap: () {
              CosmosNavigator.pushNonAnimated(
                context,
                const NewPage(),
              );
            },
          ),
          CosmosButton.borderButton(
            text: "Show Toast",
            onTap: () {
              CosmosAlert.showToast(
                context,
                child: const Center(
                  child: Text(
                    "Hello World!",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.all(14),
            child: SizedBox(
              width: width(context) * 0.7,
              child: CosmosLinkText(
                text:
                    "Quis incididunt ex magna anim aute. Ullamco aute consectetur commodo dolor nostrud aliqua laboris in sint do voluptate. Laboris elit ea consectetur commodo aliqua ut est laborum ipsum labore. Et voluptate proident laboris nulla magna.\n\nhttps://bybug.net",
                onTapLink: (link) async {
                  await openUrl(link);
                },
              ),
            ),
          ),
          CosmosButton.borderButton(
            text: "Show IOS Alert",
            onTap: () {
              CosmosAlert.loadingIOS(context);
            },
          ),
          CosmosMenu.builder(
            context,
            backgroundColor: Colors.brown,
            items: [
              CosmosMenu.iconItem(
                Icons.home,
                "Home",
                textColor: Colors.white,
              ),
              CosmosMenu.iconItem(
                Icons.edit,
                "Edit",
                textColor: Colors.white,
              ),
              CosmosMenu.iconItem(
                Icons.person,
                "Profile",
                textColor: Colors.white,
              ),
            ],
            child: CosmosButton.borderButton(
              text: "Icon Menu",
            ),
          ),
          CosmosMenu.builder(
            context,
            backgroundColor: Colors.brown,
            items: [
              CosmosMenu.item(
                "Home",
                textColor: Colors.white,
              ),
              CosmosMenu.item(
                "Edit",
                textColor: Colors.white,
              ),
              CosmosMenu.item(
                "Profile",
                textColor: Colors.white,
              ),
            ],
            child: CosmosButton.borderButton(
              text: "Menu",
            ),
          ),
        ],
      ),
    );
  }
}

class NewPage extends StatelessWidget {
  const NewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.purple,
      body: Center(
        child: Text(
          "New Page!",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
