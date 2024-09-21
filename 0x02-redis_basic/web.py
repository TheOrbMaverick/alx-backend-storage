#!/usr/bin/env python3
"""
Web module with get_page function, includes caching and access count in Redis
"""
import requests
import redis
from typing import Callable
from functools import wraps
import time  # Added to test cache expiration manually

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
                print(f"Cache hit for {url}")  # Added to indicate when cache is used
                return cached_result.decode('utf-8')

            # Get result from the original method
            print(f"Cache miss for {url}, fetching content")  # Added to indicate cache miss
            result = method(url, *args, **kwargs)
            redis_client.setex(result_key, expiration, result)  # Cache result for `expiration` seconds
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

    # First fetch, should store result in cache
    print(get_page(url))  # Cache miss, fetches the page

    # Second fetch, should use the cached result
    print(get_page(url))  # Cache hit, returns cached content

    # Sleep for 11 seconds to test cache expiration (since the cache is set to expire in 10 seconds)
    print("Waiting for cache to expire...")
    time.sleep(11)

    # Fetch again, cache should have expired, and it should re-fetch the page
    print(get_page(url))  # Cache miss, fetches the page again
    print(redis_client.get(f"count:{url}"))
