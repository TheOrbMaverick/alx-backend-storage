#!/usr/bin/env python3
"""Module to provide stats about Nginx logs stored in MongoDB"""

from pymongo import MongoClient


if __name__ == "__main__":
    """
    Provides statistics about Nginx logs stored in MongoDB.
    """
    client = MongoClient('mongodb://127.0.0.1:27017')
    collection = client.logs.nginx

    # Count total number of logs
    total_logs = collection.count_documents({})
    print(f"{total_logs} logs")

    # Count the number of logs for each HTTP method
    methods = ["GET", "POST", "PUT", "PATCH", "DELETE"]
    print("Methods:")
    for method in methods:
        count = collection.count_documents({"method": method})
        print(f"\tmethod {method}: {count}")

    # Count the number of GET requests with path /status
    status_check = collection.count_documents({
        "method": "GET", "path": "/status"
    })
    print(f"{status_check} status check")

    # Get the top 10 most present IPs
    top_ips = collection.aggregate([
        {"$group":
         {
             "_id": "$ip",
             "count": {"$sum": 1}
             }},
        {"$sort": {"count": -1}},
        {"$limit": 10},
        {"$project":
            {"ip": "$_id",
             "count": 1,
             "_id": 0}}
    ])

    # Print the top 10 IPs
    print("IPs:")
    for first_ip in top_ips:
        ip = first_ip.get("ip")
        count = first_ip.get("count")
        print(f"\t{ip}: {count}")
