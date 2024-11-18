import 'package:flutter/material.dart';

class RepoCardWidget extends StatefulWidget {
  final String projectName;
  final String projectDescription;
  final String codeLanguage;
  final String lastModified;
  const RepoCardWidget({
    super.key,
    required this.projectName,
    required this.projectDescription,
    required this.codeLanguage,
    required this.lastModified,
  });

  @override
  State<RepoCardWidget> createState() => _RepoCardWidgetState();
}

class _RepoCardWidgetState extends State<RepoCardWidget> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Card(
          margin: EdgeInsets.zero,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.only(
                left: 24.0, right: 12.0, top: 12.0, bottom: 24.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(widget.projectName,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w700)),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.arrow_forward_ios, size: 14)),
                    const Spacer(),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            isFavorite = !isFavorite;
                          });
                        },
                        icon: Icon(
                          isFavorite ? Icons.star : Icons.star_border_outlined,
                          color: isFavorite ? Colors.amber : Colors.grey,
                        )),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          widget.projectDescription,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.code,
                              size: 18,
                              color: Colors.grey,
                            ),
                            Text(
                              ' ${widget.codeLanguage}',
                              style: const TextStyle(color: Colors.grey),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 16.0),
                              child: Icon(
                                Icons.access_time,
                                size: 14,
                                color: Colors.grey,
                              ),
                            ),
                            Text(
                              ' ${widget.lastModified}',
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
