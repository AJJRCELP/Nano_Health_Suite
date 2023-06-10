import 'package:flutter/material.dart';
import 'package:nanohealthsuite/Screens/ProductsPage/Widgets/products_list_widget.dart';
import 'package:nanohealthsuite/utils/colors_utils.dart';

class ProductsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProductsScreenState();
  }
}

class _ProductsScreenState extends State<ProductsScreen>{
  static  List<Widget> _widgetOptions = <Widget>[
    ProductsListWidget(),
    const Text('', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
    const Text('', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
    const Text('', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  final GlobalKey<ScaffoldState> _myGlobe = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {

      return Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(

          preferredSize: AppBar().preferredSize,
          child: SafeArea(
            child: Container(
                decoration: const BoxDecoration(boxShadow: [
                  BoxShadow(
                    color: Colors.black54,
                    blurRadius: 10.0,
                  )
                ]),
              child: AppBar(
                automaticallyImplyLeading: false,
                centerTitle: true,
                title: const Text("All Products",style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w600),),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0)
                    )
                ),
                elevation: 0.0,
                backgroundColor: Colors.white,
              ),
            ),
          ),
        ),
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _widgetOptions.elementAt(_selectedIndex),
            ],
          ),
        ),

        bottomNavigationBar:BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedFontSize: 14,
        unselectedFontSize: 14,
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w700,fontFamily: 'Roboto'),
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Roboto'),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_outlined,size: 24,),
             label: ''
            ),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_rounded,size: 24,),
              label: ""
     ),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border_rounded,size: 24,),
              label: ""
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_2_outlined,size: 24,),

              label: ""
          ),
        ], type: BottomNavigationBarType.fixed,
        landscapeLayout: BottomNavigationBarLandscapeLayout.linear,
        selectedItemColor: ColorsUtils.secondColor,
      ),
      );

  }
}