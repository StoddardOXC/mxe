# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := sdl_pnglite
$(PKG)_WEBSITE  := lxnt.wtf
$(PKG)_DESCR    := SDL_pnglite
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 0.23
$(PKG)_CHECKSUM := b83aeeb7217927a64c004e5394fca3c1ae799cb8d9027870347b491208e0c3ef
$(PKG)_SUBDIR   := .
$(PKG)_FILE     := SDL_pnglite.tar.gz
$(PKG)_URL      := https://lxnt.wtf/oxem/builds/deps/SDL_pnglite.tar.gz
$(PKG)_DEPS     := cc sdl2 zlib

define $(PKG)_UPDATE
    $(call GET_LATEST_VERSION, https://lxnt.wtf/oxem/builds/deps)
endef
# $(call GET_LATEST_VERSION, base url[, prefix, ext, filter, separator])
#  base url : required page returning list of versions
#               e.g https://ftp.gnu.org/gnu/libfoo
#  prefix   : segment before version
#               defaults to lastword of url with dash i.e. `libfoo-`
#  ext      : segment ending version - default `\.tar`
#  filter   : `grep -i` filter-out pattern - default alpha\|beta\|rc
#  separator: transform char to `.` - typically `_`

# test with make check-update-package-sdl_pnglite and delete comments

define $(PKG)_BUILD
    # build and install the library
    cd '$(BUILD_DIR)' && $(TARGET)-cmake -DBUILD_TEST_SUITE=OFF \
        '$(SOURCE_DIR)'
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install

    # create pkg-config file
    $(INSTALL) -d '$(PREFIX)/$(TARGET)/lib/pkgconfig'
    (echo 'Name: sdl_pnglite'; \
     echo 'Version: $($(PKG)_VERSION)'; \
     echo 'Description: $($(PKG)_DESCR)'; \
     echo 'Requires: sdl2'; \
     echo 'Libs: -lsdl_pnglite'; \
     echo 'Cflags.private:';) \
     > '$(PREFIX)/$(TARGET)/lib/pkgconfig/sdl_pnglite.pc'


endef
