import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pedi_agua/model/store.dart';

class StoreData {
  final CollectionReference storeCollection = FirebaseFirestore.instance.collection('store');


  /// Create Product
  // Future<void> Create(String name, String type, String code) async {
  //   Store product = Store(
  //     id: '',
  //     code: code,
  //     name: name,
  //     type: type,
  //   );
  //   await productCollection.add(product.toMap());
  // }

  /// Read Products
  Future<List<Store>> read() async {
    QuerySnapshot snapshot = await storeCollection.get();
    return snapshot.docs
        .map((doc) => Store.fromFirestore(doc.data() as Map<String, dynamic>, doc.id))
        .toList();
  }

  // /// Update
  // Future<void> Update(Product product) async {
  //   await productCollection.doc(product.id).update(product.toMap());
  // }
  //
  // /// Delete Product
  // Future<void> Delete(String id) async {
  //   await productCollection.doc(id).delete();
  // }
}
