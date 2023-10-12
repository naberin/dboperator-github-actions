import sys
import re
import sys



def clean(with_name):
    # used for database name
    return re.sub('[^a-z0-9_$#]', '', with_name)


def get_feature_name(listing):
    # expects list of [x, feature/A102, y]

    for x in listing:
        if x.startswith("feature"):
            return x


def get_identification(from_feature_name):
    # expects identification to be after feature

    listing = from_feature_name.split("/")
    for i in range(len(listing)):
        if listing[i].lower().startswith("feature") and i+1 < len(listing):
            return listing[i+1].lower()


# expects [command] [inputs]
command = sys.argv[1]

if command == "dbname":
    print(clean(sys.argv[2]))
elif command == "id"
    names = get_feature_name(sys.argv[2:])
    ident = get_identification(names)
    print(ident)
