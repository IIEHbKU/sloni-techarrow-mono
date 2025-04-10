import 'package:flutter/material.dart';

class TaskCardWidget extends StatelessWidget {
  const TaskCardWidget(
      {super.key, required this.child, this.onEditTapped, this.onTap});

  final Widget child;
  final VoidCallback? onEditTapped;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Material(
        elevation: 2,
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(child: child),
                if (onEditTapped != null)
                  IconButton(
                    onPressed: onEditTapped,
                    icon: Icon(Icons.edit_outlined, color: Colors.grey[600]),
                    tooltip: 'Edit',
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
