import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yy/screen/ScreenCustomer/Becomedriver.dart';

class ActivityListTile extends StatelessWidget {
  String title;
  String subtitle;
  Widget trailingImage;
  BuildContext context;
  //VoidCallback onTab;
  Color color;
  Color gradient;

  ActivityListTile(
      {required this.title,
      required this.context,
      required this.color,
      required this.gradient,
      required this.subtitle,
      required this.trailingImage});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 16, 8, 16),
      child: Stack(alignment: Alignment.bottomRight, children: <Widget>[
        Card(
            child: Container(
                // color: Colors.red,
                height: 120,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(const Radius.circular(5.0)),
                    gradient: LinearGradient(
                        colors: [color, gradient],
                        begin: Alignment.topCenter,
                        end: Alignment.topRight)),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        title: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(title),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            subtitle,
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ),
                      Container(
                        width: 80,
                        height: 30,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Becomedriver()));
                          },
                          child: Text(
                            'devenir',
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w400,
                                fontSize: 9,
                                color: Colors.black),
                          ),
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.white),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                                side: const BorderSide(
                                  color: Color.fromRGBO(40, 0, 81, 1),
                                  //color: Color.fromRGBO(40, 0, 81, 1),
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ))),
        Padding(
          padding: EdgeInsets.only(left: 10),
        ),

        //Logo(),
        Padding(
            padding: const EdgeInsets.only(bottom: 4, right: 0),
            child: Container(child: trailingImage))
      ]),
    );
  }
}
