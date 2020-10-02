import QtQuick 2.0

Rectangle {


    function clearSlect() {
        imageTcpServer.source = "qrc:images/tcpServer.png";
        imageTcpClient.source = "qrc:images/tcpClient.png";
        imageUdpServer.source = "qrc:images/udpServer.png";
        imageUdpClient.source = "qrc:images/udpClient.png";
    }

    /********************************************************************************TCP服务器****************************************/
    Rectangle {
        id: tcpServer;
        width: parent.width;
        height: parent.height /4;
        border.width: 0;

        anchors.left: parent.left;

        Image {
            id: imageTcpServer;
            width: parent.width;
            height: parent.height;
            source:"qrc:images/tcpServer.png";
        }

        MouseArea{
            hoverEnabled: true;   //不用点着鼠标 就能触发 移入移出鼠标区的事件
            anchors.fill: parent  //事件响应区充满整个矩形
            propagateComposedEvents:true;  //使鼠标事件可以继续传递到子组件 防止输入文本框失效

            onDoubleClicked: {  //注意 双击时候会同时触发单机事件
                newConnDia.visible = true;
            }

            onClicked: {
                newConnDia.current = 0;
                optionsPage.clearSlect();
                imageTcpServer.source = "qrc:images/tcpServer_j.png";

            }

            onExited: {
               // tcpServer.width -= 9;  Qt.binding(function)  tcpServer.parent.width
                tcpServer.width = Qt.binding(Qt.binding(function(){return tcpServer.parent.width}));  //动态绑定
                tcpServer.height =  Qt.binding(function(){return tcpServer.parent.height/4})  ;

            }

            onEntered: {
                tip.text = "ctrl + Q "
                tcpServer.width = tcpServer.width + 9;
                tcpServer.height += 9;
            }

        }



    }

/********************************************************************************TCP客户端****************************************/
    Rectangle {
        id: tcpClient;
        width: parent.width;
        height: parent.height /4;
        border.width: 0;

        anchors.left: parent.left;
        anchors.top: tcpServer.bottom;

        Image {
            id: imageTcpClient;
            width: parent.width;
            height: parent.height;
            source: "qrc:images/tcpClient.png"
        }

        MouseArea{
            hoverEnabled: true;   //不用点着鼠标 就能触发 移入移出鼠标区的事件
            anchors.fill: parent  //事件响应区充满整个矩形
            propagateComposedEvents:true;  //使鼠标事件可以继续传递到子组件 防止输入文本框失效

            onDoubleClicked: {  //注意 双击时候会同时触发单机事件
                newConnDia.visible = true;
            }

            onClicked: {
                newConnDia.current = 1;
                optionsPage.clearSlect();
                imageTcpClient.source = "qrc:images/tcpClient_j.png";
            }

            onExited: {
                tcpClient.width = Qt.binding(Qt.binding(function(){return tcpServer.parent.width}));  //动态绑定
                tcpClient.height =  Qt.binding(function(){return tcpServer.parent.height/4})  ;
            }

            onEntered: {
                tip.text = "ctrl + W "
                tcpClient.width += 9;
                tcpClient.height += 9;

            }

        }
    }

/********************************************************************************UDP服务器****************************************/
    Rectangle {
        id: udpServer;
        width: parent.width;
        height: parent.height /4;
        color: "#3ebcca";
        border.width: 1;

        anchors.left: parent.left;
        anchors.top: tcpClient.bottom;

        Image {
            id: imageUdpServer;
            width: parent.width;
            height: parent.height;
            source:"qrc:images/udpServer.png";
        }

        MouseArea{
            hoverEnabled: true;   //不用点着鼠标 就能触发 移入移出鼠标区的事件
            anchors.fill: parent  //事件响应区充满整个矩形
            propagateComposedEvents:true;  //使鼠标事件可以继续传递到子组件 防止输入文本框失效

            onDoubleClicked: {  //注意 双击时候会同时触发单机事件
                newConnDia.visible = true;
            }

            onClicked: {
                newConnDia.current = 2;
                optionsPage.clearSlect();
                imageUdpServer.source = "qrc:images/udpServer_j.png";

            }

            onExited: {
               // tcpServer.width -= 9;  Qt.binding(function)  tcpServer.parent.width
                udpServer.width = Qt.binding(Qt.binding(function(){return udpServer.parent.width}));  //动态绑定
                udpServer.height =  Qt.binding(function(){return udpServer.parent.height/4})  ;

            }

            onEntered: {
                tip.text = "ctrl + E "
                udpServer.width = tcpServer.width + 9;
                udpServer.height += 9;
            }

        }

    }

/********************************************************************************UDP客户端****************************************/
    Rectangle {
        id: udpClient;
        width: parent.width;
        height: parent.height /4;
        color: "#3ebcca";
        border.width: 0;

        anchors.left: parent.left;
        anchors.top: udpServer.bottom;

        Image {
            id: imageUdpClient;
            width: parent.width;
            height: parent.height;
            source:"qrc:images/udpClient.png";
        }

        MouseArea{
            hoverEnabled: true;   //不用点着鼠标 就能触发 移入移出鼠标区的事件
            anchors.fill: parent  //事件响应区充满整个矩形
            propagateComposedEvents:true;  //使鼠标事件可以继续传递到子组件 防止输入文本框失效

            onDoubleClicked: {  //注意 双击时候会同时触发单机事件
                newConnDia.visible = true;
            }

            onClicked: {
                newConnDia.current = 3;
                optionsPage.clearSlect();
                imageUdpClient.source = "qrc:images/udpClient_j.png";

            }

            onExited: {
               // tcpServer.width -= 9;  Qt.binding(function)  tcpServer.parent.width
                udpClient.width = Qt.binding(Qt.binding(function(){return udpClient.parent.width}));  //动态绑定
                udpClient.height =  Qt.binding(function(){return udpClient.parent.height/4})  ;

            }

            onEntered: {
                tip.text = "ctrl + Q "
                udpClient.width = udpClient.width + 9;
                udpClient.height += 9;
            }

        }

    }

}
