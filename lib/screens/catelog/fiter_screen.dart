import 'package:e_commerce_app/colors/color.dart';
import 'package:e_commerce_app/widget/container.dart';
import 'package:e_commerce_app/widget/para_text.dart';
import 'package:flutter/material.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  dynamic _currentRangeValues = const RangeValues(1, 80);
  Color selectedColor = Colors.white;
  String selectedSize = "m";
  void _setColor(Color color) {
    setState(() {
      selectedColor = color;
    });
    print('Selected color: $selectedColor');
  }

  void _setSize(String size) {
    setState(() {
      selectedSize = size;
    });
    print('Selected color: $selectedSize');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const ParaText(
          text: "Filter",
        ),
        backgroundColor: Colors.white,
      ),
      bottomSheet: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15))),
                onPressed: () {
                  // Do something when "Apply" is pressed
                },
                child: const Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: ParaText(
                    text: 'Discard',
                    size: 16,
                    fontweight: FontWeight.w500,
                  ),
                ),
              ),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                    backgroundColor: MyColors.btncolor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15))),
                onPressed: () {
                  // Do something when "Apply" is pressed
                },
                child: const Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: ParaText(
                    text: 'Apply',
                    color: Colors.white,
                    size: 16,
                    fontweight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            const SizedBox(
              height: 5,
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: ParaText(
                text: "Price Range",
                size: 16,
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            ShadowContainer(
              child: RangeSlider(
                activeColor: MyColors.btncolor,
                values: _currentRangeValues,
                max: 100,
                divisions: 5,
                labels: RangeLabels(
                  _currentRangeValues.start.round().toString(),
                  _currentRangeValues.end.round().toString(),
                ),
                onChanged: (RangeValues values) {
                  setState(() {
                    _currentRangeValues = values;
                  });
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: ParaText(
                text: "Colors",
                size: 16,
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            ShadowContainer(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildColorButton(Colors.red),
                    _buildColorButton(Colors.blue),
                    _buildColorButton(Colors.green),
                    _buildColorButton(Colors.yellow),
                    _buildColorButton(Colors.purple),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: ParaText(
                text: "Sizes",
                size: 16,
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            ShadowContainer(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildSizeButton("xs"),
                    _buildSizeButton("s"),
                    _buildSizeButton("m"),
                    _buildSizeButton("l"),
                    _buildSizeButton("xl"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildColorButton(Color color) {
    return GestureDetector(
      onTap: () => _setColor(color),
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          border: Border.all(
              color: selectedColor == color ? Colors.orange : Colors.white,
              width: 2),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Center(
          child: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSizeButton(String size) {
    return GestureDetector(
      onTap: () => _setSize(size),
      child: Container(
        alignment: Alignment.center,
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: selectedSize == size ? MyColors.btncolor : Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: ParaText(
          text: size,
          size: 16,
          fontweight: FontWeight.w400,
          color: selectedSize == size ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}
