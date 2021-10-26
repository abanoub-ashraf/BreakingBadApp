import 'package:breaking_bad_app/routes/app_router.dart';
import 'package:flutter/material.dart';

class AppWidget extends StatelessWidget {
    final AppRouter appRouter;

    const AppWidget({ 
        Key? key, 
        required this.appRouter 
    }) : super(key: key);
    
    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            ///
            /// to hide the debug badge that appears on the top right corner
            /// of the phone screen
            ///
            debugShowCheckedModeBanner: false,
            ///
            /// this generateRoute() function will configure the routing
            /// in the app through this appRouter class
            ///
            onGenerateRoute: appRouter.generateRoute,
        );
    }
}