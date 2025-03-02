#!/usr/bin/env bash
#
# Simple smoke tests to confirm our containers are working.
#

# Exit immediately if a command exits with a non-zero status.
set -e

# 1) Check the root URL to ensure we get HTML (the React app).
#    We expect a 200 OK and some snippet like "<title>" or "React" in the body.
echo "Checking React frontend at root URL..."
HTTP_ROOT=$(curl -i -s -L -k http://localhost/)

echo "$HTTP_ROOT" | grep -q "200 OK"
echo "$HTTP_ROOT" | grep -qi "<html"

echo "✅ Root URL returned 200 and HTML"

# 2) Check the API /api/books endpoint for a 200 and valid JSON array or object
echo "Checking backend API: GET /api/books..."
HTTP_API=$(curl -i -s -L -k http://localhost/api/books)
echo "$HTTP_API" | grep -q "200 OK"

# Optional: if your API returns JSON, we can do a quick check that it starts with '[' or '{'.
JSON_BODY=$(echo "$HTTP_API" | awk '/^\[|^\{/{flag=1} flag{print}' )
if [[ "$JSON_BODY" =~ ^(\[|\{) ]]; then
  echo "✅ /api/books endpoint returned 200 and valid JSON"
else
  echo "❌ /api/books returned 200 but did not contain JSON"
  exit 1
fi

echo "All smoke tests passed successfully!"