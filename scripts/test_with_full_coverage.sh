# ./scripts/test_with_full_coverage.sh 'flex_workout_mobile'

file=test/coverage_helper_test.dart

rm $file

echo "// Helper file to make coverage work for all files\n" >> $file
echo "// ignore_for_file: unused_import, directives_ordering" >> $file

find lib '!' -path '*theme*/*' '!' -path '*ui*/*' '!' -name '*.g.dart' '!' -name '*.freezed.dart' '!' -name '*.mapper.dart' '!' -name '*.gform.dart' -name '*.dart' | cut -c4- | awk -v package=$1 '{printf "import '\''package:%s%s'\'';\n", package, $1}' >> $file

echo "void main() {}" >> $file

very_good test -j 4 --coverage --test-randomize-ordering-seed random
lcov --remove coverage/lcov.info 'lib/core/theme/*' 'lib/db/*' 'lib/*/ui/*' 'lib/*/*.freezed.dart' 'lib/*/*.g.dart' 'lib/*/*.gform.dart' 'lib/*/*.mapper.dart'  -o coverage/lcov.info 
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html
