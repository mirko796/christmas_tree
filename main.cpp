#include <QtGui/QApplication>
#include <QMessageBox>
#include "qmlapplicationviewer.h"

enum Mode
{
    mdUnknown=0,
    mdFullScreen,
    mdConfig,
    mdPreview
};
struct Params
{
    Mode mode;
    quint64 handle; //if mode is preview
};

void parseCommandLine(int argc, char *argv[],Params *params)
{
    params->handle=0;
#ifdef Q_OS_WIN
    params->mode=mdUnknown;
    if (argc>1)
    {
        QString param1=argv[1];
        if (param1=="/c")
        {
            params->mode=mdConfig;
        }
        else if (param1=="/s")
        {
            params->mode=mdFullScreen;
        }
        else if (param1=="/p")
        {
            if (argc>2)
            {
                QString param2=argv[2];
                params->handle=param2.toInt();
            }
            else
            {
                params->mode=mdUnknown;
            }
        }
    }
#else
    params->mode=mdFullScreen;
#endif
}

Q_DECL_EXPORT int main(int argc, char *argv[])
{
    QApplication::setGraphicsSystem("opengl");
    QScopedPointer<QApplication> app(createApplication(argc, argv));
    Params cmd;
    parseCommandLine(argc,argv,&cmd);
    int exitCode=0;
    switch(cmd.mode)
    {
        case mdFullScreen:
        {
            QPixmap nullCursor(16, 16);
            nullCursor.fill(Qt::transparent);
            app->setOverrideCursor(QCursor(nullCursor));
            QmlApplicationViewer viewer;
            viewer.setOrientation(QmlApplicationViewer::ScreenOrientationAuto);
            viewer.setSource(QUrl("qrc:/main.qml"));
            viewer.showFullScreen();
            exitCode=app->exec();
            break;
        }
        case mdConfig:
        {
            QString text="Our Christmass tree. Enjoy!:)"
                         "\n\nCompiled on "__DATE__"  "__TIME__
                         "\nAuthor: Mirko Rajkovaca";
            QMessageBox::information(NULL,"About",text);
        }
        default:
        {
            //do nothing
        }
    }


    return exitCode;
}
