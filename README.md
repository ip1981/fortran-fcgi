FastCGI program in Fortran
==========================

This is a template [FastCGI](https://en.wikipedia.org/wiki/FastCGI) program written in Fortran.
It uses [libfcgi](https://packages.debian.org/source/sid/libfcgi), so no magic here ;)

Interface to `libfcgi` is taken from the [Flibs collection](http://flibs.sourceforge.net/).


Building
========

`libfcgi` is required. Building is tested with [GNU Fortran](https://gcc.gnu.org/fortran/) only.


The build is based on [CMake](https://cmake.org/), but if you wish:

```sh
$ gfortran -I src/3rd/flibs/src/datastructures src/3rd/flibs/src/cgi/*.f90 src/main.f90 -lfcgi -o fortran-fcgi
```

Building with CMake:

```sh
$ mkdir build
$ cd build
$ cmake ..
$ make
```

