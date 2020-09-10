import docutils.core
rest = '''===========Heading===========SubHading ----------- This is juest a simple little subsection. Now,we well show a bulleted list: - item one -item two -item three'''


html = docutils.core.publist_string(source=rest,writer_name='html')
print html[html.find(]
