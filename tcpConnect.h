#ifndef TCPCONNECT_H
#define TCPCONNECT_H

#include <QObject>
#include <QTcpSocket>

class TcpConnect : public QObject{
    Q_OBJECT
public:
    explicit TcpConnect(QObject *parent = nullptr);    //explicit构造函数是用来防止隐式转换的
    ~TcpConnect();

    /*被Q_INVOKABLE修饰的成员函数能够被元对象系统所唤起。*/
    Q_INVOKABLE bool connect(QString ip,quint16 port);
    Q_INVOKABLE bool sendMessage(QString sendStr);
    Q_INVOKABLE QString receiveMesage();

    Q_INVOKABLE int setTimeout(int timeout);
    Q_INVOKABLE int getTimeout();

    Q_INVOKABLE bool close();

signals:
     Q_INVOKABLE void hasRead();

public slots:
    Q_INVOKABLE void handleData();

private:
    QTcpSocket *tcpSocket;
    int timeout;   //超时时间
};



#endif // TCPCONNECT_H

