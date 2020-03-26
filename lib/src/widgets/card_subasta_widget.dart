import 'package:flutter/material.dart';
import 'package:subastaspoli_mobile/src/customIcons/custom_icons.dart';
import 'package:subastaspoli_mobile/src/models/subastas_model.dart';
import 'package:subastaspoli_mobile/src/pages/detalle_evento_page.dart';
import 'package:subastaspoli_mobile/src/pages/detalle_subasta_page.dart';
import 'package:subastaspoli_mobile/src/utils/session.dart';
import 'package:subastaspoli_mobile/src/utils/utils.dart';

class CardSubastas extends StatefulWidget {
  final SubastasModel subasta;

  CardSubastas({this.subasta});

  @override
  _CardSubastasState createState() => _CardSubastasState();
}

class _CardSubastasState extends State<CardSubastas> {
  int pageViewActiveIndex = 0;
  Utils _util = Utils();
  int likeCount = -1;
  List<Widget> geleria = List<Widget>();
  final Session _session = new Session();

  final String caption =
      '''Styling text in Flutter #something, Styling text in Flutter. #Another, #nepal, Styling text in Flutter. #ktm, #love, #newExperiance Styling text in Flutter. Styling text in Flutter. Styling text in Flutter.''';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (geleria.isEmpty) {
      geleria.add(_util.imageFromBase64String(widget.subasta.imagenUrl));
      if (widget.subasta.videoUrl != null &&
          widget.subasta.videoUrl.isNotEmpty) {
        geleria.add(_util.videoEvento(widget.subasta.videoUrl, context));
      }
    }

    final card = Container(
      //clipBehavior: Clip.antiAlias,

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // User profile, name and more option
          userInfoRow(),
          // Single or collection of images/videos
          gallery(),
          // For padding
          SizedBox(height: 8.0),
          // Different icon buttons and image slider indicator
          actions(),
          // For padding
          SizedBox(height: 8.0),
          //Caption
          galleryCaption(),
          // For padding
          SizedBox(height: 4.0),
          // View all comments
          botonMasInformacion()
        ],
      ),
    );

    return Container(
      margin: EdgeInsets.only(bottom: 30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.black26,
              blurRadius: 10.0,
              spreadRadius: 2.0,
              offset: Offset(2.0, 10.0))
        ],
        color: Colors.white,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30.0),
        child: card,
      ),
    );
  }

  Widget userInfoRow() => Row(
        children: <Widget>[
          SizedBox(width: 10),
          Text(
            widget.subasta.nombre ,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(child: SizedBox()),
          SizedBox(height: 40),
          /*IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),*/
        ],
      );

  Widget gallery() => Container(
      constraints: BoxConstraints(
        maxHeight: 300.0, // changed to 400
        minHeight: 200.0, // changed to 200
        maxWidth: double.infinity,
        minWidth: double.infinity,
      ),
      decoration: BoxDecoration(
        //color: Colors.white,
        border: Border(
          top: BorderSide(
            color: Colors.grey[200],
            width: 1.0,
          ),
        ),
      ),
      // child: Image.asset(
      //   UIImageData.storiesList[index],
      //   fit: BoxFit.contain,
      // ),
      child: galleryPageView());

  Widget galleryPageView() {
    return PageView.builder(
      itemCount: geleria.length,
      onPageChanged: (currentIndex) {
        setState(() {
          this.pageViewActiveIndex = currentIndex;
        });
      },
      itemBuilder: (BuildContext context, int index) {
        return geleria[index];
      },
    );
  }

  Widget actions() => Stack(
        alignment: Alignment.center,
        children: <Widget>[
          // Slider indicator
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ...geleria.map((s) {
                  return Container(
                    margin: EdgeInsets.only(right: 4.0),
                    height: geleria.length <= 1 ? 0.0 : 6.0,
                    width: geleria.length <= 1 ? 0.0 : 6.0,
                    decoration: BoxDecoration(
                      color: pageViewActiveIndex == geleria.indexOf(s)
                          ? Colors.blueAccent
                          : Colors.grey[300],
                      shape: BoxShape.circle,
                    ),
                  );
                }),
              ],
            ),
          ),

          // Actions buttons/icons
          Row(
            children: <Widget>[
              SizedBox(width: 12.0), // For padding
              Icon(CustomIcons.like_lineal),
              SizedBox(width: 16.0), // For padding
              Icon(CustomIcons.comment),
              SizedBox(width: 16.0), // For padding
              Transform.rotate(
                angle: 0.4,
                child: Icon(CustomIcons.paper_plane),
              ),
              Expanded(child: SizedBox()),
              Icon(CustomIcons.bookmark_lineal),
              SizedBox(width: 10.0), // For padding
            ],
          ),
        ],
      );

  Widget galleryCaption() => Padding(
        padding: const EdgeInsets.only(left: 12.0, right: 16),
        child: RichText(
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          text: TextSpan(
            style: TextStyle(color: Colors.black),
            children: [
              TextSpan(
                text: 'Decripción: ',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ..._processCaption(
                caption,
                '#',
                TextStyle(color: Colors.blue),
              ),
            ],
          ),
        ),
      );

  Widget botonMasInformacion() => Padding(
        padding: const EdgeInsets.only(left: 12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            FlatButton(
              child: Text(
                'Ver lostes...',
                style: TextStyle(color: Colors.black45),
              ),
              onPressed: () {
                final subasta = widget.subasta;
                print(subasta);
                _session.putEntidad(key: "subastaid", id: subasta.id);
                Navigator.pushNamed(context, DetalleSubastaPage.pageName,
                    arguments: subasta);
              },
            ),
          ],
        ),
      );

  List<TextSpan> _processCaption(
      String caption, String matcher, TextStyle style) {
    List<TextSpan> spans = [];

    //spans.add(TextSpan(text: 'prueba link...' + ' ', style: style));
    spans.add(TextSpan(text: widget.subasta.decripcion + ' '));

    return spans;
  }

  List<Widget> sliderIndicator(int totalItem, int currentItem) {
    return null;
  }
}
