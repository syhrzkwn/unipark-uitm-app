import 'package:flutter/material.dart';
import 'package:unipark_uitm_app/src/utils/constants/colors.dart';
import 'package:unipark_uitm_app/src/utils/helpers/helper_functions.dart';

class WInboxListTileWidget extends StatelessWidget {
  const WInboxListTileWidget({
    super.key,
    required this.title,
    required this.subTitle,
    this.onTap,
  });

  final String title, subTitle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunction.isDarkMode(context);

    return Column(
      children: [
        ListTile(
          leading: CircleAvatar(
            radius: 20.0,
            backgroundColor: primaryColor,
            child: Icon(Icons.mail_outline, size: 20.0, color: dark ? whiteColor : whiteColor),
          ),
          title: Padding(
            padding: const EdgeInsets.only(bottom: 5.0),
            child: Text(title, style: TextStyle(color: dark ? whiteColor : textColor1), overflow: TextOverflow.ellipsis,),
          ),
          subtitle: Text(subTitle, style: TextStyle(color: dark ? whiteColor : textColor2), overflow: TextOverflow.ellipsis, maxLines: 2,),
          trailing: Icon(Icons.arrow_forward_ios_outlined, size: 14.0, color: dark ? whiteColor : textColor1),
          onTap: onTap,
        ),
        const Divider(color: borderColor, indent: 70.0),
      ],
    );
  }
}
