import 'package:api/provider/product_provider/categoryies.dart';
import 'package:api/servis/api/product/product_api.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<Categories>().getCategories();
    super.initState();
  }

  String product = 'smartphones';
  @override
  Widget build(BuildContext context) {
    ProductsApi productsApi = ProductsApi();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Api'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 40),
          SizedBox(
            height: 50,
            child: Consumer<Categories>(builder: ((context, value, child) {
              if (value.isSelect) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: value.category.length,
                  itemBuilder: ((context, index) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          product = value.category[index];
                          productsApi.getProducts(product);
                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.blue.shade100,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Text(
                          value.category[index],
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Color(0xB31A0113)),
                        ),
                      ),
                    );
                  }));
            })),
          ),
          const SizedBox(height: 30),
          Expanded(
            child: FutureBuilder(
              future: productsApi.getProducts(product),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.connectionState == ConnectionState.done) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: GridView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: snapshot.data!.products.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1,
                          crossAxisSpacing: 20,
                          mainAxisExtent: 350,
                        ),
                        itemBuilder: (context, index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                height: 200,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  image: DecorationImage(image: NetworkImage(snapshot.data!.products[index].thumbnail), fit: BoxFit.cover),
                                ),
                              ),
                              const SizedBox(height: 15),
                              Text(
                                snapshot.data!.products[index].title,
                                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(height: 7),
                              Text(
                                snapshot.data!.products[index].brand,
                                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                '\$${snapshot.data!.products[index].price}',
                                style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
                              ),
                            ],
                          );
                        }),
                  );
                }
                return const Center(
                  child: Text('error'),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        ProductsApi().getProducts('smartphones');
      }),
    );
  }
}
