import 'package:flutter/material.dart';
import 'package:justnow/ui/screens/Auth/login.dart';
import 'package:justnow/ui/screens/home_screen.dart';
import 'package:justnow/ui/theme/app_theme.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class JustNow extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _JustNowState createState() => _JustNowState();
}

class _JustNowState extends State<JustNow> {
  @override
  Widget build(BuildContext context) => ScreenUtilInit(
        designSize: ScreenUtil.defaultSize,
        allowFontScaling: false,
        builder: () => ChangeNotifierProvider(
          create: (context) => SysTheme(),
          builder: (context, _) {
            final sysTheme = Provider.of<SysTheme>(context);

            return MaterialApp(
              title: 'JustNow',
              debugShowCheckedModeBanner: false,
              themeMode: sysTheme.themeMode,
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              home: LoginPage(),
            );
          },
        ),
      );
}

class ChangeThemeButtonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final sysTheme = Provider.of<SysTheme>(context);

    return Switch.adaptive(
      value: sysTheme.isDarkMode,
      onChanged: (value) {
        final provider = Provider.of<SysTheme>(context, listen: false);
        provider.toggleTheme(value);
      },
    );
  }
}
