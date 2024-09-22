#!/usr/bin/env python3
"""
Web module with get_page function
"""
import requests
import redis
from typing import Callable
from functools import wraps

# Initialize Redis client
redis_client = redis.Redis()


def cache_result(method: Callable) -> Callable:
    """Decorator to cache the result of a function"""
    @wraps(method)
    def wrapper(url):
        """
        Wrapper function to cache the result and track access
        """
        # Increment the count for the URL
        redis_client.incr(f"count:{url}")

        # Check if the result is already cached
        result_key = redis_client.get(f"result:{url}")

        if result_key:
            return result_key.decode('utf-8')

        # Get result from the original method if not cached
        result = method(url)

        # Cache the result for 10 seconds
        redis_client.setex(f"result:{url}", 11, result)

        return result

    return wrapper


@cache_result
def get_page(url: str) -> str:
    """Get the HTML content of a URL and cache it"""
    response = requests.get(url)
    return response.text
