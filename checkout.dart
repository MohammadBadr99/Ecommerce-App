import 'package:ecommerce/Models/CartModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class chechout extends StatefulWidget {
  const chechout({super.key});

  @override
  State<chechout> createState() => _chechoutState();
}

class _chechoutState extends State<chechout> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back),
            color: Colors.black,
          ),
          title: Text(
            "Checkout",
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        body: Selector<Cart, List>(builder: ((context, checkoutList, child) {
          return Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            //color: Colors.grey[500],
            child: Stack(
              children: [
                ListView.builder(
                  itemCount: checkoutList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        "${checkoutList[index].getProductName}",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      subtitle: Text("${checkoutList[index].getProductDesc}"),
                      leading: Consumer<Cart>(
                        builder: ((context, cart, child) {
                          return IconButton(
                              onPressed: () {
                                setState(() {
                                  cart.removeFromCart(checkoutList[index]);
                                });
                              },
                              icon: Icon(Icons.remove_circle));
                        }),
                      ),
                      trailing: Text(
                        "${checkoutList[index].getproductPrice.toString()}",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    );
                  },
                ),
                Positioned(
                    top: MediaQuery.of(context).size.height - 200,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.19,
                      width: MediaQuery.of(context).size.width - 20,
                      margin: EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey[300]),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                flex: 4,
                                child: Container(
                                  alignment: Alignment.centerRight,
                                  width: 10,
                                  height: 30,
                                  color: Colors.grey[300],
                                  child: InkWell(
                                    onTapDown: (details) {},
                                    child: Text(
                                      "Add Voucher Code",
                                      style:
                                          Theme.of(context).textTheme.bodyLarge,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                  child: IconButton(
                                iconSize: 20,
                                onPressed: () {},
                                icon: Icon(Icons.arrow_forward_ios),
                              ))
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  child: Column(
                                    children: [
                                      Text(
                                        "Total",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                      Selector<Cart, double>(builder:
                                          ((context, totalPrice, child) {
                                        return Text(
                                          "\$${totalPrice.toString()}",
                                          style: TextStyle(
                                              color: Colors.orange,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        );
                                      }), selector: (BuildContext, cart) {
                                        return cart.getTotalPrice;
                                      })
                                    ],
                                  ),
                                ),
                              ),
                              VerticalDivider(),
                              Expanded(
                                  child: InkWell(
                                onTapDown: (details) {
                                  print("Checked out successfully!");
                                },
                                child: Container(
                                  height: 50,
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.only(right: 10),
                                  decoration: BoxDecoration(
                                      color: Colors.amber[900],
                                      borderRadius: BorderRadius.circular(30),
                                      border: Border.all(
                                          color: Colors.white, width: 3)),
                                  child: Text(
                                    "Checkout",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ))
                            ],
                          )
                        ],
                      ),
                    ))
              ],
            ),
          );
        }), selector: (BuildContext, p1) {
          return p1.getItems;
        }),
      ),
    );
  }
}
