import 'package:bloc/bloc.dart';
import 'package:clean_app/backbone/bloc_status.dart';
import 'package:clean_app/domain/entity/coin.dart';
import 'package:clean_app/domain/usecase/get_market_coins.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'bloc.freezed.dart';
part 'event.dart';
part 'state.dart';

class CoinBloc extends Bloc<CoinEvent, CoinState> {
  final GetMarketCoinsUseCase _getMarketCoinsUseCase;

  CoinBloc(this._getMarketCoinsUseCase)
      : super(const CoinState(BlocStatus.Loading, <Coin>[])) {
    on<GetMarketCoinsEvent>(
      (GetMarketCoinsEvent event, Emitter<CoinState> emit) async {
        await event.when(
          getMarketCoins: (String currency, String order, int pageNumber,
                  int perPage, String sparkline) =>
              _getMarketCoins(
                  emit, currency, order, pageNumber, perPage, sparkline),
        );
      },
    );
  }
  Future<void> _getMarketCoins(Emitter<CoinState> emit, String currency,
      String order, int pageNumber, int perPage, String sparkline) async {
    emit(_loadingState());
    emit(await _getMarketCoinsUseCase(
            currency, order, pageNumber, perPage, sparkline)
        .then(
          (List<Coin> coin) => CoinState(
            BlocStatus.Loaded,
            coin,
          ),
        )
        .catchError(_onError));
  }
  // @override
  // Stream<CoinState> mapEventToState(
  //   CoinEvent event,
  // ) =>
  //     event.when(
  //       getMarketCoins: _getMarketCoins,
  //       getNextMarketCoins: _getNextMarketCoins
  //     );

  // Stream<CoinState> _getMarketCoins(String currency, String order,
  //     int pageNumber, int perPage, String sparkline) async* {
  //   yield _loadingState();
  //   yield await _getMarketCoinsUseCase(
  //           currency, order, pageNumber, perPage, sparkline)
  //       .then(
  //         (List<Coin> coin) => CoinState(
  //           BlocStatus.Loaded,
  //           coin,
  //         ),
  //       )
  //       .catchError(_onError);
  // }

  // Stream<CoinState> _getNextMarketCoins(String currency, String order,
  //     int pageNumber, int perPage, String sparkline) async* {
  //   yield _loadingState();
  //   yield await _getMarketCoinsUseCase(
  //           currency, order, pageNumber, perPage, sparkline)
  //       .then(
  //         (List<Coin> coin) => CoinState(
  //           BlocStatus.Loaded,
  //           <Coin>[
  //             ...state.coins,
  //             ...coin,
  //           ],
  //         ),
  //       )
  //       .catchError(_onError);
  // }

  CoinState _loadingState() => CoinState(BlocStatus.Loading, state.coins);

  Future<CoinState> _onError(Object error) async =>
      CoinState(BlocStatus.Error, state.coins, error: error);
}
