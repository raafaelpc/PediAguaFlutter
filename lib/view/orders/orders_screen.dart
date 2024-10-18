import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pedi_agua/controller/order_data.dart';
import 'package:pedi_agua/model/order.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  List<Order> orders = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadOrders();
  }

  void _loadOrders() async {
    try {
      List<Order> loadedOrders = await OrderData().read();
      setState(() {
        orders = loadedOrders;
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      print('Erro ao carregar pedidos: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: isLoading ? _loadingIndicator() : _body(),
    );
  }

  AppBar _appBar() {
    return AppBar(
      toolbarHeight: 150,
      title: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  child: _imageUserAppBar(),
                ),
                const SizedBox(width: 20), // Ajuste o espaço conforme necessário
                _titleAppBar(),
              ],
            ),
            const SizedBox(height: 10),
            _searchAppBar(),
          ],
        ),
      ),
      centerTitle: true,
      backgroundColor: const Color.fromRGBO(95, 96, 98, 0.99),
    );
  }

  Widget _imageUserAppBar() {
    return Container(
      width: 45.0,
      height: 45.0,
      decoration: const BoxDecoration(
        color: Colors.white70,
        shape: BoxShape.rectangle,
      ),
    );
  }

  Widget _titleAppBar() {
    return const Text(
      'PEDIDOS',
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 30,
      ),
    );
  }

  Widget _searchAppBar() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey,
      ),
      child: const TextField(
        decoration: InputDecoration(
          suffixIcon: Icon(
            Icons.search,
            color: Colors.white,
          ),
          focusedBorder: InputBorder.none,
        ),
      ),
    );
  }

  Widget _loadingIndicator() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _body() {
    if (orders.isEmpty) {
      return const Center(child: Text('Nenhum pedido encontrado'));
    }

    final groupedOrders = _groupOrdersByDate(orders);
    List<DateTime> sortedDates = groupedOrders.keys.toList()..sort((a, b) => b.compareTo(a));

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.05),
      child: ListView.builder(
        itemCount: sortedDates.length,
        itemBuilder: (BuildContext context, int index) {
          final date = sortedDates[index];
          final ordersForDate = groupedOrders[date]!;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  DateFormat('dd/MM/yyyy').format(date),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              ...ordersForDate.map((order) => _orderCard(order, context)),
              const Divider(),
            ],
          );
        },
      ),
    );
  }

  Map<DateTime, List<Order>> _groupOrdersByDate(List<Order> orders) {
    Map<DateTime, List<Order>> groupedOrders = {};

    for (var order in orders) {
      DateTime orderDate = DateTime(order.createDate.year, order.createDate.month, order.createDate.day);

      if (!groupedOrders.containsKey(orderDate)) {
        groupedOrders[orderDate] = [];
      }

      groupedOrders[orderDate]!.add(order);
    }

    return groupedOrders;
  }

  Widget _orderCard(Order order, BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        title: Text(order.nameStore, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('Valor: ${order.valueProduct} | Status: ${order.status}'),
      ),
    );
  }
}
