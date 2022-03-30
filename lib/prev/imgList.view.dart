import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wallpix/core/core.dart';
import 'package:wallpix/prev/designs/utils/assets/ktransperentimage.util.dart';
import 'package:wallpix/prev/models/img.model.dart';

class ImgListView extends StatelessWidget {
  ImgListView({Key? key}) : super(key: key);
  final List<Img> imgList = <Img>[];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: FutureBuilder(
      future: getImgs(imgList: imgList),
      builder: (context, snapshot) {
        // return hasNetwork() ? const Text('data') :
        return snapshot.connectionState == ConnectionState.done
            ? GridView.count(
                // padding: const EdgeInsets.symmetric(
                //   horizontal: 30,
                // ),
                crossAxisCount: 2,
                // shrinkWrap: true,
                // crossAxisSpacing: 0.1,
                mainAxisSpacing: 20,
                childAspectRatio: MediaQuery.of(context).size.width /
                    (MediaQuery.of(context).size.height / 1.5),
                physics: const ClampingScrollPhysics(),
                children: imgList.map((img) {
                  return GridTile(
                    child: GestureDetector(
                      onTap: (() {}),
                      child: Hero(
                        tag: img.id,
                        child: SizedBox(
                          child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            child: FadeInImage.memoryNetwork(
                                fit: BoxFit.contain,
                                placeholder: kTransparentImage,
                                image: img.src.portrait),
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              )
            : const Center(
                child: CircularProgressIndicator(),
              );
      },
    ));
  }

  Future<void> getImgs({required List<Img> imgList}) async {
    http.Response response = await http.get(
        Uri.parse("https://api.pexels.com/v1/curated?per_page=80&page=1"),
        headers: {"Authorization": kAccessKey});
    log(response.body.toString());
    // Map<String, dynamic> jsonData = jsonDecode(response.body);
    // List<dynamic> imgBody = jsonData['photos'];
    // for (var element in imgBody) {
    //   imgList.add(Img.fromJson(element));
    // }
  }

  // Future<bool> hasNetwork() async {
  //   try {
  //     final result = await InternetAddress.lookup('example.com');
  //     return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
  //   } on SocketException catch (_) {
  //     return false;
  //   }
  // }
}
