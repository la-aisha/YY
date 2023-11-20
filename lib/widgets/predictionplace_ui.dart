import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yy/global/global_var.dart';
import 'package:yy/methods/common_methods.dart';
import 'package:yy/model/address_model.dart';
import 'package:yy/model/prediction_model.dart';
import 'package:yy/provider/app_provider.dart';

class PredictionPlaceUI extends StatefulWidget {
  PredictionModel? predictionModel;
  PredictionPlaceUI({super.key, this.predictionModel});
  @override
  _PredictionPlaceUIState createState() =>
      _PredictionPlaceUIState(predictionModel: this.predictionModel);
}

class _PredictionPlaceUIState extends State<PredictionPlaceUI> {
  //place detail api
  PredictionModel? predictionModel;
  _PredictionPlaceUIState({this.predictionModel});
  var placeId;

  fetchClickPlaceDetails(String placeID) async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => Dialog(
              child: Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text('Details'),
                  ],
                ),
              ),
            ));

    String url =
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeID&key=$googleMapKey';
    var responseFromPlaceDetailsApi = await CommonMethods.sendRequestToApi(url);
    print("API Response: $responseFromPlaceDetailsApi");

    Navigator.of(context).pop();
    if (responseFromPlaceDetailsApi == 'error') {
      return;
    }
    if (responseFromPlaceDetailsApi['status'] == 'OK') {
      AddressModel dropoffLocation = AddressModel();
      var locationname = dropoffLocation.placeName =
          responseFromPlaceDetailsApi['result']['name'];
      dropoffLocation.latitutePosition =
          responseFromPlaceDetailsApi['result']['geometry']['location']['lat'];
      dropoffLocation.longitudePosition =
          responseFromPlaceDetailsApi['result']['geometry']['location']['lng'];
      dropoffLocation.placeId = placeID;
      print("dropofflocation place name = ${dropoffLocation.placeName}");

      print("dropofflocation place id= ${dropoffLocation.placeId}");
      placeId = placeID;

      //assign
      // predictionModel = dropoffLocation.;
      locationname = widget.predictionModel!.place_id.toString();
      Provider.of<AppProvider>(context, listen: false)
          .updateDropoffLocation(dropoffLocation);
      Navigator.pop(context, 'placeselected');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () async {
          fetchClickPlaceDetails(
            widget.predictionModel!.place_id.toString(),
          );
          print('dans l evevated button' + widget.predictionModel!.place_id.toString());
          /*  print("la place choisie clickedplace: $clickedplace");
          if (clickedplace == 'placeselected') {
            String droppofflocation = await
                Provider.of<AppProvider>(context).dropoffLocation?.placeName ??
                    "";
            print("dropofflocation in button= $droppofflocation");
          } */
        },
        style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
        child: Container(
          //height: double.infinity,
          child: Column(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.share_location,
                    color: Colors.grey,
                  ),
                  const SizedBox(
                    width: 13,
                  ),
                  Expanded(
                      child: Column(
                    children: [
                      Text(
                        widget.predictionModel!.main_text.toString(),
                        overflow: TextOverflow.clip,
                        style: TextStyle(fontSize: 16, color: Colors.black87),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Text(
                        widget.predictionModel!.main_text.toString(),
                        overflow: TextOverflow.clip,
                        style: TextStyle(fontSize: 12, color: Colors.black54),
                      ),
                    ],
                  ))
                ],
              )
            ],
          ),
        ));
  }
}
