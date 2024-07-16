#!/usr/bin/env python3
"""Module to return all students sorted by average score and top 10 most present IPs"""


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
                "averageScore": {"$avg": "$scores.score"}
            }
        },
        {"$sort": {"averageScore": -1}}
    ]
    return list(mongo_collection.aggregate(pipeline))


def top_ips(logs_collection):
    """
    Returns the top 10 most present IPs in the logs collection.

    Args:
        logs_collection (Collection): The pymongo collection object.

    Returns:
        List[Dict]: A list of dictionaries representing the top 10 most present IPs.
    """
    pipeline = [
        {
            "$group": {
                "_id": "$ip",
                "count": {"$sum": 1}
            }
        },
        {"$sort": {"count": -1}},
        {"$limit": 10}
    ]
    return list(logs_collection.aggregate(pipeline))
