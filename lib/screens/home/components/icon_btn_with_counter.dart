import 'package:flutter/material.dart';
import '../../../constants.dart';
import '../../../size_config.dart';

class IconBtnWithCounter extends StatelessWidget {
  const IconBtnWithCounter({
    Key? key,
    //required this.svgSrc,
    this.numOfitem = 0,
    this.active=false,
    required this.press,
  }) : super(key: key);

  //final String svgSrc;
  final int numOfitem;
  final bool active;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(100),
      onTap: press,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: EdgeInsets.all(getProportionateScreenWidth(10)),
            height: getProportionateScreenWidth(45),
            width: getProportionateScreenWidth(45),
            decoration: BoxDecoration(
              color: active
                      ? pPrimaryColor
                      : kSecondaryColor,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.wallet_giftcard,color: active
                      ? Color.fromARGB(255, 252, 252, 252)
                      :  Color.fromARGB(255, 252, 252, 252),),
          ),
          if(numOfitem != 0)
            Positioned(
              top: -3,
              right: 0,
              child: Container(
                height: getProportionateScreenWidth(16),
                width: getProportionateScreenWidth(16),
                decoration: BoxDecoration(
                  color: Color(0xFFFF4848),
                  shape: BoxShape.circle,
                  border: Border.all(width: 1.5, color: Colors.white),
                ),
                child: Center(
                  child: Text(
                    "$numOfitem",
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(10),
                      height: 1,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}
