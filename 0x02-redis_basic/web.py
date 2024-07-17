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


def cache_result(expiration: int):
    """Decorator to cache the result of a function with an expiration time"""
    def decorator(method: Callable) -> Callable:
        @wraps(method)
        def wrapper(url: str, *args, **kwargs) -> str:
            """Wrapper function to cache the result and track access count"""
            cache_key = f"count:{url}"
            result_key = f"result:{url}"

            # Increment access count
            redis_client.incr(cache_key)

            # Check if result is already cached
            cached_result = redis_client.get(result_key)
            if cached_result:
                return cached_result.decode('utf-8')

            # Get result from the original method
            result = method(url, *args, **kwargs)
            redis_client.setex(result_key, expiration, result)
            return result
        return wrapper
    return decorator


@cache_result(expiration=10)
def get_page(url: str) -> str:
    """Get the HTML content of a URL and cache it"""
    response = requests.get(url)
    return response.text


if __name__ == "__main__":
    url = "http://slowwly.robertomurray.co.uk/delay/1000/url/http://www.example.com"
    print(get_page(url))
    print(get_page(url))
