qt_standard_project_setup(REQUIRES 6.8)

qt_add_resources(app_ASSETS
    assets/img_assets.qrc)

qt_add_executable(${PROJECT_NAME}
    main.cpp
    ${app_ASSETS})

qt_add_qml_module(${PROJECT_NAME}
    URI maui.app.guitar
    VERSION 1.0
    QML_FILES
    controls/Main.qml)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(${PROJECT_NAME} PROPERTIES
    #    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appuntitled3-guitar
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE)

target_link_libraries(${PROJECT_NAME}
    PRIVATE
    Qt6::Quick
    Qt6::Widgets
    Qt6::Qml
    KF6::I18n
    KF6::CoreAddons
    MauiKit4)
