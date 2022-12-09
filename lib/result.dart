import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:custom_grid_view/custom_grid_view.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:alert/alert.dart';
// import 'package:image_downloader/image_downloader.dart';

class result extends StatefulWidget {
  var ListOfLinks = [];
  result(links) {
    ListOfLinks = links;
  }
  @override
  createState() => _showingResult(ListOfLinks);
}

class _showingResult extends State<result> {
  var Lnks = [];
  _showingResult(lns) {
    Lnks = lns;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              TextButton(
                  onPressed: () {
                    save();
                    done();
                  },
                  child: Text("download")),
              // RawImage(image: Image.network(Lnks[5),),
              // CustomGridView(rows: 2, rowSpace: 8, children: [
              for (var i in Lnks)
                Container(
                  child: Image.network(i),
                  color: Colors.deepPurple,
                  // width: 100,
                  // height: 100,
                ),

              // ]),
              
            ],
          ),
        ));
  }

  //////////////////////////////////////
  void save() async {
    for (var i in Lnks) {
      GallerySaver.saveImage(i, toDcim: true);
    }
  }

  done() {
    Alert(message: 'downloading').show();
  }
}
