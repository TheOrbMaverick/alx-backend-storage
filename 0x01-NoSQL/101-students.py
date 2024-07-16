#!/usr/bin/env python3
"""Module to return all students sorted by average score"""


def top_students(mongo_collection):
    """
    Returns all students sorted by average score.

    Args:
        mongo_collection (Collection): The pymongo collection object.

    Returns:
        List[Dict]: A list of dictionaries representing the students sorted by average score.
    """
    pipeline = [
        {
            "$project": {
                "name": 1,
                "averageScore": { "$avg": "$scores.score" }
            }
        },
        { "$sort": { "averageScore": -1 } }
    ]
    return list(mongo_collection.aggregate(pipeline))
