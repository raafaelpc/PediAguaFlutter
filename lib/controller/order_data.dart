import 'package:cloud_firestore/cloud_firestore.dart' as firestore;
import 'package:pedi_agua/model/order.dart';

class OrderData {
  final firestore.CollectionReference orderCollection = firestore.FirebaseFirestore.instance.collection('order');


  /// Create Product
  // Future<void> create() async {
  //   Order order = Order(
  //     id: '',
  //     nameStore: 'PadariaTestada',
  //     status: 'Em Rota',
  //     valueProduct: '24',
  //     createDate: DateTime.now()
  //   );
  //   await orderCollection.add(order.toMap());
  // }

  /// Read Products
  Future<List<Order>> read() async {
    firestore.QuerySnapshot snapshot = await orderCollection.get();
    return snapshot.docs
        .map((doc) => Order.fromFirestore(doc.data() as Map<String, dynamic>, doc.id))
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
