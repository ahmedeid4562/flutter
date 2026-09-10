import 'package:flutter/material.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  final Map<String, bool> categories = {
    "Eggs": true,
    "Noodles & Pasta": false,
    "Chips & Crisps": false,
    "Fast Food": false,
  };

  final Map<String, bool> brands = {
    "Individual Collection": false,
    "Cocola": true,
    "Ifad": false,
    "Kazi Farmas": false,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black, size: 24),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          "Filters",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.only(top: 10),
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Color(0xffF2F3F2),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    const Text(
                      "Categories",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ...categories.keys.map(
                      (key) => _buildCheckboxRow(
                        title: key,
                        value: categories[key]!,
                        onChanged: (val) =>
                            setState(() => categories[key] = val!),
                      ),
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      "Brand",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ...brands.keys.map(
                      (key) => _buildCheckboxRow(
                        title: key,
                        value: brands[key]!,
                        onChanged: (val) =>
                            setState(() => brands[key] = val!),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              color: const Color(0xffF2F3F2),
              padding: const EdgeInsets.all(20),
              child: SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context, {
                    "categories": categories,
                    "brands": brands,
                  }),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff53B175),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    "Apply Filter",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCheckboxRow({
    required String title,
    required bool value,
    required ValueChanged<bool?> onChanged,
  }) {
    return InkWell(
      onTap: () => onChanged(!value),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            SizedBox(
              width: 24,
              height: 24,
              child: Checkbox(
                value: value,
                onChanged: onChanged,
                activeColor: const Color(0xff53B175),
                checkColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                side: const BorderSide(
                  color: Color(0xffB1B1B1),
                  width: 1.5,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                color: value ? const Color(0xff53B175) : Colors.black,
                fontWeight: value ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}