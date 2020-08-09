import 'package:flutter/material.dart';
import 'package:terawe_flutter_project/constants.dart';
import 'package:terawe_flutter_project/screens/image_screen.dart';

class ProductTile extends StatelessWidget {
  final String UPN;
  final String productName;
  final String aisleNumber;
  final String shelf;
  final Function longPressCallback;

  ProductTile(
      {this.UPN,
      this.productName,
      this.aisleNumber,
      this.shelf,
      this.longPressCallback});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return ImageScreen(
              imageName: productName,
            );
          },
        ));
      },
      child: Card(
        elevation: 0.0,
        margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0),
        ),
        color: Color(0xFFF1F8FF),
        child: ListTile(
//        onLongPress: longPressCallback(),
          contentPadding:
              EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
          // camera button
          leading: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blue, width: 2.0),
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: () {
                print('camera button');
                print(productName);
              },
              icon: Icon(
                Icons.camera_alt,
                size: 20.0,
                color: Colors.blue,
              ),
            ),
          ),
          //product name + UPN
          title: Row(
            children: <Widget>[
              Expanded(
                flex: 5,
                child: Column(
                  children: <Widget>[
                    Text(
                      productName,
                      style: kProductTitleStyle,
                    ),
                    Text(
                      'UPN $UPN',
                      style: kUPNTextStyle,
                    ),
                  ],
                ),
              ),
              // number of stores
              Expanded(
                flex: 2,
                child: Column(
                  children: <Widget>[
                    Text(
                      '14',
                      style: kStoreNumberTextStyle,
                    ),
                    Text(
                      'Stores',
                      style: kStoresTextStyle,
                    ),
                  ],
                ),
              ),
            ],
          ),
          //add store button
          trailing: RawMaterialButton(
            onPressed: () {
              print('add store');
            },
            fillColor: Colors.blue,
            shape: CircleBorder(),
            elevation: 0.0,
            constraints: BoxConstraints(minWidth: 43.0, minHeight: 43.0),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            child: Icon(
              Icons.add,
              size: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
