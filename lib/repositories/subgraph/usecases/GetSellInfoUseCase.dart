import 'package:ax_dapp/repositories/subgraph/usecases/GetSwapInfoUseCase.dart';
import 'package:ax_dapp/service/BlockchainModels/TokenPairInfo.dart';
import 'package:ax_dapp/service/Controller/Swap/AXT.dart';
import 'package:fpdart/fpdart.dart';

/// This is an abstraction on the GetSwapInfoUseCase to request
/// PairInfo in the context of a "Sell" scenario; Because every sell
/// is essentially a swap
/// This is simply accomplished by hardcoding the tokenTo value
/// to the AX Token address
const String _noSellInfoErrorMessage = 'No sell info found';

class GetSellInfoUseCase {
  GetSellInfoUseCase(this._repo);
  final GetSwapInfoUseCase _repo;

  Future<Either<Success, Error>> fetchAptSellInfo({
    required String aptAddress,
    double? aptInput,
  }) async {
    try {
      final newAptInput = aptInput ?? 0.0;
      final response = await _repo.fetchSwapInfo(
        tokenFrom: aptAddress,
        tokenTo: AXT.polygonAddress,
        fromInput: newAptInput,
      );
      final isSuccess = response.isLeft();

      if (isSuccess) {
        final swapInfo = response.getLeft().toNullable()!.swapInfo;
        return Either.left(Success(swapInfo));
      } else {
        return Either.right(const Error(_noSellInfoErrorMessage));
      }
    } catch (e) {
      return Either.right(Error('Error occurred: ${e.toString()}'));
    }
  }
}

class Success {
  const Success(this.sellInfo);

  final TokenSwapInfo sellInfo;
}

class Error {
  const Error(this.errorMsg);

  final String errorMsg;
}
