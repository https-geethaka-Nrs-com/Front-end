import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:snippet_coder_utils/FormHelper.dart';

class SearchNearestShed extends StatefulWidget {
  const SearchNearestShed({super.key});

  @override
  State<SearchNearestShed> createState() => _SearchNearestShedState();
}

class _SearchNearestShedState extends State<SearchNearestShed> {
  List<dynamic> provinces = [];
  List<dynamic> districtsMap = [];
  List<dynamic> districts = [];

  String? provinceID;
  String? districtID;
  String? districtId;

  @override
  void initState() {
    super.initState();

    this.provinces.add({"id": 1, "name": "North Central"});
    this.provinces.add({"id": 2, "name": "Northern"});
    this.provinces.add({"id": 3, "name": "Eastern"});
    this.provinces.add({"id": 4, "name": "Central"});
    this.provinces.add({"id": 5, "name": "North Western"});
    this.provinces.add({"id": 6, "name": "Southern"});
    this.provinces.add({"id": 7, "name": "Uva"});
    this.provinces.add({"id": 8, "name": "Sabaragamuwa"});
    this.provinces.add({"id": 9, "name": "Western"});

    this.districtsMap = [
      //North central
      {"ID": 1, "Name": "Anuradhapura", "ParentID": 1},
      {"ID": 2, "Name": "Polonnaruwa", "ParentID": 1},
      //Nothern
      {"ID": 1, "Name": "Jaffna", "ParentID": 2},
      {"ID": 2, "Name": "Mannar", "ParentID": 2},
      {"ID": 3, "Name": "Kilinochchi", "ParentID": 2},
      {"ID": 4, "Name": "Vavuniya", "ParentID": 2},
      {"ID": 5, "Name": "Mullativu", "ParentID": 2},
      {"ID": 6, "Name": "Alambil", "ParentID": 2},
      //Eastern
      {"ID": 1, "Name": "Ampara", "ParentID": 3},
      {"ID": 2, "Name": "Batticaloa", "ParentID": 3},
      {"ID": 3, "Name": "Trincomalee", "ParentID": 3},
      //Central
      {"ID": 1, "Name": "Kandy", "ParentID": 4},
      {"ID": 2, "Name": "Matale", "ParentID": 4},
      {"ID": 3, "Name": "NuwaraEliya", "ParentID": 4},
      //North western
      {"ID": 1, "Name": "Kurunegala", "ParentID": 5},
      {"ID": 2, "Name": "Puttalam", "ParentID": 5},
      //southern
      {"ID": 1, "Name": "Galle", "ParentID": 6},
      {"ID": 2, "Name": "Matara", "ParentID": 6},
      {"ID": 3, "Name": "Hambantota", "ParentID": 6},
      //Uva
      {"ID": 1, "Name": "Monaragala", "ParentID": 7},
      {"ID": 2, "Name": "Badulla", "ParentID": 7},
      //Sabaragamuwa
      {"ID": 1, "Name": "Kegalle", "ParentID": 8},
      {"ID": 2, "Name": "Rathnapura", "ParentID": 8},

      //Western
      {"ID": 1, "Name": "Colombo", "ParentID": 9},
      {"ID": 2, "Name": "Gampaha", "ParentID": 9},
      {"ID": 3, "Name": "Kaluthara", "ParentID": 9},
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FormHelper.dropDownWidgetWithLabel(
              context,
              "Select Province",
              "Select Province",
              this.provinceID,
              this.provinces,
              (onChangedVal) {
                this.provinceID = onChangedVal;
                print("Selected value Province $provinceID");

                this.districts = this
                    .districtsMap
                    .where(
                      (stateItem) =>
                          stateItem["ParentID"].toString() ==
                          onChangedVal.toString(),
                    )
                    .toList();
                this.districtId == null;

                setState(() {});
              },
              (onValidateVal) {
                if (onValidateVal == null) {
                  return "Please select Province";
                }
                return null;
              },
              borderColor: Theme.of(context).primaryColor,
              borderFocusColor: Theme.of(context).primaryColor,
              borderRadius: 10,
              optionValue: "id",
              optionLabel: "name",
            ),
            FormHelper.dropDownWidgetWithLabel(
              context,
              "Select District",
              "Select District",
              this.districtId,
              this.districts,
              (onChangedVal) {
                this.districtId = onChangedVal;
                print("Selected value District $districtId");

                this.districts = this
                    .districtsMap
                    .where(
                      (stateItem) =>
                          stateItem["ParentID"].toString() ==
                          onChangedVal.toString(),
                    )
                    .toList();
              },
              (onValidateVal) {
                return null;
              },
              borderColor: Theme.of(context).primaryColor,
              borderFocusColor: Theme.of(context).primaryColor,
              borderRadius: 10,
              optionValue: "ID",
              optionLabel: "Name",
            ),
          ],
        ),
      ),
    );
  }
}
