import sys


def get_feature_name(listing):
    # expects list of [x, feature/A102, y]

    for x in listing:
        if x.startswith("feature"):
            return x


def get_identification(from_feature_name):
    # expects identification to be after feature

    listing = from_feature_name.split("/")
    for i in range(len(listing)):
        if listing[i] == "feature" and i+1 < len(listing):
            return listing[i+1]


print(get_identification(get_feature_name(sys.argv)))
