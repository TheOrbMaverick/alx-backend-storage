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
    def wrapper(url: str) -> str:
        """
        Wrapper function to cache the result and track access
        """
        redis_client.incr(f"count:{url}")
        result_key = redis_client.get(f"result:{url}")

        # Check if the result is cached
        if result_key:
            return result_key.decode('utf-8')

        # Get result from the original method
        result = method(url)

        redis_client.set(f"count:{url}", 0)
        redis_client.setex(result_key, 10, result)
        return result
    return wrapper


@cache_result
def get_page(url: str) -> str:
    """Get the HTML content of a URL and cache it"""
    response = requests.get(url)
    return response.text
