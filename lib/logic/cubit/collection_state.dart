part of 'collection_cubit.dart';

@immutable
abstract class CollectionState {
  const CollectionState();
}

class CollectionInitial extends CollectionState {
  const CollectionInitial();
}

class CollectionLoading extends CollectionState {
  const CollectionLoading();
}

class CollectionLoaded extends CollectionState {
  final List<Collection> collectionsList;
  const CollectionLoaded(this.collectionsList);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CollectionLoaded &&
        UtilFunctions.listEquals(other.collectionsList, collectionsList);
  }

  @override
  int get hashCode => collectionsList.hashCode;
}

class CollectionError extends CollectionState {
  final String message;
  const CollectionError(this.message);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CollectionError && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
