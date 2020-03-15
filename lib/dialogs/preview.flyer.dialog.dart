import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PreviewFlyer{

  static Widget previewDialog({@required String src, @required BuildContext context}){
    return GestureDetector(
      onTap: (){
        Navigator.pop(context);
      },
      child: Dialog(
        child: CachedNetworkImage(imageUrl: src,
          placeholder: (context, str){
            return Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.white24),),);
          },
        ),
      ),
    );
  }

}