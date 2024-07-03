// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:gepetrol_eguros/constants.dart';
import 'package:gepetrol_eguros/screens/compte/account_page.dart';
import 'package:gepetrol_eguros/screens/facture/add_facture.dart';
import 'package:gepetrol_eguros/screens/home/home_screen.dart';
import 'package:gepetrol_eguros/size_config.dart';

class EntryPoint extends StatefulWidget {
  int currentPage;
  EntryPoint({
    Key? key,
    this.currentPage = 0,
  }) : super(key: key);
  static String routeName = "/entrypoint";

  @override
  State<EntryPoint> createState() => _EntryPointState();
}

class _EntryPointState extends State<EntryPoint> {
  static const _iconColor = Color(0xffADADAD);

  int _currentPage = 0;
  final List _pages = [
    HomeScreen(),
    const AccountPage(),
    const AddFactureScreen(),
    HomeScreen(),
    const AccountPage(),
  ];
  @override
  void initState() {
    super.initState();
    _currentPage = widget.currentPage;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentPage],
      bottomNavigationBar: BottomNavigationBar(
        //fixedColor: Colors.white,
        currentIndex: _currentPage,
        onTap: (index) {
          setState(() {
            _currentPage = index;
          });
        },
        //elevation:20,
        type: BottomNavigationBarType.fixed,
        unselectedLabelStyle: const TextStyle(color: _iconColor),
        selectedLabelStyle: const TextStyle(color: pPrimaryColor),
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/Shop Icon.svg',
              colorFilter: const ColorFilter.mode(
                _iconColor,
                BlendMode.srcIn,
              ),
            ),
            activeIcon: SvgPicture.asset(
              'assets/icons/Shop Icon.svg',
              width: getProportionateScreenWidth(22),
              colorFilter: const ColorFilter.mode(
                pPrimaryColor,
                BlendMode.srcIn,
              ),
            ),
            label: 'Acogida',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/money-bill-transfer-solid.svg',
              width: getProportionateScreenWidth(22),
              colorFilter: const ColorFilter.mode(
                _iconColor,
                BlendMode.srcIn,
              ),
            ),
            activeIcon: SvgPicture.asset(
              'assets/icons/money-bill-transfer-solid.svg',
              width: getProportionateScreenWidth(22),
              colorFilter: const ColorFilter.mode(
                pPrimaryColor,
                BlendMode.srcIn,
              ),
            ),
            label: 'Ayuda',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/wallet-solid.svg',
              width: getProportionateScreenWidth(22),
              colorFilter: const ColorFilter.mode(
                _iconColor,
                BlendMode.srcIn,
              ),
            ),
            activeIcon: SvgPicture.asset(
              'assets/icons/wallet-solid.svg',
              width: getProportionateScreenWidth(22),
              colorFilter: const ColorFilter.mode(
                pPrimaryColor,
                BlendMode.srcIn,
              ),
            ),
            label: 'Factura',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/chart-simple-solid.svg',
              width: getProportionateScreenWidth(22),
              colorFilter: const ColorFilter.mode(
                _iconColor,
                BlendMode.srcIn,
              ),
            ),
            activeIcon: SvgPicture.asset(
              'assets/icons/chart-simple-solid.svg',
              width: getProportionateScreenWidth(22),
              colorFilter: const ColorFilter.mode(
                pPrimaryColor,
                BlendMode.srcIn,
              ),
            ),
            label: 'Lista Factura',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/User.svg',
              width: getProportionateScreenWidth(22),
              colorFilter: const ColorFilter.mode(
                _iconColor,
                BlendMode.srcIn,
              ),
            ),
            activeIcon: SvgPicture.asset(
              'assets/icons/User.svg',
              width: getProportionateScreenWidth(22),
              colorFilter: const ColorFilter.mode(
                pPrimaryColor,
                BlendMode.srcIn,
              ),
            ),
            label: 'Cuenta',
          ),
        ],
      ),
    );
  }
}
