# HTTP Docker build

Each of the two service types (API and Frontend) is fronted by an Nginx reverse proxy which passes requests back to the WSGI service.

The HTTP build base is split into two types:

* _headless_ - This is for the provision of services which have no frontend component (and therefore, more pointedly, no static files to serve)
* _frontend_ - Services which provide static files 
* _buildstatic_ - Node image used for build of assets
