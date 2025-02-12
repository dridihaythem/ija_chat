import 'package:flutter/material.dart';
import 'package:ija_chat/constants/assets.dart';

class SplashScreen extends StatefulWidget {
  final Future<void> Function() initialization;
  final VoidCallback onInitializationComplete;
  const SplashScreen({
    super.key,
    required this.initialization,
    required this.onInitializationComplete,
  });

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    widget.initialization().then((_) {
      widget.onInitializationComplete();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints(
          minWidth: MediaQuery.of(context).size.width,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    Assets.assetsImagesLogo,
                  ),
                ),
              ),
              width: 200,
              height: 200,
            ),
            const SizedBox(
              height: 18,
            ),
            const CircularProgressIndicator(
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
