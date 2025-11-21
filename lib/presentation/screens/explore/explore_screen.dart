import 'package:flutter/material.dart';



class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Analytics', style: Theme.of(context).textTheme.headlineLarge),
        actions: [
          IconButton(
            icon: const Icon(Icons.dark_mode_outlined),
            onPressed: () {},
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: Text(
                'JD', // Placeholder for user initials
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Chat Orders section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Chat Orders',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                DropdownButton<String>(
                  value: 'Weekly',
                  onChanged: (String? newValue) {},
                  items: <String>['Weekly', 'Monthly', 'Yearly']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '18K',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    Text(
                      'Total Sales',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '1,139',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    Text(
                      'Avg. Sales',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Container(
              height: 200, // Placeholder for chart
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: const Center(
                child: Text('Sales Chart Placeholder'),
              ),
            ),
            const SizedBox(height: 32.0),

            // Chat Orders List section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Chat Orders',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                DropdownButton<String>(
                  value: 'Today',
                  onChanged: (String? newValue) {},
                  items: <String>['Today', 'Yesterday', 'Last Week']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 3, // Placeholder for 3 chat orders
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.only(bottom: 8.0),
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                        index == 0
                            ? 'https://via.placeholder.com/150/FF5733/FFFFFF?text=SO'
                            : index == 1
                                ? 'https://via.placeholder.com/150/33FF57/FFFFFF?text=CP'
                                : 'https://via.placeholder.com/150/3357FF/FFFFFF?text=IC',
                      ),
                    ),
                    title: Text(
                      index == 0 ? 'Shopsticka Soya' : index == 1 ? 'Cheese Spinach' : 'Italian Chowmin',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    subtitle: Text(
                      index == 0 ? 'Sushi' : index == 1 ? 'Pizza' : 'Noodles',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          index == 0 ? '654' : index == 1 ? '258' : '82',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Text(
                          index == 0 ? 'Sales +14%' : index == 1 ? 'Sales +4%' : 'Sales +1%',
                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                color: Theme.of(context).colorScheme.onPrimaryContainer,
                              ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
