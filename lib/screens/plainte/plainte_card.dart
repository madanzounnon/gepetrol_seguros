import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../models/Plainte.dart';
import '../../size_config.dart';

class PlainteCard extends StatelessWidget {
  const PlainteCard({
    Key? key,
    required this.plainte,
  }) : super(key: key);
  final Plainte plainte;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {},
      child: Container(
        padding:
            EdgeInsets.symmetric(vertical: getProportionateScreenHeight(10)),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundColor: kPrimaryColor,
                    maxRadius: 27,
                    child: Text(plainte.status.toString()),
                  ),
                  SizedBox(
                    width: getProportionateScreenWidth(16),
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            " ${plainte.title}",
                            maxLines: 1,
                            style: TextStyle(
                                fontSize: getProportionateScreenWidth(15),
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            " ${plainte.description}",
                            maxLines: 1,
                            style: TextStyle(
                                fontSize: getProportionateScreenWidth(12),
                                color: Colors.grey.shade600),
                          ),
                          Text.rich(
                            TextSpan(text: "Statut: ", children: [
                              TextSpan(
                                  text: plainte.status.toString(),
                                  style: const TextStyle(
                                      color: kPrimaryColor,
                                      fontWeight: FontWeight.w700)),
                            ]),
                            maxLines: 1,
                            style: TextStyle(
                                fontSize: getProportionateScreenWidth(15),
                                color: Colors.grey.shade600),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
