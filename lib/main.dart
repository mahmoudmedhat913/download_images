import 'package:down/result.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:alert/alert.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';

void main() => runApp(Myapp());

class Myapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'my app',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'my app'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _res = null;
  Future<void> req() async {
    _res = await Permission.storage.request();
    _Update();
  }

  @override
  void initState() {
    req();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        toolbarOpacity: .6,
        // leading: CircleAvatar(backgroundImage: AssetImage("assets/Logo.jfif"),),
        actions: [
          IconButton(
            onPressed: () async {
              response != null
                  ? await Clipboard.setData(ClipboardData(text: "$linList"))
                  : Alert(message: 'error').show();
              print('cheak it bro');
              Alert(message: 'copied sucssesfuly').show();
              // copied successfully
            },
            icon: Icon(Icons.copy),
          ),
          IconButton(
            onPressed: () => changeURL(context),
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Center(
              child: Text(
                '$imgURL',
                selectionColor: Colors.amber,
              ),
            ),
            response != null ? Text(str) : Text('nothing yet'),
            response != null
                ? TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => result(linList)));
                    },
                    child: Text('show'))
                : Text(''),
            response != null
                ? TextButton(
                    onPressed: () {
                      save();
                    },
                    child: Text('Dwnload'))
                : Text(''),
            response != null
                ? TextButton(
                    onPressed: () {
                      AddingTarget(context);
                    },
                    child: Text('Add Target URL'))
                : Text(''),
                Text('$TargetURL'),
                TargetURL != ''
                ? TextButton(
                    onPressed: () {
                      cleareTaegetURL();
                    },
                    child: Text('Remove Target URL'))
                : Text(''),
                TargetURL != ''
                ? TextButton(
                    onPressed: () {
                      ApplyTargetURL();
                    },
                    child: Text('Apply Target URL'))
                : Text(''),
                for(var t in er)Text(t,selectionColor:Colors.red)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          getHttp();
          update();
        },
        child: const Icon(Icons.download),
      ),

      // floatingActionButtonLocation:FloatingActionButtonLocation.centerDocked ,
      // floatingActionButton: FloatingActionButton(onPressed: (){
      //   // _incrementCounter();
      // }),
    );
  }

  // var dio = Dio();
  void update() {
    setState(() {
      response;
      str = '';
      linList = [];
      _res;
      try {
        var s = response.data.toString().split("\<img");

        for (int i = 1; s[i] != null; i++) {
          var x = s[i].split('src=\"');
          var ne = x[1].split('\"');
          str += ne[0];
          int k = ne[0].split('.js').length;
          print('the value is : $k');
          if (k != 2) {
            linList.add(ne[0]);
          }
        }
      } catch (e) {
        print(e);
      }
    });
  }

  void _Update(){
    setState(() {
      _res;
      TargetURL;
      linList;
    });
  }

  var response;
  var str = '';
  var linList = [];
  void getHttp() async {
    try {
      response = await Dio().get('$imgURL',
          options: Options(
            followRedirects: false,
            validateStatus: (status) => true,
          ));
      var string = response.data.toString();
      var li = string.split('\<img');
      debugPrint(li[5].split('\"')[3]);
      // print(spli);
      update();
    } catch (e) {
      print(e);
    }
  }

  //////////////////////////////
  var imgURL = 'http://www.google.com',TargetURL='';
  changeURL(BuildContext context) {
    /////////Added successfuly////not used yet 4.40
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 100,
            // ignore: unnecessary_new
            child: new AlertDialog(
              content: Container(
                height: 100,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 2.0),
                    TextField(
                      decoration: InputDecoration(hintText: "Image URL"),

                      onChanged: (value) {
                        if (value != null && value != "") {
                          this.imgURL = value;
                        }
                      },
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: new Text('Submit'),
                  // textColor: Colors.blue,
                  onPressed: () {
                    print(imgURL);
                    //print(pdfURL);
                    setState(() {
                      this.imgURL;
                      // this.pdfURL;
                    });
                    Navigator.of(context).pop(true);
                  },
                ),
                TextButton(
                  child: new Text('Exit'),
                  // textColor: Colors.blue,
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                ),
              ],
            ),
          );
        });
  }
  var er=[];
  void save() async {
    for (var i in linList) {
      try{
      GallerySaver.saveImage(i, toDcim: true);
      }catch(e){
        er.add(e.toString());
      }
    }
  }
  ////////////////////////////////////////////////////
  AddingTarget(BuildContext context) {
    /////////Added successfuly////not used yet 4.40
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 100,
            // ignore: unnecessary_new
            child: new AlertDialog(
              //title: new Text('Done', style: TextStyle(fontSize: 15.0),),
              /// content: Text('Added'),

              content: Container(
                height: 100,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 2.0),
                    TextField(
                      decoration: InputDecoration(hintText: "The Targrt URL"),

                      onChanged: (value) {
                        if (value != null && value != "") {
                          this.TargetURL='';
                          this.TargetURL = value;
                        }
                      },
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: new Text('Submit'),
                  // textColor: Colors.blue,
                  onPressed: () {
                    print(imgURL);
                    //print(pdfURL);
                    setState(() {
                      this.imgURL;
                      // this.pdfURL;
                    });
                    Navigator.of(context).pop(true);
                  },
                ),
                TextButton(
                  child: new Text('Exit'),
                  // textColor: Colors.blue,
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                ),
              ],
            ),
          );
        });
  }

  void cleareTaegetURL(){
    TargetURL='';
    _Update();
  }
  
  void ApplyTargetURL() {
    for(int i=0;i<linList.length;i++){
      linList[i]=TargetURL+linList[i];
    }
    _Update();
  }
  
}