// Copyright (c) 2022, Tomás Sasovsky
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:fuzzysearch/fuzzysearch.dart';
import 'package:human_duration_parser/human_duration_parser.dart';
import 'package:nyxx_commands/nyxx_commands.dart';
import 'package:nyxx_interactions/nyxx_interactions.dart';

final durationConverter = Converter<Duration>(
  (view, context) {
    final duration = parseStringToDuration(view.getQuotedWord());

    // [parseStringToDuration] returns Duration.zero on parsing failure
    if (duration.inMilliseconds > 0) {
      return duration;
    }

    return null;
  },
  autocompleteCallback: autocompleteDuration,
);

Future<Iterable<ArgChoiceBuilder>> autocompleteDuration(
  AutocompleteContext context,
) async {
  final clustersSoFar = context.currentValue.split(RegExp(r'((?<=\s)(?=\d))'));
  final options = ['seconds', 'minutes', 'hours', 'days', 'months', 'years'];

  Future<Iterable<String>> correct(
    String current,
    Iterable<String> nextParts,
  ) async {
    final trimmedCurrent = current.trim();
    final currentSplit =
        trimmedCurrent.split(RegExp(r'\s+|(?<=\d)(?=\w)|(?<=\w)(?=\d)'));
    final corrected = <String>[];

    if (trimmedCurrent.isEmpty) {
      // Populate the choices with examples.
      corrected.addAll(options.map((suffix) => '1 $suffix'));
    } else if (currentSplit.length >= 2) {
      // Try to fix the current input. If it is already valid,
      // this code does nothing.
      final numbers =
          currentSplit.takeWhile((value) => RegExp(r'\d+').hasMatch(value));
      final rest = currentSplit.skip(numbers.length).join();

      var number = numbers.join();
      if (number.isEmpty) {
        number = '0';
      }

      final searchResult = await Fuzzy(options).search(rest);
      final resolvedRest =
          searchResult.map((result) => result.item).followedBy([rest]).first;

      corrected.add('$number $resolvedRest');
    } else if (RegExp(r'\d$').hasMatch(trimmedCurrent)) {
      corrected.addAll(options.map((suffix) => '$trimmedCurrent $suffix'));
    }

    if (nextParts.isEmpty) {
      return corrected;
    }

    final correctedResult = await correct(nextParts.first, nextParts.skip(1));

    return corrected
        // Expand each corrected part with all possible corrections
        // to the following parts
        .expand(
      (correctedStart) => correctedResult.map(
        (correctedEnd) => '$correctedStart $correctedEnd'.trim(),
      ),
    );
  }

  final correctedResult =
      await correct(clustersSoFar.first, clustersSoFar.skip(1));
  final result = correctedResult.take(25).map((e) => ArgChoiceBuilder(e, e));

  if (result.isNotEmpty) {
    return result;
  }

  return [ArgChoiceBuilder(context.currentValue, context.currentValue)];
}
