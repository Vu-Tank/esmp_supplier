import 'package:esmp_supplier/src/model/store.dart';
import 'package:esmp_supplier/src/utils/app_style.dart';
import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';

class SideBarWigdet extends StatelessWidget {
  const SideBarWigdet(
      {super.key, required this.controller, required this.store});
  final Store store;
  final SidebarXController controller;
  @override
  Widget build(BuildContext context) {
    return SidebarX(
      controller: controller,
      theme: SidebarXTheme(
        itemTextPadding: const EdgeInsets.only(
          left: 30,
        ),
        selectedItemTextPadding: const EdgeInsets.only(left: 30),
        decoration: BoxDecoration(
          color: AppStyle.appColor,
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      footerDivider: const Divider(
        color: Colors.white,
      ),
      headerBuilder: (context, extended) => Column(
        children: [
          const SizedBox(
            height: 8.0,
          ),
          ClipOval(
              child: SizedBox.fromSize(
            size: const Size.fromRadius(50),
            child: Image.network(store.image.path),
          )),
          const SizedBox(
            height: 8.0,
          ),
          Text(
            store.storeName,
            style: AppStyle.h2,
            maxLines: 1,
            overflow: TextOverflow.fade,
          )
        ],
      ),
      extendedTheme: SidebarXTheme(
          width: 200,
          textStyle: AppStyle.h2,
          selectedTextStyle: AppStyle.h2.copyWith(color: Colors.blue)),
      items: const [
        SidebarXItem(icon: Icons.home, label: 'Trang chủ'),
        SidebarXItem(icon: Icons.chat_outlined, label: 'Tin nhắn')
      ],
    );
  }
}
