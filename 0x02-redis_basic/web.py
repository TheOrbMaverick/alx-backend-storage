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
    def wrapper(url: str):
        """
        Wrapper function to cache the result and track access
        """
        # Increment the access count for the given URL
        redis_client.incr(f"count:{url}")

        # Check if the result is already cached
        result_key = f"result:{url}"
        cached_result = redis_client.get(result_key)

        if cached_result:
            # Cache hit, return the cached value
            return cached_result.decode('utf-8')

        # Cache miss, fetch the result from the original method
        result = method(url)

        # Cache the result with a 10-second expiration time
        redis_client.setex(result_key, 10, result)

        return result

    return wrapper


@cache_result
def get_page(url: str) -> str:
    """Get the HTML content of a URL and cache it"""
    response = requests.get(url)
    return response.text


if __name__ == "__main__":
    url = "http://slowwly.robertomurray.co.uk/delay/1000/url/http://www.example.com"
    
    # First fetch, should store result in cache
    print(get_page(url))  # Cache miss, fetches the page
    
    # Second fetch within 10 seconds, should use the cached result
    print(get_page(url))  # Cache hit, returns cached content
