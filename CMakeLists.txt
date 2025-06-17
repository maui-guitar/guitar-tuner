cmake_minimum_required(VERSION 3.16)

set(APP_VERSION 0.0.1)
add_compile_definitions(APP_COPYRIGHT_NOTICE="© 2015-2025 Maui Guitar Team")

project(MauiGuitar VERSION ${APP_VERSION} LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

set(QT_MAJOR_VERSION 6)

set(REQUIRED_KF_VERSION 5.240.0)
set(REQUIRED_QT_VERSION 6.5.2)

find_package(ECM ${REQUIRED_KF_VERSION} REQUIRED NO_MODULE)
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${ECM_MODULE_PATH})

find_package(Qt6 6.2 COMPONENTS Quick Qml Widgets REQUIRED)
find_package(KF6 ${REQUIRED_KF_VERSION} REQUIRED COMPONENTS I18n CoreAddons)
find_package(MauiKit4)

include(GNUInstallDirs)
include(ECMSourceVersionControl)
include(ECMSetupVersion)

ecm_setup_version(${APP_VERSION}
    VARIABLE_PREFIX GUITAR
    VERSION_HEADER "${CMAKE_CURRENT_BINARY_DIR}/guitar_version.h")

qt_policy(SET QTP0001 OLD)

if(${ECM_SOURCE_UNDER_VERSION_CONTROL})
    execute_process(
        COMMAND git rev-parse --abbrev-ref HEAD
        WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
        OUTPUT_VARIABLE GIT_BRANCH
        OUTPUT_STRIP_TRAILING_WHITESPACE)

    # Get the latest abbreviated commit hash of the working branch
    execute_process(
        COMMAND git log -1 --format=%h
        WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
        OUTPUT_VARIABLE GIT_COMMIT_HASH
        OUTPUT_STRIP_TRAILING_WHITESPACE)

    add_definitions(-DGIT_COMMIT_HASH="${GIT_COMMIT_HASH}")
    add_definitions(-DGIT_BRANCH="${GIT_BRANCH}")

else()
    add_definitions(-DGIT_COMMIT_HASH="${APP_VERSION}")
    add_definitions(-DGIT_BRANCH="Stable")
endif()

add_subdirectory(src)

install(TARGETS ${PROJECT_NAME}
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
