FROM gcc:6.2.0

RUN buildDeps='' \
 && imageDeps='mingw-w64' \
 && sudo apt-get update && apt-get install -y $buildDeps $imageDeps --no-install-recommends \
 && rm -r /var/lib/apt/lists/* \
 && curl -fSL 'https://github.com/boostorg/boost/archive/boost-1.62.0.tar.gz' -o /tmp/boost.tar.gz \
 && cd /tmp && tar xvf boost.tar.gz && cd boost \
 && cp tools/build/v2/user-config.jam $HOME \
 && echo "using gcc : 6.2 : i686-w64-mingw32-g++ ;" >> $HOME/user-config.jam \
 && ./bootstrap.sh mingw \
	  toolset=gcc-mingw \
	  target-os=windows \
	  address-model=32 \
	  link=shared,static \
	  threading=multi \
	  threadapi=win32 \
	  --prefix=/usr/i686-w64-mingw32 \
 && 	./b2 install \
	  toolset=gcc-mingw \
	  target-os=windows \
	  address-model=32 \
	  link=shared,static \
	  threading=multi \
	  threadapi=win32 \
	  --prefix=/usr/i686-w64-mingw32 \
	  --layout=system release \
 && rm -rf /tmp/*
