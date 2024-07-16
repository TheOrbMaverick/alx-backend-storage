#!/usr/bin/env python3
"""
Function that inserts a new
document in a collection based on kwargs
"""


def insert_school(mongo_collection, **kwargs):
    """
    Inserts a new document into a MongoDB collection.

    Args:
        mongo_collection (Collection): The pymongo collection object.
        **kwargs: Arbitrary keyword arguments representing the document fields.

    Returns:
        Any: The _id of the newly inserted document.
    """

    result = mongo_collection.insert(kwargs)
    return result._id
