import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class FoundationPage extends StatelessWidget {
  const FoundationPage({
    super.key,
    required this.title,
    required this.icon,
    required this.description,
    this.child,
  });
  final String title, description;
  final IconData icon;
  final Widget? child;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(title)),
    body: SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppTheme.pagePadding),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 640),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'KOTA MALANG',
                  style: TextStyle(
                    letterSpacing: 2,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 24),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(icon, size: 48, color: AppTheme.primary),
                        const SizedBox(height: 20),
                        Text(
                          title,
                          style: Theme.of(context).textTheme.headlineMedium
                              ?.copyWith(fontWeight: FontWeight.w800),
                        ),
                        const SizedBox(height: 12),
                        Text(description),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                const Chip(
                  avatar: Icon(Icons.science_outlined),
                  label: Text('Data Demo · Phase 0'),
                ),
                const SizedBox(height: 16),
                ?child,
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
