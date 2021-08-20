#!/usr/bin/env python

import sys

begin_keyword1 = '---BEGIN'
begin_keyword2 = '--- BEGIN'
end_keyword1 = '---END'
end_keyword2 = '--- END'

with open(sys.argv[1], 'r') as my_file:
    count = 0
    current_key = ''

    parsing_key_mode = 0
    for line in my_file.readlines():
        if parsing_key_mode == 1 or (begin_keyword1 in line) or (begin_keyword2 in line):
            parsing_key_mode = 1
            current_key += line

        if (end_keyword1 in line) or (end_keyword2 in line):
            parsing_key_mode = 0
            with open(sys.argv[2] + '/' + 'key_' + str(count), 'w') as f:
                f.write(current_key)
                count += 1
                current_key = ''