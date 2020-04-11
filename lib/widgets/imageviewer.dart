import "package:flutter/material.dart";

class ImageViewer extends StatefulWidget {
  final String url;
  final String title;
  ImageViewer({this.title, this.url});
  @override
  _ImageViewerState createState() => _ImageViewerState();
}

class _ImageViewerState extends State<ImageViewer> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
              height: screenSize.height,
              width: screenSize.width,
              child: Image.asset(
                "assets/coronavirus1.jpg",
                fit: BoxFit.cover,
              )),
              Container(
                color: Color.fromRGBO(200,200, 200, 0.9),
                height: screenSize.height,
                width: screenSize.width,
              ),
          Container(
            margin: const EdgeInsets.only(top: 80,right: 5),
            height: screenSize.height,
            width: screenSize.width,
            child: Center(
              child: RotatedBox(
                quarterTurns: 1,
                child: FadeInImage.assetNetwork(
                                  placeholderScale:0.1 ,
                                  placeholder: "assets/loader1.gif",
                                  image: widget.url,
                                )),
            ),
          ),
          SafeArea(
            child: Container(
              margin: EdgeInsets.only(top:10,right:10),
              alignment: Alignment.topRight,
              child: RotatedBox(
                quarterTurns: 1,
                child: IconButton(icon: Icon(Icons.arrow_back,color: Colors.white,size: 30,), onPressed: (){
                  Navigator.of(context).pop();
                }),
              ),
            ),
          )
        ],
      ),
    );
  }
}
