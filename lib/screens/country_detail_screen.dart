import 'package:country_api/model/country.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CountryDetailScreen extends StatelessWidget {
  final Country country;
final int index;
  const CountryDetailScreen({Key? key, required this.country,required this.index})
      : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Country Detail'),
        ),
        body: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              height: 300,
              child: SvgPicture.network(
                country.flag,
                width: double.infinity,
                fit: BoxFit.cover,
                placeholderBuilder: (context) {
                  if(index==0)
                  {
                    return Image.asset('images/afghanistan_flag.png',fit: BoxFit.cover,);
                  }
                  else if(index==7)
                  {
                    return Image.network('http://www.all-flags-world.com/country-flag/Argentina/flag-argentina-XL.jpg', fit: BoxFit.cover,);
                  }else{
                    return Center(child: CircularProgressIndicator());
                  }
                },

              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              country.name,
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ));
  }
}
