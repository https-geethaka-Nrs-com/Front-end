import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class SelectVehicle extends StatefulWidget {
  static const routName = "/selectVehicle";
  const SelectVehicle({super.key});

  @override
  State<SelectVehicle> createState() => _SelectVehicleState();
}

class _SelectVehicleState extends State<SelectVehicle> {
  _SelectVehicleState() {
    _selectedVal = _vehicleType[0];
    _selectFuelType = _fuelType[0];
  }

  final _fuelType = [
    "Diesel",
    "Petrol",
  ];
  final _vehicleType = [
    "Bike",
    "3Wheel",
    "Quardricycle",
    "Car",
    "Van",
    "Bus",
    "Lorry",
    "Special purpose vehicle",
    "Land vehicles"
  ];

  String? _selectFuelType = "";
  String? _selectedVal = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DropdownButton(
                value: _selectFuelType,
                items: _fuelType
                    .map((e) => DropdownMenuItem(
                          child: Text(e),
                          value: e,
                        ))
                    .toList(),
                onChanged: (val) {
                  setState(() {
                    _selectFuelType = val as String;
                  });
                },
              ),
              DropdownButton(
                value: _selectedVal,
                items: _vehicleType
                    .map((e) => DropdownMenuItem(
                          child: Text(e),
                          value: e,
                        ))
                    .toList(),
                onChanged: (val) {
                  setState(() {
                    _selectedVal = val as String;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
