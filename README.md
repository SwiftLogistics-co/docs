# API Documentation

This directory contains the interactive API documentation for the Swift Delivery Middleware project.

## Files

- `api-specs.yml` - OpenAPI 3.0 specification file containing all API endpoints
- `index.html` - Interactive Swagger UI web interface
- `serve_docs.py` - Python server to host the documentation locally
- `README.md` - This documentation

## Quick Start

### Option 1: Using Python Server (Recommended)

```bash
# Navigate to docs directory
cd docs

# Start the server (default port 8080)
python3 serve_docs.py

# Or specify a custom port
python3 serve_docs.py 3001
```

The server will automatically open your browser to view the documentation.

### Option 2: Using any HTTP Server

You can use any HTTP server to serve the documentation:

```bash
# Using Python's built-in server
cd docs
python3 -m http.server 8080

# Using Node.js http-server (if installed)
cd docs
npx http-server -p 8080

# Using PHP's built-in server
cd docs
php -S localhost:8080
```

Then open: `http://localhost:8080/index.html`

## API Endpoints Overview

### ESB Endpoints (External)
- `POST /login` - User authentication
- `GET /orders` - Retrieve orders with filtering
- `POST /orders` - Create new orders
- `PUT /orders/{orderId}/status` - Update order status
- `POST /driver/optimize-routes` - Optimize delivery routes for drivers

### Internal Microservice Endpoints
- **CMS**: Customer Management System (XML format)
- **WMS**: Warehouse Management System (TCP protocol)
- **ROS**: Route Optimization System (JSON format)

## Route Optimization Process

The `/driver/optimize-routes` endpoint follows this process:

1. **Frontend Request**: Sends driver_id and current_location
2. **ESB → CMS**: Calls `/cms/orders?driverId={id}` to get driver's orders with coordinates
3. **ESB → ROS**: Calls `/ros/optimize-routes` with driver location and orders
4. **Response**: Returns optimized route to frontend

## Features

- 🌐 **Interactive Documentation**: Test APIs directly from the browser
- 📱 **Responsive Design**: Works on desktop and mobile
- 🔍 **Search & Filter**: Find endpoints quickly
- 📋 **Copy Examples**: Easy to copy request/response examples
- 🎨 **Professional UI**: Clean, modern Swagger UI interface

## Development

To modify the API specifications:

1. Edit `api-specs.yml`
2. Refresh your browser to see changes
3. The Swagger UI will automatically reload the updated specs

## Deployment

For production deployment:

1. Copy the entire `/docs` directory to your web server
2. Ensure the web server can serve static files
3. Point your domain to `index.html`

## Troubleshooting

**Port already in use?**
```bash
python3 serve_docs.py 8081
```

**Browser not opening automatically?**
Manually navigate to: `http://localhost:8080/index.html`

**CORS issues?**
The Python server includes CORS headers. If using another server, ensure CORS is enabled.
