import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../Theme/app_theme.dart';
import '../../data/models/person_model.dart';

class PersonListTile extends StatelessWidget {
  final Person person;
  final VoidCallback onTap;

  const PersonListTile({super.key, required this.person, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'person-${person.id}',
      child: Material(
        color: Colors.transparent,
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListTile(
            contentPadding: const EdgeInsets.all(12),
            leading: CircleAvatar(
              radius: 28,
              backgroundColor: AppTheme.primaryColor.withOpacity(0.1),
              backgroundImage: CachedNetworkImageProvider(person.imageUrl),
            ),
            title: Text(
              person.fullName,
              style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                fontSize: 16,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(
                      Icons.email_outlined,
                      size: 14,
                      color: AppTheme.textSecondary,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        person.email,
                        overflow: TextOverflow.ellipsis,
                        style: AppTheme.lightTheme.textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      size: 14,
                      color: AppTheme.textSecondary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${person.city}, ${person.country}',
                      style: AppTheme.lightTheme.textTheme.bodyMedium,
                    ),
                  ],
                ),
              ],
            ),
            trailing: const Icon(
              Icons.chevron_right,
              color: AppTheme.textSecondary,
            ),
            onTap: onTap,
          ),
        ),
      ),
    );
  }
}
