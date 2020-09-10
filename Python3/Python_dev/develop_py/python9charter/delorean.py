#!/usr/bin/python
# -*- coding: UTF-8 -*-
#!/usr/bin/env python

from datetime import datetime
import pytz

est = pytz.timezone('US/Eastern')
d = datetime.now(pytz.utc)
d = est.normalize(d.astimezone(est))
print d





