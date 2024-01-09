import 'package:flutter/material.dart';

import '../service/api_service.dart';

class MyCheckbox extends StatefulWidget {
  final String label;
  final bool isSelected;
  final Function(bool) onToggle;

  const MyCheckbox({
    super.key,
    required this.label,
    required this.onToggle,
    required this.isSelected,
  });

  @override
  _MyCheckboxState createState() => _MyCheckboxState();
}

class _MyCheckboxState extends State<MyCheckbox> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          // Only toggle the state if it's not already selected
          if (!widget.isSelected) {
            widget.onToggle(true);

            // Unselect other options
            for (MyCheckbox otherCheckbox in _getOtherCheckboxes()) {
              otherCheckbox.onToggle(false);
            }
          }
        });
      },
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 2, right: 2),
            child: Stack(
              children: <Widget>[
                Container(
                  child: Stack(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: Card(
                          elevation: 0,
                          color: Colors.transparent,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: ListTile(
                                  title: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        child: widget.isSelected
                                            ? const Icon(
                                                Icons.check,
                                                size: 30.0,
                                                color: Colors.blue,
                                              )
                                            : null,
                                      ),
                                      Text(
                                        widget.label,
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper function to get a list of other checkboxes in the same parent widget
  List<MyCheckbox> _getOtherCheckboxes() {
    List<MyCheckbox> otherCheckboxes = [];

    if (mounted) {
      // Check if the current state is still mounted to avoid errors
      BuildContext? currentContext = context;
      currentContext.visitAncestorElements((element) {
        if (element is StatefulElement &&
            element.widget is MyCheckbox &&
            element != context) {
          otherCheckboxes.add(element.widget as MyCheckbox);
        }
        return true;
      });
    }

    return otherCheckboxes;
  }
}
