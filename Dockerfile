FROM postgres:9.5.6
RUN apt-get update
RUN apt-get install -y postgresql-server-dev-9.5 build-essential curl
WORKDIR /zhparser
ADD . /zhparser
RUN curl -Ls http://www.xunsearch.com/scws/down/scws-1.2.3.tar.bz2 | tar xjf -
RUN cd scws-1.2.3 && ./configure && make install
RUN make && make install
RUN tar -Pvzf /zhparser.tar.gz -c /usr/lib/postgresql/9.5/lib/zhparser.so \
/usr/share/postgresql/9.5/extension/zhparser.control \
/usr/share/postgresql/9.5/extension/zhparser--1.0.sql \
/usr/share/postgresql/9.5/extension/zhparser--unpackaged--1.0.sql \
/usr/share/postgresql/9.5/tsearch_data/dict.utf8.xdb \
/usr/share/postgresql/9.5/tsearch_data/rules.utf8.ini \
/usr/local/lib/libscws.la \
/usr/local/lib/libscws.so \
/usr/local/lib/libscws.so.1 \
/usr/local/lib/libscws.so.1.1.0
