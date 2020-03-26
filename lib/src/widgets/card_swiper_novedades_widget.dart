import 'package:flutter/material.dart';
//import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:subastaspoli_mobile/src/models/novedad_model.dart';

class CardSwperNovedades extends StatelessWidget {
  final List<Novedad> novedad;

  CardSwperNovedades({@required this.novedad});

  @override
  Widget build(BuildContext context) {
    //final _screenSiza = MediaQuery.of(context).size;

    return _body();
    /*Container(
      padding: EdgeInsets.only(top: 10.0),
      child: new Swiper(
        layout: SwiperLayout.STACK,
        itemWidth: _screenSiza.width * 0.7,
        itemHeight: _screenSiza.height * 0.7 ,
        itemBuilder: (BuildContext context, int index) {
          
          return _card(index, _screenSiza, context);
        },
        itemCount: novedad.length,
        pagination: new SwiperPagination(),
        //control: new SwiperControl(),
      ),
    );*/
  }

  Widget _body() => Container(
        decoration: BoxDecoration(
          color: Colors.grey[50],
          border: BorderDirectional(
            top: BorderSide(color: Colors.grey[200]),
            bottom: BorderSide(color: Colors.grey[200]),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            // Child one : This is header
            header(),
            // Child 2 : This is horizontal scroll view to show all suggested friends
            // We have to provide size for list view that is why we are using container
            Container(
              height: 240.0,
              child: ListView.builder(
                itemCount: 10,
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 12.0),
                // This is the main property which is responsible for creating scrollable list
                itemBuilder: (BuildContext context, int index) {
                  // We have used container for decoration purpose.
                  // Main reason is to set border in all side and radius
                  return Container(
                    margin: EdgeInsets.only(right: 6.0),
                    width: 150.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(
                        color: Colors.grey[200],
                        width: 1.0,
                      ),
                    ),
                    // We have used stack just to place close icon
                    // Why stack? => this seems bit easy
                    child: Stack(
                      alignment: Alignment.center,
                      fit: StackFit.expand,
                      children: <Widget>[
                        // First child of the stack widget
                        Column(
                          //mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            // Top Padding
                            SizedBox(height: 16.0),
                            userImage(),
                            // Top Padding
                            SizedBox(height: 16.0),
                            userName(),
                            // Top Padding
                            SizedBox(height: 2.0),
                            userAction(),
                            // Top Padding
                            Expanded(child: SizedBox()),
                            button(),
                            // Bottom Padding
                            SizedBox(height: 16.0),
                          ],
                        ),
                        // Second child of the stack
                        // Close icon
                        close(),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      );

  // Header of the suggested container
  Widget header() => Container(
        margin: EdgeInsets.all(16.0),
        child: Row(
          children: <Widget>[
            Text(
              'Suggested for You',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(child: SizedBox()),
            Text(
              'See All',
              style: TextStyle(
                color: Colors.black26,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );

  // Suggested user image
  Widget userImage() => Container(
        height: 80.0,
        width: 80.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.blue,
          border: Border.all(
            color: Colors.black45,
            width: 0.5,
          ),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/images/child.jpg'),
          ),
        ),
      );

  // Suggested user name
  Widget userName() => Text(
        'Suman Shrestha',
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      );

  // Suggested user action against our profile i.e, Follows you (information)
  Widget userAction() => Text(
        'Follows you',
        style: TextStyle(color: Colors.black87),
      );

  // Button
  Widget button() => Container(
        width: double.infinity,
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(horizontal: 16.0),
        decoration: BoxDecoration(
          color: Colors.lightBlue,
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            'Follow Back',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );

  // Close icon
  Widget close() => Positioned(
        right: 6.0,
        top: 6.0,
        child: Icon(
          Icons.close,
          color: Colors.black26,
          size: 20.0,
        ),
      );

 /* Widget _card(int index, Size _screenSiza, BuildContext context) {
    final imagen = novedad[index].imagen;
    final card = Container(
      child: Column(
        children: <Widget>[
          FadeInImage(
            image: NetworkImage(imagen),
            placeholder: AssetImage('assets/jar-loading.gif'),
            fadeInDuration: Duration(milliseconds: 500),
            height: 100.0,
            fit: BoxFit.cover,
          ),
          Container(
              padding: EdgeInsets.all(20.0),
              child: Text(novedad[index].descripcion,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.caption)),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              FlatButton(
                child: Text('Mas información...'),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );

    return Container(
      margin: EdgeInsets.only(bottom: 15.0),
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
  }*/
}
