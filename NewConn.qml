import QtQuick 2.0
import QtQuick.Window 2.1
import QtQuick.Controls 2.5


Window {
    id: newConn;
    width: 500;
    height: 380;
    title: "新建连接";
    opacity: 0.85;

    minimumWidth: 480;
    minimumHeight: 350;
    maximumWidth: 500;
    maximumHeight: 380;

    property int current: 0;

    Rectangle{
        id: content;
        width: parent.width;
        height: parent.height;

        Label{
            id: keyLJLX
            text: "新建:"
            font.pixelSize: 28;

            anchors.left: parent.left;
            anchors.top: parent.top;
            anchors.leftMargin: 80;
            anchors.topMargin: 40;
        }

        ComboBox {
            id: valLJLX;
            width: 150;
            textRole: "type";  //显示的文字  这里用color属性表示文本
            currentIndex: current;
            font.pixelSize: 18;
            model: ListModel {//方式二
                id: cbItems;
                ListElement { type: "TCP服务器"}
                ListElement { type: "TCP客户端"}
                ListElement { type: "UDP服务器"}
                ListElement { type: "UDP客户端"}
            }

            anchors.left: keyLJLX.right;
          //  anchors.horizontalCenter: keyLJLX.horizontalCenter;
            anchors.verticalCenter: keyLJLX.verticalCenter;
            anchors.leftMargin: 15;

            onCurrentIndexChanged: {
                //console.debug(cbItems.get(currentIndex).type);//获取当前内容
                current = currentIndex;
            }


        }


        /*******************************************全局设置********************************************************************************
         *                                                                                                                                 *
         *                                                                                                                                 *
         *                                                                                                                                 *
         *                                                                                                                                 *
         *                                                                                                                                 *
         *                                                                                                                                 *
         *                                                                                                                                 *
         ********************************************服务器端属性******************************************************************************/
        Rectangle{
            id: setServer;
            anchors.left: keyLJLX.left;
            anchors.top: keyLJLX.bottom;
            anchors.topMargin: 35;
            visible: current == 0 || current == 2;

            Input{
                id: fwmc;
                name: "服务名称:";
                type: "name"

                anchors.left: parent.left;
                anchors.top: parent.top;
                anchors.topMargin: 10;
            }

            Input{
                id: dkdz;
                name: "端口地址:";
                type: "port"

                anchors.left: fwmc.left;
                anchors.top: fwmc.bottom;
                anchors.topMargin: 40;
            }



            ConnBtnbox{
                id: btn;
                type: "server";
                width: 350;
                height: 50;
                anchors.left: dkdz.left;
                anchors.top: dkdz.bottom;
                anchors.topMargin: 45;

            }


        }




        /*******************************************服务器属性********************************************************************************
         *                                                                                                                                 *
         *                                                                                                                                 *
         *                                                                                                                                 *
         *                                                                                                                                 *
         *                                                                                                                                 *
         *                                                                                                                                 *
         *                                                                                                                                 *
         ********************************************客户端属性******************************************************************************/



        Rectangle{
            id: setClient;
            anchors.left: keyLJLX.left;
            anchors.top: keyLJLX.bottom;
            anchors.topMargin: 35;
            visible: current == 1 || current == 3;

            Input{
                id: _LJMC;
                name: "连接名称:";
                type: "name"

                anchors.left: parent.left;
                anchors.top: parent.top;
                anchors.topMargin: 10;
            }

            Input{
                id: _MBDZ
                name: "目标地址:";
                type: "ip"

                anchors.left: _LJMC.left;
                anchors.top: _LJMC.bottom;
                anchors.topMargin: 40;
            }

            Input{
                id: _DKDZ;
                name: "端口地址:"
                type: "port"

                anchors.left: _MBDZ.left;
                anchors.top: _MBDZ.bottom;
                anchors.topMargin: 40;
            }

            ConnBtnbox{
                id: _btn
                width: 350;
                height: 50;
                type: "client"
                anchors.left: _DKDZ.left;
                anchors.top: _DKDZ.bottom;
                anchors.topMargin: 35;

            }



        }


    }


}







