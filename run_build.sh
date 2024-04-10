#!/bin/bash

# Navigate to the build directory
cd build/web

# Execute the build using npx and local-web-server
npx local-web-server --https --cors.embedder-policy "require-corp" --cors.opener-policy "same-origin" --directory "."