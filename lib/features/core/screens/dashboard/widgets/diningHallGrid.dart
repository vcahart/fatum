import 'package:flutter/material.dart';
import '/features/core/screens/dashboard/widgets/mealOptionsScreen.dart';

class DiningHallGrid extends StatelessWidget {
  final List<Map<String, String>> diningHalls;

  const DiningHallGrid({
    super.key,
    required this.diningHalls,
  });

  void navigateToMealOptions(BuildContext context, Map<String, String> diningHall) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MealOptionsScreen(hallName: diningHall['firebaseName']!), // Use firebaseName here
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        childAspectRatio: 1,
      ),
      itemCount: diningHalls.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final Map<String, String> diningHall = diningHalls[index];
        return InkWell(
          onTap: () => navigateToMealOptions(context, diningHall),
          child: Card(
            color: Color(0xFFF5F5F7),
            elevation: 10,
            shadowColor: Color.fromRGBO(0, 51, 102, 0.2),
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.topRight,
                  child: SizedBox(
                    width: 70,
                    height: 70,
                    child: Image.asset(
                      diningHall['image'] ?? '', // Provide a default or placeholder image path if 'image' is null
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  left: 8,
                  bottom: 8,
                  child: Text(
                    diningHall['displayName'] ?? 'Unknown', // Use 'displayName' and provide a fallback
                    style: TextStyle(
                      color: Color(0xFF003366),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
