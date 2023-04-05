import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String md = '''
# Heading
Duis sunt id aliquip reprehenderit nostrud ad labore mollit ea fugiat Lorem excepteur duis officia. Deserunt laborum ea ullamco Lorem in deserunt dolore ad velit officia non esse ullamco ut. Veniam voluptate excepteur aliquip minim laborum consequat in culpa quis laboris commodo tempor. Quis velit fugiat dolor anim nulla dolore labore minim Lorem consequat. Nisi ad enim magna aliquip laboris minim sit dolore sint incididunt pariatur. Qui culpa pariatur dolore ut consectetur.

## Sub Heading
> Cupidatat in ullamco eu sunt aute aliquip laboris quis excepteur ea.

## Diet Plan
| Tables   |      Are      |  Cool |
|----------|:-------------:|------:|
| col 1 is |  left-aligned | \$1600 |
| col 2 is |    centered   |   \$12 |
| col 3 is | right-aligned |    \$1 |

''';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hello"),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: AspectRatio(
              aspectRatio: 1 / 1,
              child: Image.network(
                "https://images.unsplash.com/photo-1437622368342-7a3d73a34c8f?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1228&q=80",
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Markdown(
            data: md,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
          )
        ],
      ),
    );
  }
}
