import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:nanohealthsuite/ModelClass/product_model.dart';
import 'package:nanohealthsuite/utils/colors_utils.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({
    required this.id,
    Key? key,
  }) : super(key: key);
  final int? id;
  @override
  State<StatefulWidget> createState() {
    return _DetailsScreenState();
  }
}
class _DetailsScreenState extends State<DetailsScreen> {
double _height = 500;
double _topheight = 400;
bool _isVisible = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Container(
          height: MediaQuery.of(context).size.height,
          child:FutureBuilder<ProductModel>(
              future: fetchProductDetails(widget.id),
              builder: (context, snapshot){
                if(snapshot.hasData){
                   return  Stack(
                     children: [
                       Container(
                         height: MediaQuery.of(context).size.height * 0.8,
                         width: double.infinity,
                         child: Image.network(snapshot.data!.image.toString(),fit: BoxFit.cover,),
                       ),
                       Align(
                           alignment: Alignment.topCenter,
                           child:Padding(
                               padding: const EdgeInsets.only(left: 15,top: 30,right: 15),
                               child: Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                 children: <Widget>[
                                   GestureDetector(
                                     onTap: (){

                                       Navigator.pop(context);
                                     },
                                     child: Container(
                                         decoration: BoxDecoration(
                                             color: Colors.white,
                                             borderRadius: BorderRadius.circular(12)
                                         ),
                                         height: 40,
                                         width: 40,
                                         child:const Icon(Icons.arrow_back,color: Color(0xff08293B),)
                                     ),
                                   ),
                                   GestureDetector(
                                     child: Container(
                                         decoration: BoxDecoration(
                                             color: Colors.white,
                                             borderRadius: BorderRadius.circular(12)
                                         ),
                                         height: 40,
                                         width: 40,

                                         child:const Icon(Icons.more_vert,color: Color(0xff08293B))
                                     ),
                                   )
                                 ],
                               )
                           )

                       ),
                       const Padding(
                           padding: EdgeInsets.only(left: 15,top: 104,right: 15),
                           child: Text("Detail",
                             style: TextStyle(fontFamily: "Open Sans",
                                 fontStyle: FontStyle.normal,fontWeight: FontWeight.w700,fontSize: 28,letterSpacing: 0.36,color: Colors.white),)
                       ),
                       Positioned(
                         top: _topheight,
                         left: 0,
                         right: 0,
                         bottom: 0,
                         child: Padding(
                             padding: const EdgeInsets.only(left: 15,top: 30,right: 15),
                             child: Text(snapshot.data!.price.toString() + " AED",
                               style: const TextStyle(fontFamily: "Open Sans",
                                   fontStyle: FontStyle.normal,fontWeight: FontWeight.w700,fontSize: 32,letterSpacing: 0.4,color: Color(0xff2A404B)),)
                         ),
                       ),



                       Positioned(
                         top: _height,
                         left: 0,
                         right: 0,
                         bottom: 0,
                         child: Container(
                           //height: _height,
                             decoration: const BoxDecoration(
                                 color: Colors.white,
                                 borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))
                             ),
                             child: SingleChildScrollView(
                                 child: Column(
                                   children: [
                                     Center(
                                       child: IconButton(
                                           icon: Icon(
                                             _height == 500.0 ?  Icons.keyboard_arrow_up_rounded : Icons.keyboard_arrow_down_rounded,
                                             color: ColorsUtils.secondColor,
                                             size: 30,
                                             weight: 2,
                                           ),
                                           onPressed: () {
                                             if(_height == 500.0){
                                               setState(() {
                                                 _topheight = 300;
                                                 _height = 400;
                                                 _isVisible = true;
                                               });
                                             }
                                             else {
                                               setState(() {
                                                 _topheight = 400;
                                                 _height = 500;
                                                 _isVisible = false;
                                               });
                                             }
                                           }),
                                     ),

                                     Padding(
                                         padding: const EdgeInsets.only(left: 15,top: 10,right: 15),
                                         child: Row(
                                           crossAxisAlignment: CrossAxisAlignment.start,
                                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                           children: <Widget>[
                                             GestureDetector(
                                               onTap: (){

                                                 Navigator.pop(context);
                                               },
                                               child: Container(
                                                   decoration: BoxDecoration(
                                                       boxShadow: const [
                                                         BoxShadow(
                                                           color: Color.fromRGBO(107, 127, 153, 0.25),
                                                           blurRadius:
                                                           14.0275,
                                                           spreadRadius:
                                                           0.0,
                                                           offset: Offset(
                                                             0.0,
                                                             3.0,
                                                           ),
                                                         )
                                                       ],
                                                       color: Colors.white,
                                                       borderRadius: BorderRadius.circular(20)
                                                   ),
                                                   height: 54.76,
                                                   width: 55.95,

                                                   child:const Icon(Icons.file_upload_outlined,color: ColorsUtils.secondColor,)
                                               ),
                                             ),
                                             Container(
                                               width:279.76,
                                               height: 54.76,
                                               decoration: BoxDecoration(
                                                 color: ColorsUtils.secondColor,
                                                 borderRadius: new BorderRadius.all(const Radius.circular(40.0)),
                                                 //gradient: _gradient,

                                               ),
                                               child: Material(
                                                 color: Colors.transparent,
                                                 child: InkWell(
                                                     borderRadius: new BorderRadius.all(const Radius.circular(43.0)),
                                                     onTap: (){
                                                       //_navigateToNextScreen(context);
                                                     },
                                                     child: const Center(
                                                       child: Text(
                                                         "Order Now",
                                                         style: TextStyle(
                                                             color: Colors.white,
                                                             fontWeight: FontWeight.normal,
                                                             fontSize: 14),
                                                       ),
                                                     )),
                                               ),
                                             )
                                           ],
                                         )
                                     ),
                                     Container(
                                         margin: const EdgeInsets.only(left: 20,top: 10,right: 20),
                                         child: Row(
                                           crossAxisAlignment: CrossAxisAlignment.start,
                                           children: [
                                             Expanded(
                                               child: Column(
                                                 children: [
                                                   const Row(
                                                     children: [
                                                       Expanded(
                                                           child: Text("Description",style:
                                                           TextStyle(fontWeight: FontWeight.w300,fontSize: 12,fontStyle: FontStyle.italic,color: Color(0xff444B51),fontFamily: "Open Sans"),)
                                                       )
                                                     ],
                                                   ),
                                                   const SizedBox(height: 5,),
                                                   Row(
                                                     children: [
                                                       Expanded(
                                                         child: Text(
                                                             snapshot.data!.description.toString(),style:
                                                         const TextStyle(fontWeight: FontWeight.w400,fontSize: 14,fontStyle: FontStyle.normal,color: Color(0xff838396),fontFamily: "Open Sans",letterSpacing: 0.175)
                                                         ),
                                                       )
                                                     ],
                                                   )
                                                 ],

                                               ),
                                             )
                                           ],
                                         )

                                     ),
                                    _isVisible ? Container(
                                       height: 103,
                                       decoration: BoxDecoration(
                                           color: const Color(0xffF1F1F1),
                                           borderRadius: BorderRadius.circular(10)
                                       ),
                                       margin: const EdgeInsets.only(left: 20,top: 10,right: 20),
                                       child: Column(
                                         crossAxisAlignment: CrossAxisAlignment.start,
                                         children: [

                                          Padding(
                                            padding: const EdgeInsets.only(left: 5,top: 5),
                                            child:Text("Reviews (" + snapshot.data!.rateCount.toString() + ")",
                                              style: const TextStyle(fontFamily: "Open Sans",fontWeight: FontWeight.w600,fontSize: 15),),
                                          ) ,
                                           Align(
                                               alignment: Alignment.center,
                                               child:Padding(
                                                   padding: const EdgeInsets.all(20),
                                                   child: Row(
                                                     //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                     children: <Widget>[
                                                       Text(
                                                         snapshot.data!.rating.toString(),
                                                         style: const TextStyle(
                                                             color: Colors.black,
                                                             fontSize: 32.0,
                                                             fontFamily: "Open Sans",
                                                             fontWeight: FontWeight.w600),
                                                       ),
                                                       const SizedBox(width: 20,),
                                                       RatingBarIndicator(
                                                         unratedColor: Colors.white,
                                                         rating: double.parse(snapshot.data!.rating.toString(),),
                                                         itemBuilder: (context, index) => const Icon(
                                                           Icons.star,
                                                             color: Color(0xffFFE072),
                                                         ),
                                                         itemCount: 5,
                                                         itemSize: 40.0,
                                                         direction: Axis.horizontal,
                                                       ),
                                                     ],
                                                   )
                                               )

                                           )
                                         ],
                                       ),
                                     ):Container(),
                                     const SizedBox(height: 20,)
                                   ],
                                 )
                             )
                         ),
                       )
                     ],
                   );
                }
                else if(snapshot.hasError){
                  return const Text('No data found');
                }
                return const Center(
                  child: CupertinoActivityIndicator(),
                );

              }
          )

        )

        ],
      ),
    );
  }

Future<ProductModel> fetchProductDetails(id) async {
    String url = "https://fakestoreapi.com/products/" + id.toString();
    var response = await http.get(Uri.parse(url));
    if(response.statusCode == 200){
      var result = json.decode(response.body);
      var product = new ProductModel();
      product.id = result['id'];
      product.title = result['title'];
      product.price = result['price'].toString();
      product.description = result['description'];
      product.category = result['category'];
      product.image = result['image'];
      product.rating = (result['rating']['rate']).toString();
      product.rateCount = (result['rating']['count']).toString();
      return product;
  }else{
    throw Exception('Failed to load data');
  }
}
}
