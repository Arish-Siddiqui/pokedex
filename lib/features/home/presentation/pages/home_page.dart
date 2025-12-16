import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../config/multi_language/multi_language.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/presentation/widgets/widgets.dart';
import '../../domain/entities/pokemon.dart';
import '../provider/home_provider.dart';
import '../widgets/widgets.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final loc = ref.watch(localizationProvider);

    final scaffoldKey = useMemoized(() => GlobalKey<ScaffoldState>());

    final scrollController = useScrollController();
    final notifier = ref.read(homeProvider.notifier);
    final state = ref.watch(homeProvider);

    useEffect(() {
      void onScroll() {
        final maxScroll = scrollController.position.maxScrollExtent;
        final currentScroll = scrollController.position.pixels;

        final isAtBottom = currentScroll >= (maxScroll - 100);

        if (isAtBottom) {
          notifier.getPokemons();
        }
      }

      scrollController.addListener(onScroll);

      Future.microtask(() async {
        await notifier.getLocalPokemons();
        await notifier.getPokemons();
        return;
      });

      return () {
        scrollController.removeListener(onScroll);
      };
    }, [scrollController]);

    final List<Pokemon> pokemons = state.pokemons.isEmpty
        ? state.cachedPokemons
        : state.pokemons;

    return Scaffold(
      key: scaffoldKey,
      endDrawer: state.status == ApiStatus.loading ? null : const HomeDrawer(),
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => scaffoldKey.currentState?.openEndDrawer(),
            icon: Icon(Icons.menu_rounded, color: theme.colorScheme.tertiary),
          ),
        ],
        elevation: 0.0,
        title: Text(
          loc.translate(TranslationConst.pokedex),
          style: theme.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w700,
            fontSize: 16.0,
          ),
        ),
      ),
      body: pokemons.isEmpty && state.status == ApiStatus.loading
          ? const CustomLoader()
          : SingleChildScrollView(
              controller: scrollController,
              padding: const EdgeInsets.all(16.0),
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) =>
                        PokeTile(pokemon: pokemons[index]),
                    separatorBuilder: (_, _) => const SizedBox(height: 16.0),
                    itemCount: pokemons.length,
                  ),
                  if (state.status == ApiStatus.loading) ...[CustomLoader()],
                ],
              ),
            ),
    );
  }
}
