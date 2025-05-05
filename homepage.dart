import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:ecommerce/Models/CartModel.dart';
import 'package:ecommerce/Models/productInfoModel.dart';
import 'package:ecommerce/checkout.dart';
import 'package:ecommerce/productDetails.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class homepage extends StatefulWidget {
  const homepage({Key? key}) : super(key: key);

  @override
  State<homepage> createState() => _homepageState();
}

// ignore: camel_case_types
class _homepageState extends State<homepage> {
  int selectedIndex = 0;
  String home = "🟠";
  String shop = " ";
  String account = " ";
  late ScrollController scrollController;
  List<Map> productItems = [
    {
      "image": "images/g733-white-gallery-1.png",
      "name": "Logitech G-231",
      "description": "Bluetooth Headphones",
      "price": "231"
    },
    {
      "image": "images/watch.png",
      "name": "Apple Watch Ultra",
      "description": "Apple Watches",
      "price": "155"
    },
    {
      "image": "images/g733-white-gallery-1.png",
      "name": "Logitech G-231",
      "description": "Bluetooth Headphones",
      "price": "231"
    },
    {
      "image": "images/g733-white-gallery-1.png",
      "name": "Logitech G-231",
      "description": "Bluetooth Headphones",
      "price": "231"
    },
    {
      "image": "images/g733-white-gallery-1.png",
      "name": "Logitech G-231",
      "description": "Bluetooth Headphones",
      "price": "231"
    },
    {
      "image": "images/g733-white-gallery-1.png",
      "name": "Logitech G-231",
      "description": "Bluetooth Headphones",
      "price": "231"
    },
    {
      "image": "images/watch.png",
      "name": "Apple Watch Ultra",
      "description": "Apple Watches",
      "price": "155"
    },
    {
      "image": "images/watch.png",
      "name": "Apple Watch Ultra",
      "description": "Apple Watches",
      "price": "155"
    },
  ];
  @override
  void initState() {
    // TODO: implement initState
    scrollController = ScrollController();
    scrollController.addListener(
      () {},
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.orange,
          onPressed: (() {
            scrollController.animateTo(0,
                duration: const Duration(seconds: 1), curve: Curves.bounceIn);
          }),
          child: const Icon(
            Icons.move_up,
            color: Colors.black,
          )),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        selectedItemColor: Colors.black,
        selectedFontSize: 10,
        selectedLabelStyle: const TextStyle(color: Colors.orange),
        onTap: (index) {
          setState(() {
            selectedIndex = index;
            if (index == 0) {
              home = "🟠";
              shop = " ";
              account = " ";
            }
            if (index == 1) {
              home = " ";
              shop = "🟠";
              account = " ";
            }
            if (index == 2) {
              home = " ";
              shop = " ";
              account = "🟠";
            }
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: const Icon(
              Icons.home_outlined,
              size: 40,
            ),
            label: home,
          ),
          BottomNavigationBarItem(
              icon: const Icon(
                Icons.shopping_bag_outlined,
                size: 40,
              ),
              label: shop),
          BottomNavigationBarItem(
            icon: const Icon(
              Icons.person_outline,
              size: 40,
            ),
            label: account,
          )
        ],
      ),
      body: ListView(children: [
        Container(
          margin: const EdgeInsets.only(top: 25, left: 15, right: 15),
          height: 50,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 6,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10)),
                  child: TextFormField(
                    decoration: const InputDecoration(
                        hintText: 'Search',
                        hintStyle: TextStyle(
                            color: Colors.black26,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.black,
                          size: 30,
                        )),
                  ),
                ),
              ),
              Expanded(
                  flex: 1,
                  child: Stack(alignment: Alignment.topRight, children: [
                    IconButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed("checkout");
                        },
                        icon: Icon(Icons.shopping_cart)),
                    Selector<Cart, int>(
                      builder: ((context, counter, child) {
                        return Text(
                          "${counter}",
                          style: TextStyle(
                              color: Colors.orange,
                              fontWeight: FontWeight.bold),
                        );
                      }),
                      selector: (BuildContext, Cart) {
                        return Cart.getItemsCount;
                      },
                    )
                  ])),
              Expanded(
                  flex: 1,
                  child: IconButton(
                      onPressed: () {
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.error,
                          animType: AnimType.rightSlide,
                          title: 'Logout',
                          desc: 'Are you sure you want to logout?',
                          btnOkOnPress: () async {
                            await FirebaseAuth.instance.signOut();
                            Navigator.pushReplacementNamed(context, 'logIn');
                          },
                          btnCancelOnPress: () {},
                        )..show();
                      },
                      icon: const Icon(
                        Icons.logout,
                        size: 30,
                      ))),
            ],
          ),
        ),
        const Divider(
          height: 30,
          color: Colors.transparent,
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          height: 500,
          child: ListView(
            controller: scrollController,
            physics: const BouncingScrollPhysics(),
            children: [
              Text(
                "Categories",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const Divider(
                color: Colors.transparent,
                height: 10,
              ),
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Column(
                      children: [
                        Container(
                          width: 75,
                          height: 75,
                          decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(50)),
                          child: IconButton(
                              onPressed: () {
                                Navigator.of(context).pushNamed("men");
                              },
                              icon: const Icon(
                                Icons.man,
                                size: 50,
                                semanticLabel: 'Men',
                              )),
                        ),
                        Text(
                          "Men",
                          style: Theme.of(context).textTheme.bodyMedium,
                        )
                      ],
                    ),
                    const VerticalDivider(
                      width: 20,
                      color: Colors.transparent,
                    ),
                    Column(
                      children: [
                        Container(
                          width: 75,
                          height: 75,
                          decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(50)),
                          child: IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.woman,
                                size: 50,
                                semanticLabel: 'Women',
                              )),
                        ),
                        Text(
                          "Women",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                    const VerticalDivider(
                      width: 20,
                      color: Colors.transparent,
                    ),
                    Column(
                      children: [
                        Container(
                          width: 75,
                          height: 75,
                          decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(50)),
                          child: IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.child_friendly,
                                size: 50,
                                semanticLabel: 'Kids',
                              )),
                        ),
                        Text(
                          "Kids",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                    const VerticalDivider(
                      width: 20,
                      color: Colors.transparent,
                    ),
                    Column(
                      children: [
                        Container(
                          width: 75,
                          height: 75,
                          decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(50)),
                          child: IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.electric_bolt,
                                size: 50,
                                semanticLabel: 'Electrical',
                              )),
                        ),
                        Text(
                          "Electrical",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                    const VerticalDivider(
                      width: 20,
                      color: Colors.transparent,
                    ),
                    Column(
                      children: [
                        Container(
                          width: 75,
                          height: 75,
                          decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(50)),
                          child: IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.category,
                                size: 50,
                                semanticLabel: 'Women',
                              )),
                        ),
                        Text(
                          "Hobbies",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const Divider(
                color: Colors.transparent,
                height: 10,
              ),
              Text(
                "Best Seller",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              GridView.builder(
                itemCount: productItems.length,
                itemBuilder: (context1, index) {
                  return GestureDetector(
                    onTap: (() {
                      Navigator.of(context1).push(MaterialPageRoute(
                          builder: (context) => productDetails(
                              image: productItems[index]["image"],
                              name: productItems[index]["name"],
                              description: productItems[index]["description"],
                              price: productItems[index]["price"])));
                    }),
                    child: Container(
                      color: Colors.white,
                      margin: const EdgeInsets.all(5),
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            color: Colors.grey[200],
                            height: 150,
                            child: Image.asset(
                              productItems[index]["image"],
                              fit: BoxFit.fill,
                            ),
                          ),
                          Text(
                            "${productItems[index]["name"]}",
                            textAlign: TextAlign.start,
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          Text(
                            "${productItems[index]["description"]}",
                            textAlign: TextAlign.start,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          Text(
                            "\$${productItems[index]["price"]}",
                            textAlign: TextAlign.start,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                    ),
                  );
                },
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, mainAxisExtent: 240),
              )
            ],
          ),
        )
      ]),
    ));
  }
}

class CustomSearchHintDelegate extends SearchDelegate<String> {
  CustomSearchHintDelegate({
    required String hintText,
  }) : super(
          searchFieldLabel: hintText,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.search,
        );

  @override
  Widget buildLeading(BuildContext context) => const Text('leading');

  @override
  PreferredSizeWidget buildBottom(BuildContext context) {
    return const PreferredSize(
        preferredSize: Size.fromHeight(56.0), child: Text('bottom'));
  }

  @override
  Widget buildSuggestions(BuildContext context) => const Text('suggestions');

  @override
  Widget buildResults(BuildContext context) => const Text('results');

  @override
  List<Widget> buildActions(BuildContext context) => <Widget>[];
}
