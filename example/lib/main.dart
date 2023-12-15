import 'package:cosmos/cosmos.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Cosmos Tutorial',
      home: CosmosAlertTest(),
    );
  }
}

class CosmosAlertTest extends StatelessWidget {
  const CosmosAlertTest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CosmosColor.hex("ffffff"),
      body: PopScope(
        
        child: Center(
          child: CosmosScroller(
            scrollDirection: Axis.vertical,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CosmosButtonIcon(
                    iconData: Icons.android,
                    text: "Android Alert",
                    onTap: () async {
                      CosmosAlert.showAnimatedDialog(
                        context,
                        "title",
                        "text",
                      );
                    },
                  ),
                ],
              ),
              CosmosButton(
                "IOS Alert",
                onTap: () {
                  CosmosAlert.showIOSStyleAlert(
                    context,
                    "title",
                    "text",
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 400,
                  child: CosmosTextBox(
                    "data",
                    onChanged: (p0) {
                      if (kDebugMode) {
                        print(p0);
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
