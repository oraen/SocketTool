import QtQuick 2.0
import QtQuick.Window 2.1
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.5




Window {
    id: main;
    width: 600;
    height: 275;
    title: "属性值设置";

    property var object;

    Timer{

        id:shake;
        interval: 25;
        repeat: true;
        triggeredOnStart: true;
        property int jilu: 0

        onTriggered: {
            if(jilu % 2 == 0){
                main.x -= 15;
            }else{
                main.x += 15;
            }
            jilu++;
            if(jilu > 9){
                jilu = 0;
                this.stop();
            }
        }

    }


    onObjectChanged: {
        if(object == undefined) object = {};
        if(object.name == undefined) object.name = "";
        if(object.ip == undefined) object.ip = "";
        if(object.port == undefined) object.port = "";

        tName.text = object.name;
        tIp.text = object.ip;
        tPort.text = object.port;

        if(relolver(0) != undefined){
            relolver(0).checked = true;
        }

    }

    function relolver(schema){    //schema 0为正向解析 根据object类型 返回对应按钮    1为反向解析通过输入 一个按钮 返回数字
        if(schema == 0){
            switch(object.type){
                case 1: return tcpS;
                case 2: return tcpC;
                case 3: return udpS;
                case 4: return udpC;
                default: return undefined
            }
        }else{
            switch(choose.checkedButton){
                case tcpS: return 1;
                case tcpC: return 2;
                case udpS: return 3;
                case udpC: return 4;
                default: return 0;
            }
        }
    }


    /*
      好像是由于在本文框修改值相当于 = 操作 本文框暂时解除了对object的绑定
      以下方法不能实现 重新开启窗口时候值得更新  只能在按钮上做手脚

    onVisibleChanged: {
        var k = warehouse.getConn().value;
        object =  k;
    }
    */

    Rectangle{
        width: parent.width;
        height: parent.height;
        anchors.left: parent.left;
        anchors.top: parent.top;
        anchors.leftMargin: 20;
        anchors.topMargin: 20;



        RowLayout {
            id: vivi;
            width: 450;
            height: 50;

            anchors.left: parent.left;
            anchors.top: parent.top;
            anchors.leftMargin: 30;

            ButtonGroup{
                id: choose;

                onCheckedButtonChanged: {
                    var temp = object;
                    temp.type = relolver(1);
                    object = temp;   //变而不赋
                }

            }

            RadioButton {
                id:tcpS;
                text: "TCP服务器";
                ButtonGroup.group: choose;
            }

            RadioButton {
                id:tcpC;
             //   checked: true;
                text: "TCP客户端";
                ButtonGroup.group: choose;
            }

            RadioButton {
                id:udpS;
                text: "UDP服务器";
                ButtonGroup.group: choose;
            }

            RadioButton {
                id:udpC;
                text: "UDP客户端";
                ButtonGroup.group: choose;
            }


        }


        Rectangle{
            id: value;
            width: 400;
            height: 150;

            anchors.left: vivi.left;
            anchors.top: vivi.bottom;


            PropertyInput{
                id: tName;
                name: "连接名称:";
                type:"name"
                text: object.name;

                anchors.left: parent.left;
                anchors.top: parent.top;
                anchors.leftMargin: 20;
                anchors.topMargin: 20;

            }

            PropertyInput{
                id: tPort;
                name: "  端口号:";
                type:"port"
                text:object.port

                anchors.left: tName.left;
                anchors.top: tName.bottom;
                anchors.topMargin: 10;

            }

            PropertyInput{
                id: tIp;
                name: "  IP地址:";
                type:"ip"
                text: object.ip
                isEnabled:  object.type == 2 || object.type == 4

                anchors.left: tPort.left;
                anchors.top: tPort.bottom;
                anchors.topMargin: 10;

            }
        }


        Rectangle{
            id: qd;
            width: 75;
            height: 125;
            color: "#e58308"
            radius: 35;
            border.width: 4;

            anchors.left: value.right;
            anchors.verticalCenter: value.verticalCenter;

            MouseArea{
                anchors.fill: parent  //事件响应区充满整个矩形
                hoverEnabled: true;   //不用点着鼠标 就能触发 移入移出鼠标区的事件
                propagateComposedEvents:true;

                onEntered: {
                    qd.width = 80;
                    qd.height = 130
                    qd.color = "#fc9d9a";
                }

                onExited: {
                    qd.width = 75;
                    qd.height = 125;
                    qd.color = "#e58308";
                }

                onPressed: {
                    qd.width -= 10;
                    qd.height -= 10
                }

                onReleased: {
                    qd.width += 10;
                    qd.height += 10
                }

                onClicked: {
                    if(tName.error + tPort.error +tIp.error == 0){
                        var temp = warehouse.getConn().value;
                        temp.name = tName.text;
                        temp.port = tPort.text;
                        temp.ip = tIp.text;
                        temp.type = relolver(1);
                        warehouse.getConn().value = temp;
                        main.visible = false;
                    }else{
                        shake.start();
                    }

                }
            }

        }
    }


}



