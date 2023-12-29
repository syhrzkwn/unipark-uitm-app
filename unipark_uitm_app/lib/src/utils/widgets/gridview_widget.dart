import 'package:flutter/material.dart';

class WGridView extends StatelessWidget {
  const WGridView({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
  });

  final int itemCount;
  final Widget? Function(BuildContext, int) itemBuilder;
  
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: itemCount,
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        mainAxisExtent: 120,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      itemBuilder: itemBuilder,
    );
  }
}
