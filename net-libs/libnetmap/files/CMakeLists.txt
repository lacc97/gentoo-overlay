cmake_minimum_required(VERSION 3.25)
project(libnetmap
        DESCRIPTION "A framework for very fast packet I/O from userspace"
        LANGUAGES   C)

set(LIBNETMAP_SOURCE_DIR ${CMAKE_SOURCE_DIR}/libnetmap)

add_library(netmap "")
    target_include_directories(netmap
        PUBLIC
            $<BUILD_INTERFACE:${LIBNETMAP_SOURCE_DIR}>
            $<BUILD_INTERFACE:${CMAKE_SOURCE_DIR}/sys>)
    target_sources(netmap
        PUBLIC
            FILE_SET    HEADERS
                BASE_DIRS
                    ${LIBNETMAP_SOURCE_DIR}
                    ${CMAKE_SOURCE_DIR}/sys
                FILES
                    ${LIBNETMAP_SOURCE_DIR}/libnetmap.h
                    ${CMAKE_SOURCE_DIR}/sys/net/netmap_legacy.h
                    ${CMAKE_SOURCE_DIR}/sys/net/netmap_user.h
                    ${CMAKE_SOURCE_DIR}/sys/net/netmap_virt.h
                    ${CMAKE_SOURCE_DIR}/sys/net/netmap.h)
    target_sources(netmap
        PRIVATE
            ${LIBNETMAP_SOURCE_DIR}/nmctx.c
            ${LIBNETMAP_SOURCE_DIR}/nmctx-pthreads.c
            ${LIBNETMAP_SOURCE_DIR}/nmport.c
            ${LIBNETMAP_SOURCE_DIR}/nmreq.c)

install(TARGETS netmap
        ARCHIVE
        LIBRARY
        FILE_SET HEADERS)
