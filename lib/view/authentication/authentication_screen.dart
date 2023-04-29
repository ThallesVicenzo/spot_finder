import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spot_finder/view-model/providers/authentication_provider.dart';
import '../../shared/constants.dart';
import 'widgets/authentication_button.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({super.key});

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreen();
}

class _AuthenticationScreen extends State<AuthenticationScreen> {
  @override
  Widget build(BuildContext context) {
    final authenticationProvider = AuthenticationProvider();
    return ChangeNotifierProvider(
      create: (_) => authenticationProvider,
      child: Consumer<AuthenticationProvider>(
        builder: (_, authenticationProvider, __) => Stack(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Image.asset(
                kBackground,
                fit: BoxFit.fill,
              ),
            ),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.78,
                height: MediaQuery.of(context).size.height * 0.625,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Place Rater',
                      style: Theme.of(context).primaryTextTheme.bodyLarge,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        children: [
                          AuthenticationButton(
                            title: 'Continuar com o Facebook',
                            icon: kFacebookSignIn,
                            style: Theme.of(context)
                                .primaryTextTheme
                                .bodySmall!
                                .copyWith(color: Colors.white),
                            backGroundColor: Theme.of(context).primaryColor,
                            function: () {
                              authenticationProvider
                                  .signInWithFacebook(context);
                            },
                          ),
                          AuthenticationButton(
                            title: 'Continuar com o google',
                            icon: kGoogleSignIn,
                            style: Theme.of(context)
                                .primaryTextTheme
                                .bodySmall!
                                .copyWith(color: Colors.black),
                            function: () {},
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
