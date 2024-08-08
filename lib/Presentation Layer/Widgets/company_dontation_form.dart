import 'package:flutter/material.dart';

class CompanyDonationForm extends StatefulWidget {
  const CompanyDonationForm({super.key});

  @override
  State<CompanyDonationForm> createState() => _CompanyDonationFormState();
}

class _CompanyDonationFormState extends State<CompanyDonationForm> {
  bool showButtons =false;
  PageController conroller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Altrue'),backgroundColor: Colors.black,),
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child:
          
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.amber, width: 3)),
            height: MediaQuery.of(context).size.height * .6,
            width: MediaQuery.of(context).size.width * .9,
            child:PageView(
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              controller:conroller,
              children: [page1(controller: conroller,),
              page1(controller: conroller,),
              page1(controller: conroller,)],
            )
              
             )
          
        ),
      ),
    );
  }
}

class page1 extends StatelessWidget {
  final PageController controller;
  const page1({
    super.key,
    required this.controller
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16),
      border: Border.all(color: Colors.amber, width: 3)),
      height: MediaQuery.of(context).size.height * .6,
      width: MediaQuery.of(context).size.width * .9,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(child: Container(child: const Text('Specific Project',style: TextStyle(color: Colors.white, fontSize: 27,fontWeight: FontWeight.bold),),)),
          ),
          Row(children: [
            ElevatedButton(onPressed: (){
              controller.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
            }, child: const Text('Next Page'))
          ],)
        ],
      ),
    );
  }
}