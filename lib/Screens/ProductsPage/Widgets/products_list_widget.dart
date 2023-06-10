import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../ModelClass/product_model.dart';
import '../../ProductDetailsPage/details_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ProductsListWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProductsListWidgetState();
  }
}
class _ProductsListWidgetState extends State<ProductsListWidget> {

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder<List<ProductModel>>(
        future: fetchProducts(),
        builder: (context, snapshot){
          if(snapshot.hasData){
          return ListView.builder(
            shrinkWrap: true,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index){
                return Column(
                  children: [
                    GestureDetector(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => DetailsScreen(id:snapshot.data![index].id)));
                      },
                      child: Container(
                        margin: const EdgeInsets.all(20),
                        height: 170,
                        child: Stack(
                          children: [
                            Positioned.fill(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(snapshot.data![index].image.toString(),fit: BoxFit.cover,width: 370,height:247,),
                                )
                            ),
                            Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Container(
                                  height: 140,
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10),
                                      ),
                                      gradient: LinearGradient(
                                          begin: Alignment.bottomCenter,
                                          end: Alignment.topCenter,
                                          colors: [
                                            Colors.black.withOpacity(0.7),
                                            Colors.transparent,
                                          ]
                                      )
                                  ),
                                )
                            ),
                             Align(
                                alignment: Alignment.bottomCenter,
                                child:Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          snapshot.data![index].price.toString() + " AED",
                                          style: const TextStyle(
                                             fontFamily: "Open Sans",
                                              color: Colors.white,
                                              fontSize: 22.0,
                                              fontStyle: FontStyle.normal,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        RatingBarIndicator(
                                          unratedColor: Colors.white,
                                          rating: double.parse(snapshot.data![index].rating.toString()),
                                          itemBuilder: (context, index) => const Icon(
                                            Icons.star,
                                            color: Color(0xffFFE072),
                                          ),
                                          itemCount: 5,
                                          itemSize: 22.0,
                                          direction: Axis.horizontal,
                                        ),
                                      ],
                                    )
                                )

                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                        margin: const EdgeInsets.only(left: 20,top: 5,right: 20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                          child: Text(snapshot.data![index].title.toString(),
                                            style: const TextStyle(fontWeight: FontWeight.w300,fontSize: 14,fontFamily:"Open Sans",
                                                fontStyle: FontStyle.italic,color: Color(0xff444B51),letterSpacing: 0.175),)
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 10,),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                            snapshot.data![index].description.toString(),textAlign: TextAlign.justify,
                                            style: const TextStyle(fontWeight: FontWeight.w400,fontFamily:"Open Sans" , fontSize: 10,color: Color(0xff08293B),letterSpacing: 0.17)
                                        ),
                                      )
                                    ],
                                  ),
                                ],

                              ),
                            )
                          ],
                        )
                    ),
                    const SizedBox(height: 1,),
                    const Padding(
                      padding: EdgeInsets.only(top: 20,bottom: 1,left: 20,right: 20),
                      child: Divider(color: Color(0xffD8D8D8,),)
                    )

                  ],
                );
              }
          );
          }
          else if(snapshot.hasError){
            return const Text('No data found');
          }
          return const CupertinoActivityIndicator();
        },
      )

    );
  }

 Future<List<ProductModel>> fetchProducts() async {
   var response = await http.get(Uri.parse('https://fakestoreapi.com/products'));

   if(response.statusCode == 200){

     var result = json.decode(response.body);
     var prdList = result[0];
     print(prdList['rating']['rate']);
     List<ProductModel> productList = [];
     for(int i = 0; i < result.length; i++){
       var product = new ProductModel();
       product.id = result[i]['id'];
       product.title = result[i]['title'];
       product.price = result[i]['price'].toString();
       product.description = result[i]['description'];
       product.category = result[i]['category'];
       product.image = result[i]['image'];
       product.rating = (result[i]['rating']['rate']).toString();
       product.rateCount = (result[i]['rating']['count']).toString();
       productList.add(product);
     }
     return productList.toList();
   }else{
     throw Exception('Failed to load data');
   }
 }



}
