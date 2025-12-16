// import 'dart:isolate';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/router/app_navigation.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/util/custom_utils.dart';
import '../../../../injection_container.dart';
import '../../../theme/domain/usecases/update_user_local_data.dart';
import '../../domain/entities/pokemon.dart';
import '../../domain/usecases/get_local_pokemon_list.dart';
import '../../domain/usecases/get_pokemon_detail.dart';
import '../../domain/usecases/get_pokemon_list.dart';
import '../../domain/usecases/store_pokemon_list_locally.dart';
import 'home_state.dart';

class HomeStateNotifier extends Notifier<HomeState> {
  final GetPokemonDetail getPokemonDetail;
  final GetPokemonList getPokemonList;
  final GetLocalPokemonList getLocalPokemonList;
  final StorePokemonListLocally storePokemonListLocally;
  final UpdateUserLocalData updateUserLocalData;
  HomeStateNotifier({
    required this.getPokemonDetail,
    required this.getPokemonList,
    required this.getLocalPokemonList,
    required this.storePokemonListLocally,
    required this.updateUserLocalData,
  });

  @override
  HomeState build() {
    return const HomeState();
  }

  Future<void> getLocalPokemons() async {
    state = state.copywith(status: ApiStatus.loading);
    final result = await getLocalPokemonList.call(NoParams());
    result.fold(
      (failure) {
        state = state.copywith(status: ApiStatus.error);
        showCustomSnackBar(
          message: failure.message ?? "Failed to fetch local pokemons list",
        );
      },
      (response) {
        state = state.copywith(
          status: ApiStatus.success,
          cachedPokemons: response,
        );
      },
    );
  }

  Future<void> _storePokemonsLocally({required List<Pokemon> pokemons}) async {
    final result = await storePokemonListLocally.call(
      StorePokemonListLocallyParams(pokemons: pokemons),
    );
    result.fold((failure) {
      showCustomSnackBar(
        message: failure.message ?? "Failed to store pokemons locally",
      );
    }, (_) {});
  }

  Future<void> getPokemons() async {
    if (state.status == ApiStatus.loading) return;
    state = state.copywith(status: ApiStatus.loading);
    final result = await getPokemonList.call(
      GetPokemonListParams(offset: state.offset),
    );
    result.fold(
      (failure) {
        state = state.copywith(status: ApiStatus.error);
        showCustomSnackBar(
          message: failure.message ?? "Failed to fetch pokemons list",
        );
      },
      (response) async {
        List<Pokemon> previousPokemonsList = List<Pokemon>.from(state.pokemons);
        previousPokemonsList.addAll(response);
        final int previousOffset = state.offset;
        state = state.copywith(
          status: ApiStatus.success,
          offset: previousOffset + 1,
          pokemons: previousPokemonsList,
        );
        if (previousOffset == 0) {
          _storePokemonsLocally(pokemons: response);
          // await Isolate.run(() async {
          // print("Storing data locally using isolate");

          // });
        }
      },
    );
  }

  Future<void> logOut() async {
    Head.back();
    state = state.copywith(status: ApiStatus.loading);
    final result = await updateUserLocalData.call(
      UpdateUserParams(userData: {isLoggedInKey: false}),
    );
    result.fold(
      (failure) {
        state = state.copywith(status: ApiStatus.error);
        showCustomSnackBar(
          message: failure.message ?? "Failed to log out user",
        );
      },
      (_) {
        state = state.copywith(status: ApiStatus.success);
        Head.offAll(AppPages.login);
      },
    );
  }

  Future<void> fetchPokemonDetail(String url) async {
    final result = await getPokemonDetail.call(
      GetPokemonDetailParams(url: url),
    );
    result.fold(
      (failure) {
        showCustomSnackBar(
          message: failure.message ?? "Failed to get pokemon detail",
        );
      },
      (response) {
        state = state.copywith(pokemonDetail: response);
      },
    );
  }
}

final homeProvider = NotifierProvider<HomeStateNotifier, HomeState>(
  () => sl<HomeStateNotifier>(),
);

final getPokemonDetailProvider = FutureProvider.autoDispose
    .family<void, String>(
      (ref, url) => ref.read(homeProvider.notifier).fetchPokemonDetail(url),
    );
