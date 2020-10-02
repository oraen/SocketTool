#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <tcpConnect.h>

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);//

    QGuiApplication app(argc, argv);//

    //把tcpConnect类注册到QML环境中 参数分别为import将要导入的名称，主、次版本号，QML中所能使用的对象名称为双引号中的TcpSocket
    qmlRegisterType<TcpConnect>("oraen.myTcpConnect",1,0,"TcpSocket");

    QQmlApplicationEngine engine;//rr

    /**安全地加载*/
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,&app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl){
            QCoreApplication::exit(-1);
        }

    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();

}
