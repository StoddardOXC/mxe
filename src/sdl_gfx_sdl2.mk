# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := sdl_gfx_sdl2
$(PKG)_WEBSITE  := https://github.com/StoddardOXC/SDL_gfx_SDL2
$(PKG)_DESCR    := SDL_gfx_SDL2
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 2.0.26
$(PKG)_CHECKSUM := 9d48647e463ec80d8b291311e3ead09caa6e6764b01e15a7510f7b04a4f62d63
$(PKG)_SUBDIR   := .
$(PKG)_FILE     := SDL_gfx-SDL2.tar.gz
$(PKG)_URL      := https://lxnt.wtf/oxem/builds/deps/SDL_gfx_SDL2.tar.gz
$(PKG)_DEPS     := cc sdl2

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
    (echo 'Name: SDL_gfx3'; \
     echo 'Version: $($(PKG)_VERSION)'; \
     echo 'Description: $($(PKG)_DESCR)'; \
     echo 'Requires: sdl2'; \
     echo 'Libs: -lSDL_gfx3'; \
     echo 'Cflags.private:';) \
     > '$(PREFIX)/$(TARGET)/lib/pkgconfig/SDL_gfx3.pc'


endef
