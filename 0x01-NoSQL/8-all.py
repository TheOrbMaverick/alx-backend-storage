#!/usr/bin/env python3
"""Module to list all documents in a MongoDB collection"""


def list_all(mongo_collection):
    """
    Lists all documents in a MongoDB collection.

    Args:
        mongo_collection (Collection): The pymongo collection object.

    Returns:
        List[dict]: A list of dictionaries representing the documents in the collection.
                    Returns an empty list if no documents are found.
    """
    if mongo_collection.find().count() == 0:
        return []

    return list(mongo_collection.find())
