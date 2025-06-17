#include <QQmlApplicationEngine>

#include <QCommandLineParser>
#include <QFileInfo>
#include <QIcon>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#ifdef Q_OS_ANDROID
#include <QGuiApplication>
#else
#include <QApplication>
#endif
#include <QIcon>

#include <KLocalizedString>
#include <KAboutData>

#include <MauiKit4/Core/mauiapp.h>

#include "../guitar_version.h"


int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    app.setOrganizationName(QStringLiteral("Maui"));
    app.setWindowIcon(QIcon(":/img/MauiGuitar.svg"));
    KLocalizedString::setApplicationDomain("mauiguitar");

    KAboutData about(QStringLiteral("guitar"),
                     QStringLiteral("Guitar"),
                     GUITAR_VERSION_STRING,
                     i18n("Guitar tuner."),
                     KAboutLicense::LGPL_V3,
                     APP_COPYRIGHT_NOTICE,
                     QString(GIT_BRANCH) + "/" + QString(GIT_COMMIT_HASH));

    about.addAuthor(QStringLiteral("Donald Menig"), i18n("Developer"), QStringLiteral("milo.h@aol.com"));
    about.addAuthor(QStringLiteral("Luiz Carlos"), i18n("Developer"), QStringLiteral("milo.h@aol.com"));
    about.addAuthor(QStringLiteral("Camilo Higuita"), i18n("Developer"), QStringLiteral("milo.h@aol.com"));

    about.setHomepage("https://github.com/maui-guitar/guitar-tuner");
    about.setProductName("maui/guitar");
    about.setBugAddress("https://github.com/maui-guitar/guitar-tuner/issues");
    // about.setOrganizationDomain(BUHO_URI);
    about.setProgramLogo(app.windowIcon());

    KAboutData::setApplicationData(about);

    MauiApp::instance()->setIconName("qrc:/img/MauiGuitar.svg");
    QQmlApplicationEngine engine;
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);

    engine.rootContext()->setContextObject(new KLocalizedContext(&engine));

    engine.loadFromModule("maui.app.guitar.controls", "Main");

    return app.exec();
}
