import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_web_study/core/util/browser_event.dart';
import 'package:flutter_web_study/core/util/logger.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DetailScreen extends HookConsumerWidget {
  final int detailId;
  static const route = 'detail';
  const DetailScreen({
    super.key,
    required this.detailId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ValueNotifier<bool> isTapped = useState(false);

    useEffect(
      () {
        logger.e(BrowserEvent.getCookieValue('detailId'));
        // BrowserEvent.setCookie(key: 'detailId', value: detailId.toString());
        BrowserEvent.setCookie(key: 'detailId', value: '2');
        // BrowserEvent.storeStringData('detailId', '2');

        return null;
      },
      [],
    );

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Detail Screen $detailId'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                isTapped.value = !isTapped.value;
              },
              child: Text('Toggle State'),
            ),
            SizedBox(height: 20),
            Text(isTapped.value ? 'Tapped' : 'Not Tapped'),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                context.pop();
              },
              child: Text('Back to Home Screen'),
            ),
          ],
        ),
      ),
    );
  }
}
