import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/pokemon.dart';
import '../../domain/entities/pokemon_detail.dart';
import '../../domain/repositories/home_repository.dart';
import '../datasources/home_local_data_source.dart';
import '../datasources/home_remote_data_source.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;
  final HomeLocalDataSource localDataSource;

  HomeRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, PokemonDetail>> getPokemonDetail({
    required String url,
  }) async {
    try {
      final response = await remoteDataSource.getPokemonDetail(url: url);
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        return const Left(
          ServerFailure('Connection timed out. Please try again.'),
        );
      }
      final message =
          e.response?.data['message'] ?? e.message ?? 'Login failed';
      return Left(ServerFailure(message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Pokemon>>> getPokemonList({
    required int offset,
  }) async {
    try {
      final response = await remoteDataSource.getPokemonList(offset: offset);
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        return const Left(
          ServerFailure('Connection timed out. Please try again.'),
        );
      }
      final message =
          e.response?.data['message'] ?? e.message ?? 'Login failed';
      return Left(ServerFailure(message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Either<Failure, List<Pokemon>> getLocalPokemonList() {
    try {
      final response = localDataSource.getPokemonList();
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> storePokemonLocally({
    required List<Pokemon> pokemons,
  }) async {
    try {
      await localDataSource.storePokemonList(pokemons: pokemons);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
