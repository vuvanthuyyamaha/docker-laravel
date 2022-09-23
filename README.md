# PHP-FPM Docker Alpine Image

> 🐳 PHP-FPM-Alpine based Docker image for PHP framework with extensions for Redis, Memcached, MySQL, Events .v.v and custom default PHP configurations.

- [Docker Hub](https://hub.docker.com/r/vuvanthuyyamaha/php-fpm-alpine)


## ARG

- `ARG_TZ` : Build with timezone (default: `UTC`)
- `ARG_PHP_VERSION` : Build with PHP and PHP-FPM-Alpine version (default `8.1`)


## ENV

- `TZ` : Timezone
- `PHP_VERSION` : PHP version (Default setting in PHP-FPM Alpine Image)
- `DEBIAN_FRONTEND` : noninteractive
- `PHPIZE_DEPS` : dependencies required for running "phpize"
- `PHP_INI_DIR` : PHP custom settings folder


## Installed Packages

- openrc
- bash
- vim nano
- wget curl
- zip unzip
- tzdata
- git
- openssl
- mariadb-client mysql-client
- composer


## Installed PHP Extensions

### By Default PHP-FPM Alpine

- [ctype](https://www.php.net/manual/en/book.ctype.php) : Character type checking
- [curl](https://www.php.net/manual/en/book.curl.php) : Client URL Library
- [date](https://www.php.net/manual/en/refs.calendar.php) : Date and Time Related Extensions
- [dom](https://www.php.net/manual/en/book.dom.php) : Document Object Model
- [filter](https://www.php.net/manual/en/book.filter.php) : Data Filtering
- [fileinfo](https://www.php.net/manual/en/book.fileinfo.php) : File Information
- [ftp](https://www.php.net/manual/en/book.ftp.php) : File Transfer Protocol
- [hash](https://www.php.net/manual/en/book.hash.php) : HASH Message Digest Framework
- [iconv](https://www.php.net/manual/en/book.iconv.php) : iconv (internationalization conversion)
- [json](https://www.php.net/manual/en/book.json.php) : JavaScript Object Notation
- [mbstring](https://www.php.net/manual/en/book.mbstring.php) : Multibyte String
- [mysqlnd](https://www.php.net/manual/en/book.mysqlnd.php) : MySQL Native Driver
- [libxml](https://www.php.net/manual/en/book.libxml.php) : Lib XML
- [openssl](https://www.php.net/manual/en/book.openssl.php) : OpenSSL
- [pcre](https://www.php.net/manual/en/book.pcre.php) : Regular Expressions (Perl-Compatible)
- [pdo](https://www.php.net/manual/en/book.pdo.php) : PHP Data Objects
- [pdo_sqlite](https://www.php.net/manual/en/ref.pdo-sqlite.php) : SQLite Functions (PDO_SQLITE)
- [posix](https://www.php.net/manual/en/book.posix.php) : POSIX (Process Control Extensions)
- [sqlite3](https://www.php.net/manual/en/book.sqlite3.php) : SQLite3
- [readline](https://www.php.net/manual/en/book.readline.php) : GNU Readline
- [tokenizer](https://www.php.net/manual/en/book.tokenizer.php) : Tokenizer
- [session](https://www.php.net/manual/en/book.session.php) : Session Handling
- [sodium](https://www.php.net/manual/en/book.sodium.php) : Sodium (library for encryption, decryption, signatures, password hashing and more)
- [standard](https://www.php.net/manual/en/extensions.php) : PHP Standard extension
- [xml](https://www.php.net/manual/en/book.xml.php) : XML Parser
- [xmlreader](https://www.php.net/manual/en/book.xmlreader.php) : XMLReader
- [xmlwriter](https://www.php.net/manual/en/book.xmlwriter.php) : XMLWriter
- [zlib](https://www.php.net/manual/en/book.zlib.php) : Zlib Compression


### Expand More

- [bz2](https://www.php.net/manual/en/book.bzip2.php) : Bzip2 (read and write bzip2 (.bz2) compressed files). (require package: `libbz2`)
- [bcmath](https://www.php.net/manual/en/book.bc.php) : BCMath Arbitrary Precision Mathematics.
- [intl](https://www.php.net/manual/en/book.intl.php) : Internationalization Functions. (require package: `icu`)
- [zip](https://www.php.net/manual/en/book.zip.php) : ZIP (read or write ZIP compressed archives and the files inside them). (require package: `libzip`)
- [pcntl](https://www.php.net/manual/en/book.pcntl.php) : Process Control.
- [mcrypt](https://www.php.net/manual/en/book.mcrypt.php) : Mcrypt (algorithms such as DES, TripleDES, Blowfish (default) ... cipher modes). (require package: `libmcrypt`)
- [xsl](https://www.php.net/manual/en/book.xsl.php) : XSL (performing XSL » XSLT transformations). (require package: `libxslt`)
- [opcache](https://www.php.net/manual/en/book.opcache.php) : OPcache (improves PHP performance by storing precompiled script bytecode).
- [sockets](https://www.php.net/manual/en/book.sockets.php) : Sockets.
- [gd](https://www.php.net/manual/en/book.image.php) : Image Processing and GD. (require packages: `libgd gd zlib libpng libjpeg-turbo freetype libwebp libavif libxpm`)
- [exif](https://www.php.net/manual/en/book.exif.php) : Exchangeable image information.
- [imagick](https://www.php.net/manual/en/book.imagick.php) : Image Processing (ImageMagick). (require packages: `imagemagick libgomp`)
- [pgsql](https://www.php.net/manual/en/book.pgsql.php) : PostgreSQL. (require package: `libpq`)
- [pdo_pgsql](https://www.php.net/manual/en/ref.pdo-pgsql.php) : PostgreSQL Functions (PDO_PGSQL). (require extension: `pgsql`)
- [mysqli](https://www.php.net/manual/en/book.mysqli.php) : MySQL Improved Extension. (require extension: `mysqlnd`)
- [pdo_mysql](https://www.php.net/manual/en/ref.pdo-mysql.php) : MySQL Functions (PDO_MYSQL). (require extension: `mysqlnd`)
- [mongodb](https://www.php.net/manual/en/set.mongodb.php) : MongoDB driver
- [igbinary](https://www.php.net/manual/en/book.igbinary.php) : Igbinary (is a drop in replacement for the standard PHP serializer)
- [redis](https://www.php.net/manual/en/funcref.php) : Redis (PHP extension for interfacing with Redis). (require extension: `json igbinary`)
- [memcached](https://www.php.net/manual/en/book.memcached.php) : Memcached. (require extension: `json session igbinary` and packages: `libmemcached libmemcached-libs zlib libsasl gdbm`)
- [event](https://www.php.net/manual/en/book.event.php) : Event. (require extension: `openssl sockets` and packages: `libevent openssl`)


## Settings

- PHP log-folder: `/var/log/php-fpm/`
- PHP .ini path setting: `/usr/local/etc/php/` (php.ini / php.ini-development / php.ini-production)
- PHP custom settings folder: `/usr/local/etc/php/conf.d/` (00-php.ini / 01-date.ini / 02-session.ini / 03-opcache.ini)
- Session serialize handler: `igbinary` extension
