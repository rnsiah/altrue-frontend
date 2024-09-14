import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lovelovelove/Data%20Layer/Models/category_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/non_profit_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/user_model.dart';
import 'package:lovelovelove/Data%20Layer/Repositories/nonProfit_repository.dart';
import 'package:lovelovelove/Presentation%20Layer/Routers/functionality_router.dart';
import 'package:lovelovelove/Presentation%20Layer/Routers/router.dart';

class CauseDetails extends StatelessWidget {
  final Category cause;
  final Profile profile;

  final NonProfitRespository nonProfitRespository = NonProfitRespository();
  CauseDetails({Key? key, required this.cause, required this.profile})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.grey[900],
      appBar: AppBar(
        elevation: 10,
        backgroundColor: Colors.black,
        title: const Image(
          image: AssetImage('images/Altrue Logo White.png'),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 18.0, left: 6),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: 300,
                          width: 250,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.contain,
                                  image: NetworkImage(cause.image!))),
                        ),
                        Text(
                          cause.name!,
                          style: const TextStyle(
                            color: Colors.amber,
                            fontSize: 32,
                            fontWeight: FontWeight.w900,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        const Text(
                          'Altrue Cause',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w300),
                          textAlign: TextAlign.left,
                        )
                      ],
                    ),
                  ),

                  const Divider(
                    color: Colors.black38,
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'The Info',
                    style: TextStyle(color: Colors.amber),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RichText(
                        softWrap: true,
                        text: TextSpan(
                            text: cause.information,
                            style: const TextStyle(
                                fontSize: 17, color: Colors.black54))),
                  ),
//                  Text(causes.causeInformation ?? '', style: TextStyle(
//                    fontSize: 20, color: Colors.black45, fontWeight: FontWeight.w500
//                  ),
//                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Row(children: [
                    Text(
                      'NonProfits Supporting\n ${cause.name}',
                      maxLines: 2,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Text(
                        'Total NonProfits:${cause.nonprofitCount}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    )
                  ]),
                  SizedBox(
                    width: 600,
                    child: Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GridView.builder(
                          shrinkWrap: true,
                          itemCount: cause.nonprofitList!.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  mainAxisSpacing: 12,
                                  crossAxisSpacing: 27,
                                  childAspectRatio: .70,
                                  crossAxisCount: 3),
                          itemBuilder: (context, index) => GestureDetector(
                            onTap: () async {
                              NonProfit nonprofit =
                                  await nonProfitRespository.fetchNonProfit(
                                      cause.nonprofitList![index].id);
                              context.go('/allProjectsList/nonProfitView',
                                  extra: NonProfitDetailArguments(
                                      nonProfit: nonprofit, profile: profile));
                            },
                            child: Column(
                              children: [
                                Expanded(
                                  child: Image(
                                    image: NetworkImage(
                                        cause.nonprofitList![index].logo,
                                        scale: 0.7),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 2),
                                  child: Center(
                                    child: Text(
                                      cause.nonprofitList![index].name,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(

                      // child: ListView.builder(
                      //   itemCount: ,
                      //   itemBuilder: (context, index) {
                      //   return Card(child: Image.asset(null)
                      //
                      //   );
                      // },),
                      )
                ],
              ),
            ),
//            Positioned(
//              right: -60,
//              child: Container(
//                height: 300,
//                width: 250,
//                decoration: BoxDecoration(
//                    image:DecorationImage(fit: BoxFit.contain,
//                  image: AssetImage(causes.causeImage)
//                )),
//              ),
//            )
          ],
        ),
      ),
    );
  }
}
