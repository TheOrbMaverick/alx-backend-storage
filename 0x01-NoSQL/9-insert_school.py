#!/usr/bin/env python3
"""
Function that inserts a new
document in a collection based on kwargs
"""


def insert_school(mongo_collection, **kwargs):
    """
    Inserts a new document into a MongoDB collection.
    """

    return mongo_collection.insert(kwargs)
