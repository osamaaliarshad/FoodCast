// maintains a state of the list of items in our app
// it's going to have 3 different states. Loading, Data, and Error
import 'package:foodcast/models/food_item_model.dart';
import 'package:foodcast/repositories/custom_exception.dart';
import 'package:foodcast/repositories/food_item_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'auth_controller.dart';

// the purpose of having a separate provider is so we can listen to this
// provider in our UI. So we can display error messages using snackbars
final foodItemListExceptionProvider =
    StateProvider<CustomException?>((_) => null);

final foodItemListControllerProvider =
    StateNotifierProvider<FoodItemListController>(
  (ref) {
    final user = ref.watch(authControllerProvider.state);
    return FoodItemListController(ref.read, user?.uid);
  },
);

// async value comes from riverpod and gives us access to the three different
// states mentioned above
class FoodItemListController extends StateNotifier<AsyncValue<List<FoodItem>>> {
  final Reader _read;
  final String? _userId;

  // initial state of the controller id declared here in the super class arg
  FoodItemListController(this._read, this._userId)
      : super(AsyncValue.loading()) {
    if (_userId != null) {
      retrieveItems();
    }
  }

  Future<void> retrieveItems({bool isRefreshing = false}) async {
    if (isRefreshing) state = AsyncValue.loading();
    try {
      final foodItems = await _read(foodItemRepositoryProvider)
          .retrieveItems(userId: _userId!);
      if (mounted) {
        // without this check you will get an error
        state = AsyncValue.data(foodItems);
      }
    } on CustomException catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> addItem(
      {required String name, required String imageUrl, String? body}) async {
    try {
      final foodItem = FoodItem(foodName: name, imageUrl: imageUrl, body: body);
      final foodItemId = await _read(foodItemRepositoryProvider)
          .createItem(userId: _userId!, foodItem: foodItem);
      state.whenData((items) => state =
          AsyncValue.data(items..add(foodItem.copyWith(id: foodItemId))));
    } on CustomException catch (e) {
      _read(foodItemListExceptionProvider).state = e;
    }
  }

  // updateitem updates the item in firestore and in our state using a for loop
  Future<void> updateItem({required FoodItem updatedItem}) async {
    try {
      await _read(foodItemRepositoryProvider)
          .updateItem(userId: _userId!, foodItem: updatedItem);
      state.whenData((foodItems) {
        state = AsyncValue.data([
          for (final foodItem in foodItems)
            if (foodItem.id == updatedItem.id) updatedItem else foodItem
        ]);
      });
    } on CustomException catch (e) {
      _read(foodItemListExceptionProvider).state = e;
    }
  }

  Future<void> deleteItem({required foodItemId}) async {
    try {
      await _read(foodItemRepositoryProvider)
          .deleteItem(userId: _userId!, foodItemId: foodItemId);
      state.whenData((foodItems) => state = AsyncValue.data(
          foodItems..removeWhere((foodItem) => foodItem.id == foodItemId)));
    } on CustomException catch (e) {
      _read(foodItemListExceptionProvider).state = e;
    }
  }
}
