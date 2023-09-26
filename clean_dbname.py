import re
import sys


def clean(with_name):
    # used for database name
    return re.sub('[^a-z0-9_$#]', '', with_name)


name = clean(sys.argv[1])
print(name)
