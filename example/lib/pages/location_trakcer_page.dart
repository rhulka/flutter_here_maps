import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../drawer.dart';
import 'map_center.dart';
import 'package:flutter_here_maps/flutter_here_maps.dart';

class LocationTrackerPage extends StatefulWidget {
  static String route = "/LocationTrackerPage";

  @override
  _LocationTrackerPageState createState() => _LocationTrackerPageState();
}

class _LocationTrackerPageState extends State<LocationTrackerPage> {
  Completer<HereMapsController> _controller = Completer();

  StreamSubscription trackerSubscription;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        drawer: buildDrawer(context, MapCenterPage.route),
        appBar: AppBar(
          title: const Text('Map tracker'),
        ),
        body: MapView(
          onMapCreated: (controller) {
            _controller.complete(controller);
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _start();
          },
          child: Icon(Icons.star),
        ),
      ),
    );
  }

  _start() {
    _initConfiguration();
    trackerSubscription = Stream.periodic(
            Duration(seconds: 1), (int i) => points[i % points.length])
        .listen((event) {
      final lng = event["lng"];
      final lat = event["lat"];
      _updateMapLocation(double.parse(lng), double.parse(lat));
    });
  }

  @override
  void dispose() {
    trackerSubscription?.cancel();
    super.dispose();
  }

  Future<void> _initConfiguration() async {
    final configuration = Configuration()
      ..trafficVisible = false
      ..positionIndicator = (Configuration_PositionIndicator()
        ..isAccuracyIndicatorVisible = (BoolValue()..value = true)
        ..isVisible = (BoolValue()..value = true));
    final map = await _controller.future;
    map.setConfiguration(configuration);
  }

  _updateMapLocation(double lat, double lng) async {
    final map = await _controller.future;
    final coordinate = Coordinate()
      ..lat = lng
      ..lng = lat;

    map
        .setMapObject(MapObject()
          ..uniqueId = "MarkerTracker"
          ..marker = (MapMarker()
            ..coordinate = coordinate
            ..image = "assets/pin.png"))
        .then((value) => map.setCenter(MapCenter()
          ..coordinate = coordinate
          ..zoomLevel = (FloatValue()..value = 14.0)));
  }
}

const points = [
  {"lng": "34.773963928222656", "lat": "32.06356430053711"},
  {"lng": "34.773963928222656", "lat": "32.06356430053711"},
  {"lng": "34.77452087402344", "lat": "32.063934326171875"},
  {"lng": "34.77452087402344", "lat": "32.063934326171875"},
  {"lng": "34.77520751953125", "lat": "32.06439208984375"},
  {"lng": "34.77520751953125", "lat": "32.06439208984375"},
  {"lng": "34.77600860595703", "lat": "32.06492614746094"},
  {"lng": "34.77600860595703", "lat": "32.06492614746094"},
  {"lng": "34.77667999267578", "lat": "32.065372467041016"},
  {"lng": "34.77667999267578", "lat": "32.065372467041016"},
  {"lng": "34.77735137939453", "lat": "32.06582260131836"},
  {"lng": "34.77735137939453", "lat": "32.06582260131836"},
  {"lng": "34.77752685546875", "lat": "32.06623458862305"},
  {"lng": "34.77752685546875", "lat": "32.06623458862305"},
  {"lng": "34.777801513671875", "lat": "32.067073822021484"},
  {"lng": "34.777801513671875", "lat": "32.067073822021484"},
  {"lng": "34.77803039550781", "lat": "32.067771911621094"},
  {"lng": "34.77803039550781", "lat": "32.067771911621094"},
  {"lng": "34.77827453613281", "lat": "32.06846237182617"},
  {"lng": "34.77827453613281", "lat": "32.06846237182617"},
  {"lng": "34.778507232666016", "lat": "32.069156646728516"},
  {"lng": "34.778507232666016", "lat": "32.069156646728516"},
  {"lng": "34.77872085571289", "lat": "32.06985855102539"},
  {"lng": "34.77872085571289", "lat": "32.06985855102539"},
  {"lng": "34.77894592285156", "lat": "32.070556640625"},
  {"lng": "34.77894592285156", "lat": "32.070556640625"},
  {"lng": "34.779170989990234", "lat": "32.071231842041016"},
  {"lng": "34.779170989990234", "lat": "32.071231842041016"},
  {"lng": "34.780067443847656", "lat": "32.07108688354492"},
  {"lng": "34.780067443847656", "lat": "32.07108688354492"},
  {"lng": "34.78087615966797", "lat": "32.07087326049805"},
  {"lng": "34.78087615966797", "lat": "32.07087326049805"},
  {"lng": "34.7816047668457", "lat": "32.07062911987305"},
  {"lng": "34.7816047668457", "lat": "32.07062911987305"},
  {"lng": "34.78123092651367", "lat": "32.069976806640625"},
  {"lng": "34.78123092651367", "lat": "32.069976806640625"},
  {"lng": "34.7818489074707", "lat": "32.069705963134766"},
  {"lng": "34.7818489074707", "lat": "32.069705963134766"},
  {"lng": "34.78284454345703", "lat": "32.069549560546875"},
  {"lng": "34.78284454345703", "lat": "32.069549560546875"},
  {"lng": "34.783687591552734", "lat": "32.069488525390625"},
  {"lng": "34.783687591552734", "lat": "32.069488525390625"},
  {"lng": "34.784523010253906", "lat": "32.06943130493164"},
  {"lng": "34.784523010253906", "lat": "32.06943130493164"},
  {"lng": "34.785362243652344", "lat": "32.06937789916992"},
  {"lng": "34.785362243652344", "lat": "32.06937789916992"},
  {"lng": "34.78638458251953", "lat": "32.06930160522461"},
  {"lng": "34.78638458251953", "lat": "32.06930160522461"},
  {"lng": "34.7872314453125", "lat": "32.06924057006836"},
  {"lng": "34.7872314453125", "lat": "32.06924057006836"},
  {"lng": "34.7878532409668", "lat": "32.06955337524414"},
  {"lng": "34.7878532409668", "lat": "32.06955337524414"},
  {"lng": "34.78836441040039", "lat": "32.07029724121094"},
  {"lng": "34.78836441040039", "lat": "32.07029724121094"},
  {"lng": "34.78899002075195", "lat": "32.07077407836914"},
  {"lng": "34.78899002075195", "lat": "32.07077407836914"},
  {"lng": "34.789512634277344", "lat": "32.0713005065918"},
  {"lng": "34.789512634277344", "lat": "32.0713005065918"},
  {"lng": "34.78980255126953", "lat": "32.07197952270508"},
  {"lng": "34.78980255126953", "lat": "32.07197952270508"},
  {"lng": "34.79015350341797", "lat": "32.072792053222656"},
  {"lng": "34.79015350341797", "lat": "32.072792053222656"},
  {"lng": "34.790443420410156", "lat": "32.07347106933594"},
  {"lng": "34.790443420410156", "lat": "32.07347106933594"},
  {"lng": "34.790794372558594", "lat": "32.074283599853516"},
  {"lng": "34.790794372558594", "lat": "32.074283599853516"},
  {"lng": "34.79108428955078", "lat": "32.07495880126953"},
  {"lng": "34.79108428955078", "lat": "32.07495880126953"},
  {"lng": "34.791446685791016", "lat": "32.07561111450195"},
  {"lng": "34.791446685791016", "lat": "32.07561111450195"},
  {"lng": "34.79183578491211", "lat": "32.07624816894531"},
  {"lng": "34.79183578491211", "lat": "32.07624816894531"},
  {"lng": "34.79222869873047", "lat": "32.07688903808594"},
  {"lng": "34.79222869873047", "lat": "32.07688903808594"},
  {"lng": "34.792694091796875", "lat": "32.07765197753906"},
  {"lng": "34.792694091796875", "lat": "32.07765197753906"},
  {"lng": "34.793087005615234", "lat": "32.07829284667969"},
  {"lng": "34.793087005615234", "lat": "32.07829284667969"},
  {"lng": "34.79345703125", "lat": "32.07893753051758"},
  {"lng": "34.79345703125", "lat": "32.07893753051758"},
  {"lng": "34.79381561279297", "lat": "32.07958984375"},
  {"lng": "34.79381561279297", "lat": "32.07958984375"},
  {"lng": "34.7941780090332", "lat": "32.080387115478516"},
  {"lng": "34.7941780090332", "lat": "32.080387115478516"},
  {"lng": "34.79432678222656", "lat": "32.08109664916992"},
  {"lng": "34.79432678222656", "lat": "32.08109664916992"},
  {"lng": "34.794471740722656", "lat": "32.08180618286133"},
  {"lng": "34.794471740722656", "lat": "32.08180618286133"},
  {"lng": "34.79465103149414", "lat": "32.0826530456543"},
  {"lng": "34.79465103149414", "lat": "32.0826530456543"},
  {"lng": "34.794795989990234", "lat": "32.0833625793457"},
  {"lng": "34.794795989990234", "lat": "32.0833625793457"},
  {"lng": "34.79497528076172", "lat": "32.08421325683594"},
  {"lng": "34.79497528076172", "lat": "32.08421325683594"},
  {"lng": "34.79512405395508", "lat": "32.084930419921875"},
  {"lng": "34.79512405395508", "lat": "32.084930419921875"},
  {"lng": "34.79527282714844", "lat": "32.08565139770508"},
  {"lng": "34.79527282714844", "lat": "32.08565139770508"},
  {"lng": "34.79500961303711", "lat": "32.08514404296875"},
  {"lng": "34.79500961303711", "lat": "32.08514404296875"},
  {"lng": "34.79486846923828", "lat": "32.08443069458008"},
  {"lng": "34.79486846923828", "lat": "32.08443069458008"},
  {"lng": "34.79472732543945", "lat": "32.08372116088867"},
  {"lng": "34.79472732543945", "lat": "32.08372116088867"},
  {"lng": "34.794586181640625", "lat": "32.0830078125"},
  {"lng": "34.794586181640625", "lat": "32.0830078125"},
  {"lng": "34.79481887817383", "lat": "32.082481384277344"},
  {"lng": "34.79481887817383", "lat": "32.082481384277344"},
  {"lng": "34.795555114746094", "lat": "32.08213806152344"},
  {"lng": "34.795555114746094", "lat": "32.08213806152344"},
  {"lng": "34.79532241821289", "lat": "32.0812873840332"},
  {"lng": "34.79532241821289", "lat": "32.0812873840332"},
  {"lng": "34.795127868652344", "lat": "32.08058547973633"},
  {"lng": "34.795127868652344", "lat": "32.08058547973633"},
  {"lng": "34.79499053955078", "lat": "32.07986831665039"},
  {"lng": "34.79499053955078", "lat": "32.07986831665039"},
  {"lng": "34.794403076171875", "lat": "32.079383850097656"},
  {"lng": "34.794403076171875", "lat": "32.079383850097656"},
  {"lng": "34.79359817504883", "lat": "32.07897186279297"},
  {"lng": "34.79359817504883", "lat": "32.07897186279297"},
  {"lng": "34.79380416870117", "lat": "32.07958984375"},
  {"lng": "34.79380416870117", "lat": "32.07958984375"},
  {"lng": "34.79418182373047", "lat": "32.080387115478516"},
  {"lng": "34.79418182373047", "lat": "32.080387115478516"},
  {"lng": "34.794368743896484", "lat": "32.08123779296875"},
  {"lng": "34.794368743896484", "lat": "32.08123779296875"},
  {"lng": "34.7945556640625", "lat": "32.082088470458984"},
  {"lng": "34.7945556640625", "lat": "32.082088470458984"},
  {"lng": "34.79471206665039", "lat": "32.08279800415039"},
  {"lng": "34.79471206665039", "lat": "32.08279800415039"},
  {"lng": "34.794837951660156", "lat": "32.08351516723633"},
  {"lng": "34.794837951660156", "lat": "32.08351516723633"},
  {"lng": "34.79494857788086", "lat": "32.08423614501953"},
  {"lng": "34.79494857788086", "lat": "32.08423614501953"},
  {"lng": "34.795082092285156", "lat": "32.08509063720703"},
  {"lng": "34.795082092285156", "lat": "32.08509063720703"},
  {"lng": "34.79519271850586", "lat": "32.0858039855957"},
  {"lng": "34.79519271850586", "lat": "32.0858039855957"},
  {"lng": "34.79530334472656", "lat": "32.086517333984375"},
  {"lng": "34.79530334472656", "lat": "32.086517333984375"},
  {"lng": "34.795413970947266", "lat": "32.08722686767578"},
  {"lng": "34.795413970947266", "lat": "32.08722686767578"},
  {"lng": "34.79552459716797", "lat": "32.08794021606445"},
  {"lng": "34.79552459716797", "lat": "32.08794021606445"},
  {"lng": "34.79563522338867", "lat": "32.08865737915039"},
  {"lng": "34.79563522338867", "lat": "32.08865737915039"},
  {"lng": "34.795570373535156", "lat": "32.08937072753906"},
  {"lng": "34.795570373535156", "lat": "32.08937072753906"},
  {"lng": "34.79542541503906", "lat": "32.09008026123047"},
  {"lng": "34.79542541503906", "lat": "32.09008026123047"},
  {"lng": "34.79525375366211", "lat": "32.0909309387207"},
  {"lng": "34.79525375366211", "lat": "32.0909309387207"},
  {"lng": "34.79510498046875", "lat": "32.09164810180664"},
  {"lng": "34.79510498046875", "lat": "32.09164810180664"},
  {"lng": "34.794960021972656", "lat": "32.092369079589844"},
  {"lng": "34.794960021972656", "lat": "32.092369079589844"},
  {"lng": "34.79478454589844", "lat": "32.09322738647461"},
  {"lng": "34.79478454589844", "lat": "32.09322738647461"},
  {"lng": "34.794639587402344", "lat": "32.093936920166016"},
  {"lng": "34.794639587402344", "lat": "32.093936920166016"},
  {"lng": "34.79449462890625", "lat": "32.09464645385742"},
  {"lng": "34.79449462890625", "lat": "32.09464645385742"},
  {"lng": "34.794349670410156", "lat": "32.09535598754883"},
  {"lng": "34.794349670410156", "lat": "32.09535598754883"},
  {"lng": "34.79420471191406", "lat": "32.0960693359375"},
  {"lng": "34.79420471191406", "lat": "32.0960693359375"},
  {"lng": "34.7940559387207", "lat": "32.09678268432617"},
  {"lng": "34.7940559387207", "lat": "32.09678268432617"},
  {"lng": "34.793880462646484", "lat": "32.09764099121094"},
  {"lng": "34.793880462646484", "lat": "32.09764099121094"},
  {"lng": "34.79373550415039", "lat": "32.09835433959961"},
  {"lng": "34.79373550415039", "lat": "32.09835433959961"},
  {"lng": "34.79356384277344", "lat": "32.09920120239258"},
  {"lng": "34.79356384277344", "lat": "32.09920120239258"},
  {"lng": "34.793418884277344", "lat": "32.09991455078125"},
  {"lng": "34.793418884277344", "lat": "32.09991455078125"},
  {"lng": "34.79327392578125", "lat": "32.100624084472656"},
  {"lng": "34.79327392578125", "lat": "32.100624084472656"},
  {"lng": "34.793128967285156", "lat": "32.10133361816406"},
  {"lng": "34.793128967285156", "lat": "32.10133361816406"},
  {"lng": "34.79298400878906", "lat": "32.1020393371582"},
  {"lng": "34.79298400878906", "lat": "32.1020393371582"},
  {"lng": "34.79283905029297", "lat": "32.102745056152344"},
  {"lng": "34.79283905029297", "lat": "32.102745056152344"},
  {"lng": "34.79289245605469", "lat": "32.10211944580078"},
  {"lng": "34.79289245605469", "lat": "32.10211944580078"},
  {"lng": "34.7929573059082", "lat": "32.10139846801758"},
  {"lng": "34.7929573059082", "lat": "32.10139846801758"},
  {"lng": "34.79269027709961", "lat": "32.10145568847656"},
  {"lng": "34.79269027709961", "lat": "32.10145568847656"},
  {"lng": "34.79228973388672", "lat": "32.101131439208984"},
  {"lng": "34.79228973388672", "lat": "32.101131439208984"},
  {"lng": "34.79280090332031", "lat": "32.10102844238281"},
  {"lng": "34.79280090332031", "lat": "32.10102844238281"},
  {"lng": "34.79279327392578", "lat": "32.09988784790039"},
  {"lng": "34.79279327392578", "lat": "32.09988784790039"},
  {"lng": "34.790836334228516", "lat": "32.099422454833984"},
  {"lng": "34.790836334228516", "lat": "32.099422454833984"},
  {"lng": "34.789798736572266", "lat": "32.09999084472656"},
  {"lng": "34.789798736572266", "lat": "32.09999084472656"},
  {"lng": "34.7894172668457", "lat": "32.10139465332031"},
  {"lng": "34.7894172668457", "lat": "32.10139465332031"},
  {"lng": "34.78966522216797", "lat": "32.10280227661133"},
  {"lng": "34.78966522216797", "lat": "32.10280227661133"},
  {"lng": "34.79133605957031", "lat": "32.102901458740234"},
  {"lng": "34.79133605957031", "lat": "32.102901458740234"},
  {"lng": "34.792755126953125", "lat": "32.10316467285156"},
  {"lng": "34.792755126953125", "lat": "32.10316467285156"},
  {"lng": "34.79243087768555", "lat": "32.10488510131836"},
  {"lng": "34.79243087768555", "lat": "32.10488510131836"},
  {"lng": "34.79216384887695", "lat": "32.10633087158203"},
  {"lng": "34.79216384887695", "lat": "32.10633087158203"},
  {"lng": "34.79201126098633", "lat": "32.1077995300293"},
  {"lng": "34.79201126098633", "lat": "32.1077995300293"},
  {"lng": "34.79212188720703", "lat": "32.10923385620117"},
  {"lng": "34.79212188720703", "lat": "32.10923385620117"},
  {"lng": "34.79231643676758", "lat": "32.11066436767578"},
  {"lng": "34.79231643676758", "lat": "32.11066436767578"},
  {"lng": "34.792510986328125", "lat": "32.11209487915039"},
  {"lng": "34.792510986328125", "lat": "32.11209487915039"},
  {"lng": "34.794036865234375", "lat": "32.112754821777344"},
  {"lng": "34.794036865234375", "lat": "32.112754821777344"},
  {"lng": "34.792667388916016", "lat": "32.11299514770508"},
  {"lng": "34.792667388916016", "lat": "32.11299514770508"},
  {"lng": "34.79302215576172", "lat": "32.114688873291016"},
  {"lng": "34.79302215576172", "lat": "32.114688873291016"},
  {"lng": "34.7933464050293", "lat": "32.11640930175781"},
  {"lng": "34.7933464050293", "lat": "32.11640930175781"},
  {"lng": "34.793670654296875", "lat": "32.11811065673828"},
  {"lng": "34.793670654296875", "lat": "32.11811065673828"},
  {"lng": "34.793941497802734", "lat": "32.11953353881836"},
  {"lng": "34.793941497802734", "lat": "32.11953353881836"},
  {"lng": "34.794212341308594", "lat": "32.12095642089844"},
  {"lng": "34.794212341308594", "lat": "32.12095642089844"},
  {"lng": "34.794551849365234", "lat": "32.12266159057617"},
  {"lng": "34.794551849365234", "lat": "32.12266159057617"},
  {"lng": "34.794803619384766", "lat": "32.12408447265625"},
  {"lng": "34.794803619384766", "lat": "32.12408447265625"},
  {"lng": "34.795066833496094", "lat": "32.125511169433594"},
  {"lng": "34.795066833496094", "lat": "32.125511169433594"},
  {"lng": "34.577430725097656", "lat": "31.696638107299805"},
  {"lng": "34.577430725097656", "lat": "31.696638107299805"},
  {"lng": "34.79568099975586", "lat": "32.12862014770508"},
  {"lng": "34.79568099975586", "lat": "32.12862014770508"},
  {"lng": "34.795963287353516", "lat": "32.13004684448242"},
  {"lng": "34.795963287353516", "lat": "32.13004684448242"},
  {"lng": "34.79627990722656", "lat": "32.13146209716797"},
  {"lng": "34.79627990722656", "lat": "32.13146209716797"},
  {"lng": "34.796607971191406", "lat": "32.13286590576172"},
  {"lng": "34.796607971191406", "lat": "32.13286590576172"},
  {"lng": "34.797210693359375", "lat": "32.134521484375"},
  {"lng": "34.797210693359375", "lat": "32.134521484375"},
  {"lng": "34.79793930053711", "lat": "32.135826110839844"},
  {"lng": "34.79793930053711", "lat": "32.135826110839844"},
  {"lng": "34.79867935180664", "lat": "32.137123107910156"},
  {"lng": "34.79867935180664", "lat": "32.137123107910156"},
  {"lng": "34.79962921142578", "lat": "32.1383171081543"},
  {"lng": "34.79962921142578", "lat": "32.1383171081543"},
  {"lng": "34.80058670043945", "lat": "32.13951873779297"},
  {"lng": "34.80058670043945", "lat": "32.13951873779297"},
  {"lng": "34.801334381103516", "lat": "32.140811920166016"},
  {"lng": "34.801334381103516", "lat": "32.140811920166016"},
  {"lng": "34.80190658569336", "lat": "32.14216232299805"},
  {"lng": "34.80190658569336", "lat": "32.14216232299805"},
  {"lng": "34.80243682861328", "lat": "32.14384078979492"},
  {"lng": "34.80243682861328", "lat": "32.14384078979492"},
  {"lng": "34.80297088623047", "lat": "32.1455078125"},
  {"lng": "34.80297088623047", "lat": "32.1455078125"},
  {"lng": "34.80342102050781", "lat": "32.14689254760742"},
  {"lng": "34.80342102050781", "lat": "32.14689254760742"},
  {"lng": "34.80387878417969", "lat": "32.14827346801758"},
  {"lng": "34.80387878417969", "lat": "32.14827346801758"},
  {"lng": "34.804508209228516", "lat": "32.14960861206055"},
  {"lng": "34.804508209228516", "lat": "32.14960861206055"},
  {"lng": "34.80521011352539", "lat": "32.150917053222656"},
  {"lng": "34.80521011352539", "lat": "32.150917053222656"},
  {"lng": "34.80621337890625", "lat": "32.15241622924805"},
  {"lng": "34.80621337890625", "lat": "32.15241622924805"},
  {"lng": "34.807029724121094", "lat": "32.15367889404297"},
  {"lng": "34.807029724121094", "lat": "32.15367889404297"},
  {"lng": "34.80783462524414", "lat": "32.15494918823242"},
  {"lng": "34.80783462524414", "lat": "32.15494918823242"},
  {"lng": "34.80887222290039", "lat": "32.15642547607422"},
  {"lng": "34.80887222290039", "lat": "32.15642547607422"},
  {"lng": "34.809730529785156", "lat": "32.15766525268555"},
  {"lng": "34.809730529785156", "lat": "32.15766525268555"},
  {"lng": "34.810569763183594", "lat": "32.15892028808594"},
  {"lng": "34.810569763183594", "lat": "32.15892028808594"},
  {"lng": "34.81171417236328", "lat": "32.159942626953125"},
  {"lng": "34.81171417236328", "lat": "32.159942626953125"},
  {"lng": "34.57743835449219", "lat": "31.696638107299805"},
  {"lng": "34.57743835449219", "lat": "31.696638107299805"},
  {"lng": "34.815372467041016", "lat": "32.16046905517578"},
  {"lng": "34.815372467041016", "lat": "32.16046905517578"},
  {"lng": "34.81703567504883", "lat": "32.16073226928711"},
  {"lng": "34.81703567504883", "lat": "32.16073226928711"},
  {"lng": "34.81864929199219", "lat": "32.16115188598633"},
  {"lng": "34.81864929199219", "lat": "32.16115188598633"},
  {"lng": "34.820491790771484", "lat": "32.161869049072266"},
  {"lng": "34.820491790771484", "lat": "32.161869049072266"},
  {"lng": "34.8220100402832", "lat": "32.16250991821289"},
  {"lng": "34.8220100402832", "lat": "32.16250991821289"},
  {"lng": "34.8238525390625", "lat": "32.163246154785156"},
  {"lng": "34.8238525390625", "lat": "32.163246154785156"},
  {"lng": "34.825828552246094", "lat": "32.16350173950195"},
  {"lng": "34.825828552246094", "lat": "32.16350173950195"},
  {"lng": "34.8275146484375", "lat": "32.163352966308594"},
  {"lng": "34.8275146484375", "lat": "32.163352966308594"},
  {"lng": "34.82918167114258", "lat": "32.16312789916992"},
  {"lng": "34.82918167114258", "lat": "32.16312789916992"},
  {"lng": "34.830841064453125", "lat": "32.16289520263672"},
  {"lng": "34.830841064453125", "lat": "32.16289520263672"},
  {"lng": "34.83250427246094", "lat": "32.16265869140625"},
  {"lng": "34.83250427246094", "lat": "32.16265869140625"},
  {"lng": "34.83417510986328", "lat": "32.162418365478516"},
  {"lng": "34.83417510986328", "lat": "32.162418365478516"},
  {"lng": "34.836181640625", "lat": "32.162113189697266"},
  {"lng": "34.836181640625", "lat": "32.162113189697266"},
  {"lng": "34.83784484863281", "lat": "32.16184616088867"},
  {"lng": "34.83784484863281", "lat": "32.16184616088867"},
  {"lng": "34.83949661254883", "lat": "32.1615104675293"},
  {"lng": "34.83949661254883", "lat": "32.1615104675293"},
  {"lng": "34.84113693237305", "lat": "32.16115951538086"},
  {"lng": "34.84113693237305", "lat": "32.16115951538086"},
  {"lng": "34.84275817871094", "lat": "32.160736083984375"},
  {"lng": "34.84275817871094", "lat": "32.160736083984375"},
  {"lng": "34.844390869140625", "lat": "32.16031265258789"},
  {"lng": "34.844390869140625", "lat": "32.16031265258789"},
  {"lng": "34.845970153808594", "lat": "32.1598014831543"},
  {"lng": "34.845970153808594", "lat": "32.1598014831543"},
  {"lng": "34.84764862060547", "lat": "32.15961456298828"},
  {"lng": "34.84764862060547", "lat": "32.15961456298828"},
  {"lng": "34.84906005859375", "lat": "32.160133361816406"},
  {"lng": "34.84906005859375", "lat": "32.160133361816406"},
  {"lng": "34.85022735595703", "lat": "32.16116714477539"},
  {"lng": "34.85022735595703", "lat": "32.16116714477539"},
  {"lng": "34.851837158203125", "lat": "32.16112518310547"},
  {"lng": "34.851837158203125", "lat": "32.16112518310547"},
  {"lng": "34.8528938293457", "lat": "32.16132736206055"},
  {"lng": "34.8528938293457", "lat": "32.16132736206055"},
  {"lng": "34.85309982299805", "lat": "32.16274642944336"},
  {"lng": "34.85309982299805", "lat": "32.16274642944336"},
  {"lng": "34.85303497314453", "lat": "32.164485931396484"},
  {"lng": "34.85303497314453", "lat": "32.164485931396484"},
  {"lng": "34.8531494140625", "lat": "32.16587829589844"},
  {"lng": "34.8531494140625", "lat": "32.16587829589844"},
  {"lng": "34.85300064086914", "lat": "32.167274475097656"},
  {"lng": "34.85300064086914", "lat": "32.167274475097656"},
  {"lng": "34.85298156738281", "lat": "32.16870880126953"},
  {"lng": "34.85298156738281", "lat": "32.16870880126953"},
  {"lng": "34.852962493896484", "lat": "32.17015075683594"},
  {"lng": "34.852962493896484", "lat": "32.17015075683594"},
  {"lng": "34.85243225097656", "lat": "32.17152404785156"},
  {"lng": "34.85243225097656", "lat": "32.17152404785156"},
  {"lng": "34.85202407836914", "lat": "32.172916412353516"},
  {"lng": "34.85202407836914", "lat": "32.172916412353516"},
  {"lng": "34.85179138183594", "lat": "32.174354553222656"},
  {"lng": "34.85179138183594", "lat": "32.174354553222656"},
  {"lng": "34.851585388183594", "lat": "32.175785064697266"},
  {"lng": "34.851585388183594", "lat": "32.175785064697266"},
  {"lng": "34.8518180847168", "lat": "32.17749786376953"},
  {"lng": "34.8518180847168", "lat": "32.17749786376953"},
  {"lng": "34.852264404296875", "lat": "32.17889404296875"},
  {"lng": "34.852264404296875", "lat": "32.17889404296875"},
  {"lng": "34.85264205932617", "lat": "32.18030548095703"},
  {"lng": "34.85264205932617", "lat": "32.18030548095703"},
  {"lng": "34.85298538208008", "lat": "32.181724548339844"},
  {"lng": "34.85298538208008", "lat": "32.181724548339844"},
  {"lng": "34.85340881347656", "lat": "32.18312072753906"},
  {"lng": "34.85340881347656", "lat": "32.18312072753906"},
  {"lng": "34.85386657714844", "lat": "32.184513092041016"},
  {"lng": "34.85386657714844", "lat": "32.184513092041016"},
  {"lng": "34.8542594909668", "lat": "32.18592071533203"},
  {"lng": "34.8542594909668", "lat": "32.18592071533203"},
  {"lng": "34.85459518432617", "lat": "32.18733215332031"},
  {"lng": "34.85459518432617", "lat": "32.18733215332031"},
  {"lng": "34.854915618896484", "lat": "32.18873977661133"},
  {"lng": "34.854915618896484", "lat": "32.18873977661133"},
  {"lng": "34.855228424072266", "lat": "32.190155029296875"},
  {"lng": "34.855228424072266", "lat": "32.190155029296875"},
  {"lng": "34.85560607910156", "lat": "32.191864013671875"},
  {"lng": "34.85560607910156", "lat": "32.191864013671875"},
  {"lng": "34.85652160644531", "lat": "32.192752838134766"},
  {"lng": "34.85652160644531", "lat": "32.192752838134766"},
  {"lng": "34.85853576660156", "lat": "32.19257354736328"},
  {"lng": "34.85853576660156", "lat": "32.19257354736328"},
  {"lng": "34.860225677490234", "lat": "32.192649841308594"},
  {"lng": "34.860225677490234", "lat": "32.192649841308594"},
  {"lng": "34.86192321777344", "lat": "32.192535400390625"},
  {"lng": "34.86192321777344", "lat": "32.192535400390625"},
  {"lng": "34.86395263671875", "lat": "32.19245529174805"},
  {"lng": "34.86395263671875", "lat": "32.19245529174805"},
  {"lng": "34.86565017700195", "lat": "32.192481994628906"},
  {"lng": "34.86565017700195", "lat": "32.192481994628906"},
  {"lng": "34.867347717285156", "lat": "32.192447662353516"},
  {"lng": "34.867347717285156", "lat": "32.192447662353516"},
  {"lng": "34.869049072265625", "lat": "32.19241714477539"},
  {"lng": "34.869049072265625", "lat": "32.19241714477539"},
  {"lng": "34.871089935302734", "lat": "32.1923828125"},
  {"lng": "34.871089935302734", "lat": "32.1923828125"},
  {"lng": "34.87278747558594", "lat": "32.19235610961914"},
  {"lng": "34.87278747558594", "lat": "32.19235610961914"},
  {"lng": "34.87469482421875", "lat": "32.19247817993164"},
  {"lng": "34.87469482421875", "lat": "32.19247817993164"},
  {"lng": "34.87489700317383", "lat": "32.193885803222656"},
  {"lng": "34.87489700317383", "lat": "32.193885803222656"},
  {"lng": "34.87534713745117", "lat": "32.19525146484375"},
  {"lng": "34.87534713745117", "lat": "32.19525146484375"},
  {"lng": "34.876426696777344", "lat": "32.1961669921875"},
  {"lng": "34.876426696777344", "lat": "32.1961669921875"},
  {"lng": "34.878440856933594", "lat": "32.19632339477539"},
  {"lng": "34.878440856933594", "lat": "32.19632339477539"},
  {"lng": "34.880130767822266", "lat": "32.196449279785156"},
  {"lng": "34.880130767822266", "lat": "32.196449279785156"},
  {"lng": "34.88057327270508", "lat": "32.197486877441406"},
  {"lng": "34.88057327270508", "lat": "32.197486877441406"},
  {"lng": "34.88056945800781", "lat": "32.197509765625"},
  {"lng": "34.88056945800781", "lat": "32.197509765625"},
  {"lng": "34.88056945800781", "lat": "32.197509765625"},
  {"lng": "34.88056945800781", "lat": "32.197509765625"},
  {"lng": "34.88056945800781", "lat": "32.197509765625"},
  {"lng": "34.88056945800781", "lat": "32.197509765625"},
  {"lng": "34.88056945800781", "lat": "32.197509765625"},
  {"lng": "34.88056945800781", "lat": "32.197509765625"},
  {"lng": "34.88056945800781", "lat": "32.197509765625"},
  {"lng": "34.88056945800781", "lat": "32.197509765625"},
  {"lng": "34.88056945800781", "lat": "32.197509765625"},
  {"lng": "34.88056945800781", "lat": "32.197509765625"},
  {"lng": "34.88056945800781", "lat": "32.197509765625"},
  {"lng": "34.88056945800781", "lat": "32.197509765625"},
  {"lng": "34.88056945800781", "lat": "32.197509765625"},
  {"lng": "34.88056945800781", "lat": "32.197509765625"},
  {"lng": "34.582603454589844", "lat": "31.69732093811035"},
  {"lng": "34.582603454589844", "lat": "31.6973209381103"}
];
