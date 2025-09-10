#!/usr/bin/env python3
"""
Simple HTTP server to serve the API documentation
Usage: python3 serve_docs.py [port]
Default port is 8080
"""

import http.server
import socketserver
import os
import sys
import webbrowser
from pathlib import Path

def main():
    # Get port from command line argument or use default
    port = int(sys.argv[1]) if len(sys.argv) > 1 else 8080
    
    # Change to the docs directory
    docs_dir = Path(__file__).parent
    os.chdir(docs_dir)
    
    # Create server
    handler = http.server.SimpleHTTPRequestHandler
    
    # Add CORS headers for local development
    class CORSHTTPRequestHandler(handler):
        def end_headers(self):
            self.send_header('Access-Control-Allow-Origin', '*')
            self.send_header('Access-Control-Allow-Methods', 'GET, POST, OPTIONS')
            self.send_header('Access-Control-Allow-Headers', 'Content-Type')
            super().end_headers()
    
    try:
        with socketserver.TCPServer(("", port), CORSHTTPRequestHandler) as httpd:
            print(f"✅ API Documentation server running at:")
            print(f"   🌐 http://localhost:{port}")
            print(f"   📁 Serving from: {docs_dir}")
            print(f"   📖 API Docs: http://localhost:{port}/index.html")
            print(f"   🔧 Raw YAML: http://localhost:{port}/api-specs.yml")
            print(f"\n🚀 Opening browser...")
            
            # Open browser automatically
            try:
                webbrowser.open(f"http://localhost:{port}/index.html")
            except Exception as e:
                print(f"⚠️  Could not open browser automatically: {e}")
            
            print(f"\n📋 Press Ctrl+C to stop the server")
            httpd.serve_forever()
            
    except KeyboardInterrupt:
        print(f"\n🛑 Server stopped")
    except OSError as e:
        if "Address already in use" in str(e):
            print(f"❌ Port {port} is already in use. Try a different port:")
            print(f"   python3 serve_docs.py {port + 1}")
        else:
            print(f"❌ Error starting server: {e}")

if __name__ == "__main__":
    main()
