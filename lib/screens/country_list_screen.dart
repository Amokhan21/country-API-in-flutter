import 'dart:convert';
import 'package:country_api/model/country.dart';
import 'package:country_api/screens/country_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;

class CountryListScreen extends StatefulWidget {
  const CountryListScreen({Key? key}) : super(key: key);

  @override
  _CountryListScreenState createState() => _CountryListScreenState();
}

class _CountryListScreenState extends State<CountryListScreen> {

//declare a function that will get all countries List from server

  Future<List<Country>> getAllCountries() async{

    //now declare a const url (variable) and paste the url of API in String
    //this is the url of the server that will provide us countries list
    const url = 'https://countriesnow.space/api/v0.1/countries/flag/images';

    //now to request server type http.get() this accepts uri so we will parse it to our url
    //store the response of the server in a variable response, await because of async
    var response = await http.get(Uri.parse(url));

    //now decode the response in json
    var jsonData = json.decode(response.body);

    //from json we only need the Data Array which provide each country
    var jsonArray = jsonData['data'];

    //now run a for loop on json Array to get name and flag of each country from json Data[]
    //also declare a empty list of country
    List<Country> countries =[];
    for(var jsonCountry in jsonArray){
      Country country = Country(name: jsonCountry['name'], flag: jsonCountry['flag']);
      countries.add(country);
    }

    //getAllCountries function will return countries
    return countries;

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Countries List"),
        centerTitle: true,
      ),
      //in body of scaffold write future builder of type list of country
      // future and builder are required in this
      //future will take getAllCountries function and builder will take context and snapshot
      body:  FutureBuilder<List<Country>>(
            future: getAllCountries(),
            builder: (context, snapshot) {

              //now if snapshot is empty return circular progress indicator else return the data in snapshot
              if( snapshot.data == null){
                return const Center( child: CircularProgressIndicator(),);
              }else{
                List<Country> countries =snapshot.data!;

               return ListView.builder(
                 itemCount: countries.length,
                 itemBuilder: (context, index){

                   Country country =countries[index];
                   return InkWell(
                     onTap: (){
                       Navigator.of(context).push(MaterialPageRoute(builder: (context){
                         return CountryDetailScreen(country: country,index: index,);
                       }));
                     },
                     child: Container(
                       padding: EdgeInsets.all(10),
                       margin: EdgeInsets.all(5),
                       decoration: BoxDecoration(
                         color: Colors.blue,
                         borderRadius: BorderRadius.circular(10),
                       ),
                       child: Row(
                         children: [
                           Text(index.toString()),
                           Container(
                               height: 80,
                               width: 60,
                               child: SvgPicture.network(country.flag, width: 100, height: 60,
                               placeholderBuilder: (context) {
                                 if(index==0)
                                   {
                                      return Image.asset('images/afghanistan_flag.png');
                                   }
                                 else if(index==7)
                                 {
                                   return Image.network('http://www.all-flags-world.com/country-flag/Argentina/flag-argentina-XL.jpg');
                                 }else{
                                   return Center(child: CircularProgressIndicator());
                                 }
                               },
                               )),
                           SizedBox(width: 20,),
                           Expanded(child: Text(country.name, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),))
                         ],
                       ),
                     ),
                   );

                 },
               );
              }

            },
          ),


    );
  }
}
