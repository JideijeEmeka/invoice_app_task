import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:invoice_app/views/details_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  Dio dio = Dio();
  bool isLoading = false;
  Map<dynamic, dynamic> info = {};
  List invoices = [];
  
  @override
  void initState() {
    getInvoices();
    super.initState();
  }

  Future createNewInvoice() async {
    setState(() {
      isLoading = true;
    });
    await dio.post("https://65cf4dcbbdb50d5e5f5af94f.mockapi.io/api/v1/create").then((res) {
      setState(() {
        if(mounted) {
          res.data = info;
        }
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:
        Text('Invoice created successfully!, click refresh icon')));
    });
    setState(() {
      isLoading = false;
    });
  }

  Future getInvoices() async {
    setState(() {
      isLoading = true;
    });
    await dio.get("https://65cf4dcbbdb50d5e5f5af94f.mockapi.io/api/v1/create").then((res) {
      invoices = res.data;
      setState(() {});
      print("see: $invoices");
    });
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue,
        title: const Text("Invoice app"),
        actions: [
          IconButton(onPressed: () {
            getInvoices();
          },
              icon: const Icon(Icons.refresh)),
          IconButton(onPressed: () {
            createNewInvoice();
          },
              icon: const Icon(Icons.add))
        ],
      ),
      body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: isLoading ? const CircularProgressIndicator()
                : invoices.isNotEmpty 
                ? ListView.builder(
                    itemCount: invoices.length,
                    shrinkWrap: true,
                    itemBuilder: (ctx, i) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10, top: 10),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (_) {
                              return DetailsView(id: invoices[i]['id'].toString(),
                                  createdAt: invoices[i]['createdAt'],
                                  name: invoices[i]['name'],
                                  price: invoices[i]['price'].toString(),
                                  quantity: invoices[i]['quantity'].toString(),
                                  total: invoices[i]['total'].toString(),
                                  description: invoices[i]['description'],
                                  address: invoices[i]['address'],
                                  signature: invoices[i]['signature'],
                                  avatar: invoices[i]['avatar'],
                                productName: invoices[i]['productName'],);
                            }));
                          },
                          child: ListTile(
                            leading: Image.network(invoices[i]['avatar']!, fit: BoxFit.cover,),
                            title: Text(invoices[i]['productName']!),
                            tileColor: Colors.grey.withOpacity(0.7),
                            subtitle: Text('Quantity sold: ${invoices[i]['quantity']!}'),
                            trailing: Column(
                              children: [
                                const Text('Price:'),
                                Text('\$${invoices[i]['price']!}'),
                              ],
                            ),
                          ),
                        ),
                      );
                 }) :
                const Text("You currently do not have any invoice, "
                    "click the add (+) icon to create a new invoice"),
          ),
      ),
    );
  }
}
