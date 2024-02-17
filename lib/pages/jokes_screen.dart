import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

const apiUrl =
    "https://v3.jokeapi.dev/joke/Programming?type=twopart&blacklistFlags=nsfw,religious,political,racist,sexist,explicit";

typedef Joke = ({String setup, String delivery});

class JokeController extends StateNotifier<AsyncValue<Joke?>> {
  JokeController() : super(const AsyncData(null));

  Future<void> getJoke() async {
    state = const AsyncLoading<Joke?>();

    try {
      final response = await http.get(Uri.parse(apiUrl));
      final data = jsonDecode(response.body);

      if (data['error'] == true) {
        state = AsyncError("Error", StackTrace.current);
        return;
      }
      final Joke joke = (setup: data['setup'], delivery: data['delivery']);
      state = AsyncData(joke);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}

final jokeControllerProvider =
    StateNotifierProvider<JokeController, AsyncValue<Joke?>>((ref) {
  return JokeController();
});

class JokesScreen extends ConsumerWidget {
  const JokesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(jokeControllerProvider);
    final joke = state.value;

    return Scaffold(
        appBar: AppBar(
          title: const Text('Jokes'),
        ),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('Get a joke'),
            IconButton(
              onPressed: () {
                ref.read(jokeControllerProvider.notifier).getJoke();
              },
              icon: const Icon(Icons.refresh),
            ),
            if (state.isLoading)
              const Center(
                child: CircularProgressIndicator(),
              ),
            if (state.hasError)
              Center(
                child: Text(
                  state.error.toString(),
                ),
              ),
            if (state.value == null) const Text('no joke'),
            if (state.value != null)
              Text(
                "${joke!.setup}\n\n${joke.delivery}",
                textAlign: TextAlign.center,
              ),
          ],
        ));
  }
}
