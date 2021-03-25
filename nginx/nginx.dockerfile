FROM nginx:stable-alpine
COPY dist /usr/share/nginx/html
RUN rm /etc/nginx/conf.d/default.conf
COPY nginx.template /etc/nginx/conf.d
ENV BACKEND_URL http://127.0.0.1:8080
EXPOSE 80
WORKDIR /etc/nginx/conf.d
ENTRYPOINT envsubst '${BACKEND_URL}' < nginx.template > nginx.conf && cat nginx.conf && nginx -g 'daemon off;'

# docker build -f nginx.dockerfile ./ -t nginx:tag
# docker run --name nginx -d -p 8080:8080 -e BACKEND_URL=http://IP:port nginx:tag