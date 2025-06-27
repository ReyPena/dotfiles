import { map, rule, writeToProfile } from 'karabiner.ts'

writeToProfile('Default', [
  rule('RestoreHomeButton').manipulators([
    map('home').to('left_arrow', 'left_command')
  ]),
  rule('RestoreEndButtonShift').manipulators([
    map('home', 'shift').to('left_arrow', ['left_command', 'left_shift'])
  ]),
  rule('RestoreEndButton').manipulators([
    map('end').to('right_arrow', 'left_command')
  ]),
  rule('RestoreEndButtonShift').manipulators([
    map('end', 'shift').to('right_arrow', ['left_command', 'left_shift'])
  ]),
])
