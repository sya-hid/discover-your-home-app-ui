import 'package:discover_your_home/consts.dart';
import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final ValueNotifier<Size> notifier = ValueNotifier(const Size(0, 0));
  final String category;
  final bool selected;
  CategoryItem({super.key, required this.category, required this.selected});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      notifier.value = (context.findRenderObject() as RenderBox).size;
    });
    return ValueListenableBuilder(
      valueListenable: notifier,
      builder: (context, value, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              category,
              style: proportional.copyWith(
                  color: selected ? blue : white,
                  fontSize: 16,
                  fontWeight: selected ? FontWeight.bold : FontWeight.normal),
            ),
            const SizedBox(height: 2),
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              width: selected ? value.width * 0.5 : 0,
              height: 2.5,
              decoration: BoxDecoration(
                  color: blue, borderRadius: BorderRadius.circular(10)),
            )
          ],
        );
      },
    );
  }
}
