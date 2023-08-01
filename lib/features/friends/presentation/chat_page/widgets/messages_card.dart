import 'package:flutter/material.dart';
import 'package:foodie/utils/widgets/loader_widget.dart';

import '../../../../../theme/theme.dart';

class MessagesCard extends StatelessWidget {
  const MessagesCard(this.type, this.check, this.message, this.time,
      {super.key});
  final String type;
  final bool check;
  final String message;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment:
          check ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        ConstrainedBox(
          constraints:
              BoxConstraints(maxWidth: MediaQuery.sizeOf(context).width * 0.7),
          child: Container(
            decoration: BoxDecoration(
                color: check ? ThemeColors.main : ThemeColors.greyText,
                borderRadius: BorderRadius.circular(16)),
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: type == 'image'
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image(
                      image: NetworkImage(message.substring(4)),
                      width: 200, // Set the width as per your requirement
                      fit: BoxFit.cover,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        }
                        return const Loader();
                      },
                    ),
                  )
                : Text(
                    '$message\n\n$time',
                    style: TextStyles.chatMessageMain
                        .copyWith(color: ThemeColors.white),
                  ),
          ),
        ),
      ],
    );
  }
}
