#include "tcpConnect.h"
#include "QDebug"

TcpConnect::TcpConnect(QObject *parent) : QObject(parent){
    tcpSocket = new QTcpSocket;
    timeout = 4000;
    QObject::connect(tcpSocket,SIGNAL(readyRead()),this,SIGNAL(hasRead()));
    //QObject::connect(this,SIGNAL(hasRead()),this,SLOT(handleData()));  测试用
}

int TcpConnect::setTimeout(int timeout){
    if(timeout < 0){
        return -101;     //-101代表 错误 超时时间为负数
    }else if(timeout < 400){
        return -1;       //-1代表警告  超时时间太短 在网络信号差的地方容易连接失败
    }else{
        return 0;        //0 表示正常
    }


}

int TcpConnect::getTimeout(){
    if(timeout < 0){
        return timeout;     //-101代表 错误 超时时间为负数
    }else if(timeout < 400){
        return timeout;       //-1代表警告  超时时间太短 在网络信号差的地方容易连接失败
    }else{
        return timeout;        //0 表示正常
    }

}

bool TcpConnect::connect(QString ip,quint16 port){
    tcpSocket->connectToHost(ip, port,QTcpSocket::ReadWrite);
    if (tcpSocket->waitForConnected(timeout))
          return true;    //表示连接成功
    else {
        return false;     //表示连接超时 失败
    }
}

bool TcpConnect::sendMessage(QString sendStr){
    //QString的toLatin1()方法返回QByteArray数组   data()根据QByteArray返回*char
    if(tcpSocket->write(sendStr.toLatin1().data(),strlen(sendStr.toLatin1().data()))){
        tcpSocket->flush();
        return true;   //发送成功
    }
    else {
        return false;    //发送失败
    }
}

bool TcpConnect::close(){
    tcpSocket->disconnectFromHost();

    if(tcpSocket->isOpen()){    //成功关闭就返回false
        return false;
    }else{
        return true;
    }

}



QString TcpConnect::receiveMesage(){
    return tcpSocket->readAll();
}

TcpConnect::~TcpConnect(){
    if(tcpSocket->isOpen())
    {
        tcpSocket->disconnectFromHost();
    }
    delete tcpSocket;
}



//仅仅用于测试的方法
void TcpConnect::handleData(){
    qDebug() << "vivi";
}

























