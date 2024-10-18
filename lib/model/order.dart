import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Order {
  final String id;
  final String nameStore;
  final String status;
  final String valueProduct;
  final DateTime createDate;

  Order({
    required this.id,
    required this.nameStore,
    required this.status,
    required this.valueProduct,
    required this.createDate
  });

  factory Order.fromFirestore(
      Map<String, dynamic> data, String id) {
    return Order(
      id: id,
      nameStore: data['nameStore'] ?? '',
      status: data['status'] ?? '',
      valueProduct: data['valueProduct'] ?? '',
      createDate: (data['createDate'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nameStore': nameStore,
      'status': status,
      'valueProduct': valueProduct,
      'createDate': createDate
    };
  }

}
