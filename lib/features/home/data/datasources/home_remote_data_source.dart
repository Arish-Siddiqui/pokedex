import 'package:dio/dio.dart';

import '../../../../config/dio/dio_config.dart';
import '../../../../core/error/exceptions.dart';
import '../models/poekmon_detail_model.dart';
import '../models/pokemon_model.dart';

const String pokemonBaseUrl = "https://pokeapi.co/api/v2/pokemon";
const int count = 25;

abstract class HomeRemoteDataSource {
  Future<List<PokemonModel>> getPokemonList({required int offset});
  Future<PokemonDetailModel> getPokemonDetail({required String url});
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final DioClient dioClient;
  HomeRemoteDataSourceImpl({required this.dioClient});

  /// Get all Pokemon List
  @override
  Future<List<PokemonModel>> getPokemonList({required int offset}) async {
    final int tOffset = offset * count;
    final response = await dioClient.dio.request(
      '$pokemonBaseUrl/?offset=$tOffset&limit=$count',
      options: Options(method: 'GET'),
    );
    if (response.statusCode == 200) {
      final List<PokemonModel> pokemons = (response.data["results"] as List)
          .map<PokemonModel>((e) => PokemonModel.fromJson(e))
          .toList();
      return pokemons;
    } else {
      throw ServerException(
        response.data["message"] ?? "Failed to get all Pokemon Data",
      );
    }
  }

  /// Get Pokemon Detail
  @override
  Future<PokemonDetailModel> getPokemonDetail({required String url}) async {
    final response = await dioClient.dio.request(
      url,
      options: Options(method: 'GET'),
    );
    if (response.statusCode == 200) {
      return PokemonDetailModel.fromJson(response.data as Map<String, dynamic>);
    } else {
      throw ServerException(
        response.data["message"] ?? "Failed to get Pokemon Detail",
      );
    }
  }
}
