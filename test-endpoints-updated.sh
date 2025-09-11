#!/bin/bash

echo "Testing Swift Logistics API Endpoints..."
echo "---------------------------------------"

# Test WSO2 MI Login Endpoint
echo "Testing WSO2 MI Login Endpoint..."
curl -X POST http://localhost:8290/cms/login \
  -H "Content-Type: application/json" \
  -d '{
    "username": "driver1@swift.com",
    "password": "hashpass1"
  }'
echo -e "\n"

# Store the token from response for subsequent requests
TOKEN="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."

# Test Get Orders By Customer
echo "Testing Get Orders By Customer Endpoint..."
curl -X GET "http://localhost:8290/cms/getOrdersByCustomer" \
  -H "Authorization: Bearer $TOKEN"
echo -e "\n"

# Test Get Orders By Driver And Status
echo "Testing Get Orders By Driver And Status Endpoint..."
curl -X GET "http://localhost:8290/cms/getOrderByDriverAndStatus?driverId=2&status=pending" \
  -H "Authorization: Bearer $TOKEN"
echo -e "\n"

# Test Create New Order
echo "Testing Create New Order Endpoint..."
curl -X POST http://localhost:8290/cms/new-order \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $TOKEN" \
  -d '{
    "order": {
      "product": "touch",
      "quantity": 5,
      "address": "matara st 23",
      "route": 2,
      "coordinate": [2.1233, 1.2343]
    }
  }'
echo -e "\n"

# Test Get Driver Routes
echo "Testing Get Driver Routes Endpoint..."
curl -X GET "http://localhost:8290/ros/driver/routes/2" \
  -H "Authorization: Bearer $TOKEN"
echo -e "\n"

# Test Route Optimization
echo "Testing Route Optimization Endpoint..."
curl -X POST http://localhost:8290/ros/optimizeRoutes \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $TOKEN" \
  -d '{
    "response": {
      "status": "success",
      "orders": {
        "order": [
          {
            "order_id": 22,
            "client_id": 1,
            "route_id": 2,
            "product": "sports equipment",
            "quantity": 5,
            "status": "pending",
            "created_at": "2025-09-10T20:12:21.435007",
            "address": "Galle Face Green, Colombo",
            "coordinate": {
              "lat": 6.9271,
              "lng": 79.8425
            }
          }
        ]
      }
    }
  }'
echo -e "\n"

# Test Update Order Status
echo "Testing Update Order Status Endpoint..."
curl -X GET "http://localhost:8290/wms/updateOrderStatus/12/loaded" \
  -H "Authorization: Bearer $TOKEN"
echo -e "\n"

echo "Testing Complete!"
