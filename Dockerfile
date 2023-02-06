FROM alpine:3.13.1

RUN apk --quiet add --upgrade git apache2

WORKDIR /var/www/localhost/htdocs

COPY htdocs /var/www/localhost/htdocs

RUN git clone https://github.com/LenticularLens/LenticularLens.github.io.git docs

RUN sed -i -e 's|#LoadModule rewrite_module modules/mod_rewrite.so|LoadModule rewrite_module modules/mod_rewrite.so|' /etc/apache2/httpd.conf

COPY conf/rewrite.conf /etc/apache2/conf.d/

CMD /usr/sbin/httpd -D FOREGROUND &> /tmp/httpd.log; tail -f /dev/null

EXPOSE 80
