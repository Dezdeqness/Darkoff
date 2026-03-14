import 'package:darkoff/domain/entities/item_detail_entity.dart';
import 'package:darkoff/domain/repositories/items_repository.dart';
import 'package:result_dart/result_dart.dart';

class GetItemDetailUseCase {
  GetItemDetailUseCase({
    required ItemsRepository repository,
  }) : _repository = repository;

  final ItemsRepository _repository;

  Stream<Result<ItemDetailEntity>> call(String itemId) async* {
    final localResult = await _repository.getLocalItemDetail(itemId);

    final local = localResult.fold(
      (detail) => detail,
      (_) => null,
    );

    if (local != null) {
      yield Success(local);
    }

    final apiResult = await _repository.getItemDetail(itemId);
    yield apiResult;
  }
}
