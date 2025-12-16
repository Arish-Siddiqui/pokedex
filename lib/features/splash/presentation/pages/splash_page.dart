import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/presentation/widgets/widgets.dart';
import '../provider/splash_provider.dart';

class SplashPage extends HookConsumerWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      Future.microtask(() => ref.read(splashProvider.notifier).goToNextPage());
      return null;
    }, []);

    return Scaffold(body: buildBody(context));
  }

  Widget buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: const LogoWidget(),
    );
  }
}
