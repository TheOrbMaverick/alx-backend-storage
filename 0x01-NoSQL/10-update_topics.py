#!/usr/bin/env python3
"""
Python function that changes all topics
of a school document based on the name
"""


def update_topics(mongo_collection, name, topics):
    """
    Updates all topics of a school document based on the name.

    Args:
        mongo_collection (Collection): The pymongo collection object.
        name (str): The school name to update.
        topics (List[str]): The list of topics approached in the school.

    Returns:
        None
    """
    mongo_collection.update_many(
    { "name": name },
    { "$set": { "topics": topics } }
    )
