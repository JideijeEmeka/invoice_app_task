import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class DetailsView extends StatefulWidget {
  final String id;
  final String createdAt;
  final String avatar;
  final String name;
  final String productName;
  final String price;
  final String quantity;
  final String total;
  final String address;
  final String signature;
  final String description;
  const DetailsView({super.key,
    required this.id, required this.createdAt, required this.name,
    required this.price, required this.quantity, required this.total,
    required this.description, required this.address, required this.signature,
    required this.avatar, required this.productName});

  @override
  State<DetailsView> createState() => _DetailsViewState();
}

class _DetailsViewState extends State<DetailsView> {
  bool isLoadingUpdate = false;
  bool isLoadingDelete = false;
  Dio dio = Dio();

  Future deleteInvoice() async {
    setState(() {
      isLoadingDelete = true;
    });
    await dio.delete("https://65cf4dcbbdb50d5e5f5af94f.mockapi.io/api/v1/create/${widget.id}").then((_) {
      context.push('/home');
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:
      Text('Invoice deleted successfully!')));
    });
    setState(() {
      isLoadingDelete = false;
    });
  }

  Future updateInvoice() async {
    setState(() {
      isLoadingUpdate = true;
    });
    await dio.put("https://65cf4dcbbdb50d5e5f5af94f.mockapi.io/api/v1/create/${widget.id}").then((_) {
      context.push('/home');
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:
      Text('Invoice updated successfully!')));
    });
    setState(() {
      isLoadingUpdate = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(60),
              IconButton(onPressed: () {
                Navigator.pop(context);
              }, icon: const Icon(Icons.arrow_back_outlined)),
              const Gap(20),
              Container(
                margin: const EdgeInsets.only(right: 20, left: 20, bottom: 100),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.black)
                ),
                child: Column(
                  children: [
                    const Text('Product Details', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
                    const Gap(30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      const Text('customerId'),
                      Text(widget.id),
                    ],),
                    const Divider(),
                    const Gap(10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      const Text('image'),
                      Image.network(widget.avatar),
                    ],),
                    const Divider(),
                    const Gap(10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      const Text('product name'),
                        Text(widget.productName),
                    ],),
                    const Divider(),
                    const Gap(10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      const Text('customer name'),
                      Text(widget.name),
                    ],),
                    const Divider(),
                    const Gap(10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      const Text('address'),
                      Text(widget.address),
                    ],),
                    const Divider(),
                    const Gap(10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      const Text('price'),
                      Text(widget.price),
                    ],),
                    const Divider(),
                    const Gap(10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      const Text('description'),
                      SizedBox(
                        width: 180,
                        child: Text(widget.description),
                      ),
                    ],),
                    const Divider(),
                    const Gap(10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      const Text('total'),
                      Text(widget.total),
                    ],),
                    const Divider(),
                    const Gap(10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      const Text('quantity bought'),
                      Text(widget.quantity),
                    ],),
                    const Divider(),
                    const Gap(10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      const Text('customer signature'),
                      Text(widget.signature),
                    ],),
                    const Divider(),
                    const Gap(10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      const Text('Time bought'),
                      Text(DateFormat('yyyy-MM-dd').format(DateTime.parse(widget.createdAt))),
                    ],),
                    const Divider(),
                    const Gap(10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(onPressed: () {
                          updateInvoice();
                        },
                            child: isLoadingUpdate ? const SizedBox(
                                height: 20, width: 20,
                                child: CircularProgressIndicator(color: Colors.blue,))
                                : const Text("update invoice")),
                        ElevatedButton(onPressed: () {
                          deleteInvoice();
                        },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white
                            ),
                            child: isLoadingDelete ? const SizedBox(
                                height: 20, width: 20,
                                child: CircularProgressIndicator(color: Colors.white,))
                                : const Text("delete invoice")),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
