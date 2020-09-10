  - textdd:
/root/test.sh:
  file.managed:
    - source: salt://scpfile/test.sh
    - mode: 755
/root/test.sh:
  file.append:
    - text:
      - "1111111111"
      - 'shixinwen1234'
/root/test.sh:
  file.sed:
    - before: 1111111111
    - after: 222222