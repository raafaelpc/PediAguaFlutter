import 'package:flutter/material.dart';
import 'package:pedi_agua/controller/store_data.dart';
import 'package:pedi_agua/model/store.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Store> stores = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadStores();
  }

  void _loadStores() async {
    try {
      List<Store> loadedStores = await StoreData().read();
      setState(() {
        stores = loadedStores;
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      print('Erro ao carregar lojas: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: isLoading ? _loadingIndicator() : _body(context),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      toolbarHeight: MediaQuery.of(context).size.height * 0.2,
      title: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.15,
                  child: _imageUserAppBar(),
                ),
                // Título centralizado na tela
                Expanded(
                  child: Center(
                    child: _titleAppBar(context),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            _searchAppBar(context),
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

  Widget _titleAppBar(BuildContext context) {
    return Text(
      'LOJAS',
      textAlign: TextAlign.center, // Alinhamento central
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: MediaQuery.of(context).size.width * 0.08,
      ),
    );
  }

  Widget _searchAppBar(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.05,
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
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
        ),
      ),
    );
  }

  Widget _loadingIndicator() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _body(BuildContext context) {
    if (stores.isEmpty) {
      return const Center(child: Text('Nenhuma loja encontrada'));
    }

    return _listCard(context);
  }

  Widget _listCard(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.05),
      child: ListView.builder(
        itemCount: stores.length,
        itemBuilder: (BuildContext context, int index) {
          final store = stores[index];
          return _storeCards(store, context);
        },
      ),
    );
  }

  Widget _storeCards(Store store, BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 2,
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.2,
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            store.open == 'true' ? 'Aberto' : 'Fechado',
                            style: TextStyle(
                              color: store.open == 'true'
                                  ? Colors.green
                                  : Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: MediaQuery.of(context).size.width * 0.04,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Expanded(
                          child: ListTile(
                            title: Text(
                              store.name,
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: MediaQuery.of(context).size.width * 0.04,
                              ),
                            ),
                            subtitle: Text(
                              store.location,
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontWeight: FontWeight.bold,
                                fontSize: MediaQuery.of(context).size.width * 0.035,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
