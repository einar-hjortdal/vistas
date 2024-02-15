# vistas

Central file server API, meant to be deployed behind a reverse proxy.

## Features

- Compatible with Linux, developed on EuroLinux 9
- Accepts BLOBs
- Stores BLOBs on file system
- Serves BLOBS (during development)
- Compresses BLOBs with gzip*

*toggle

<!--
### How I use it

Suppose an ecommerce website with domain `coachonko.com` exists.

- There exist many frontend servers
- Frontend servers communicate with many backend servers
- Backend servers communicate with the central file server

In this situation the central file server is given the domain `files.coachonko.com` and it:
- Creates and deletes files when the backend servers request it
- Serves files to the browsers

Apache httpd acts as reverse proxy:
- It receives requests and terminates TLS connections
- Routes requests to `files.coachonko.com/api`, coming from the backend servers, to the vistas API
- Handles requests to `files.coachonko.com`, coming from the browsers, by serving files managed by vistas.
-->