import 'package:ecommerce/Models/CartModel.dart';
import 'package:ecommerce/Models/productInfoModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

// ignore: camel_case_types
class productDetails extends StatefulWidget {
  final String image;
  final String name;
  final String description;
  final String price;
  const productDetails(
      {Key? key,
      required this.image,
      required this.name,
      required this.description,
      required this.price})
      : super(key: key);
  get productName {
    return name;
  }

  get productImage {
    return image;
  }

  get productDescription {
    return description;
  }

  get productPrice {
    return price;
  }

  @override
  // ignore: no_logic_in_create_state
  State<productDetails> createState() => _productDetailsState(
      productImage, productName, productDescription, productPrice);
}

// ignore: camel_case_types
class _productDetailsState extends State<productDetails> {
  final String image;
  final String name;
  final String description;
  final String price;
  Color activeColor = Colors.black;
  Color inactiveColor = Colors.grey;
  int choosenSize = 0;
  var choosenColor;
  _productDetailsState(this.image, this.name, this.description, this.price);

  ProductsModel item = new ProductsModel();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Container(
            color: Colors.grey[200],
            height: 80,
            padding: const EdgeInsets.only(top: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    flex: 1,
                    child: IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          size: 30,
                        ))),
                Expanded(
                  flex: 6,
                  child: Container(
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(10)),
                      child: Image.asset(
                        "images/logo_ecommerce.png",
                        fit: BoxFit.fill,
                      )),
                ),
                Expanded(
                    flex: 1,
                    child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.menu,
                          size: 30,
                        )))
              ],
            ),
          ),
          Container(
            height: 300,
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10))),
            child: Image.asset(
              image,
              fit: BoxFit.fill,
            ),
          ),
          const Divider(
            height: 10,
            color: Colors.transparent,
          ),
          Text(
            name,
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
          const Divider(
            height: 10,
            color: Colors.transparent,
          ),
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 20),
          ),
          const Divider(
            height: 10,
            color: Colors.transparent,
          ),
          Text(
            "\$$price",
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: Colors.orange,
                fontWeight: FontWeight.bold,
                fontSize: 30),
          ),
          const Divider(
            height: 1,
            color: Colors.transparent,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 5),
            child: Row(
              children: [
                const Expanded(
                  flex: 6,
                  child: Text(
                    "Color:",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                ),
                Expanded(
                    flex: 12,
                    child: RadioListTile(
                        activeColor: Colors.orange,
                        title: const Text(
                          "White",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        value: "White",
                        groupValue: choosenColor,
                        onChanged: ((value) {
                          setState(() {
                            choosenColor = value;
                          });
                        }))),
                Expanded(
                    flex: 12,
                    child: RadioListTile(
                        activeColor: Colors.orange,
                        title: const Text(
                          "Black",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        value: "Black",
                        groupValue: choosenColor,
                        onChanged: ((value) {
                          setState(() {
                            choosenColor = value;
                          });
                        }))),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 40),
            child: Row(
              children: [
                const Expanded(
                  flex: 18,
                  child: Text(
                    "Size:",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                ),
                Expanded(
                  flex: 11,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        choosenSize = 1;
                      });
                    },
                    child: Text(
                      "SS",
                      style: TextStyle(
                          color: choosenSize == 1 ? activeColor : inactiveColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                ),
                Expanded(
                  flex: 11,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        choosenSize = 2;
                      });
                    },
                    child: Text(
                      "S",
                      style: TextStyle(
                          color: choosenSize == 2 ? activeColor : inactiveColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                ),
                Expanded(
                  flex: 11,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        choosenSize = 3;
                      });
                    },
                    child: Text(
                      "M",
                      style: TextStyle(
                          color: choosenSize == 3 ? activeColor : inactiveColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                ),
                Expanded(
                  flex: 11,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        choosenSize = 4;
                      });
                    },
                    child: Text(
                      "L",
                      style: TextStyle(
                          color: choosenSize == 4 ? activeColor : inactiveColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                ),
                Expanded(
                  flex: 11,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        choosenSize = 5;
                      });
                    },
                    child: Text(
                      "XL",
                      style: TextStyle(
                          color: choosenSize == 5 ? activeColor : inactiveColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
              height: 70,
              decoration: const BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              margin: const EdgeInsets.only(
                  left: 50, right: 50, bottom: 10, top: 10),
              child: Consumer<Cart>(builder: ((context, pModel, child) {
                return GestureDetector(
                  onTap: (() {
                    //pModel.IncrementCounter();
                    item.setProductName(name);
                    item.setProductPrice(double.parse(price));
                    item.setProductDescription(description);
                    pModel.addToCart(item);
                    print(pModel.getTotalPrice);
                    showDialog(
                        context: context,
                        builder: (context) {
                          return const AlertDialog(
                              content: Text(
                            "Added To Cart Successfully!",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ));
                        });
                  }),
                  child: Row(
                    children: const [
                      Expanded(
                          child: Icon(
                        Icons.add,
                        color: Colors.white,
                      )),
                      Expanded(
                          child: Text("Add to Cart",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              )))
                    ],
                  ),
                );
              })))
        ],
      ),
    ));
  }
}
