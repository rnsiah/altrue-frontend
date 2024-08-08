import 'package:flutter/material.dart';
import 'package:lovelovelove/Data%20Layer/Models/company_model.dart';
import 'package:lovelovelove/Presentation%20Layer/Widgets/company/CompanyDetailTabs/company_detail_tabs.dart';


class CompanyDetailsContent extends StatefulWidget {
  final ForProfitCompany company;
  const CompanyDetailsContent({Key? key, required this.company})
      : super(key: key);

  @override
  State<CompanyDetailsContent> createState() => _CompanyDetailsContentState();
}

class _CompanyDetailsContentState extends State<CompanyDetailsContent> {
  List<Widget> _buildCompanyCauses() {
    if (widget.company.categories!.length < 2) {
      return widget.company.categories!.map((category) {
        return Padding(
          padding: const EdgeInsets.only(right: 8),
          child: GestureDetector(
            onTap: () {},
            child: Chip(
              label: Text(category.name!),
              backgroundColor: Colors.amber,
            ),
          ),
        );
      }).toList();
    } else {
      var categoryList = widget.company.categories!.take(2);
      return categoryList.map((category) {
        return Padding(
          padding: const EdgeInsets.only(right: 8),
          child: GestureDetector(
            onTap: () {},
            child: Chip(
              label: Text(category.name!),
              backgroundColor: Colors.amber,
            ),
          ),
        );
      }).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: ListView(scrollDirection: Axis.vertical, children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(
              height: 40,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 128.0),
              child: Image(
                image: AssetImage('images/Altrue Logo White.png'),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * .2),
                  child: Text(
                    widget.company.name,
                    style: const TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 15),
                  child: Text('Most Supported Causes',
                      style: TextStyle(color: Colors.white)),
                ),
                const SizedBox(height: 8),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: _buildCompanyCauses(),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Text('NonProfits\n Supported',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  )),
            ),
            const SizedBox(
              height: 5,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  for (final nonprofit in widget.company.nonprofits!)
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: GestureDetector(
                        onTap: () {},
                        child: ClipOval(
                          child: Image.network(
                            nonprofit.logo,
                            width: 45,
                            height: 45,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    )
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Text(
                'Company Info',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12.0, right: 30, top: 18),
              child: Text(widget.company.description!),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Text(
                'Company Mission',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Text(widget.company.mission!),
            ),
            ComapnyDetailTabs(company: widget.company)
          ],
        ),
      ]),
    );
  }
}
