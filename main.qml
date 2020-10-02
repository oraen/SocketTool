import QtQuick.Window 2.1
import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import "param/data.js" as Data



Window {
    property var allConn: Data.connectStore;
    property var messText: ["","","","",""]  //五个窗口的信息
    id: win;
    visible: true;
    width: 1300;
    height: 680;
    title: "SOKCET网络调试助手";
    opacity: 1;   //主窗口不透明

    NewConn{
        id: newConnDia;
        current: 0;
    }

    PropertyWin{
        id:modification;
        visible: false;
    }

    //总窗口容器
    Rectangle {
        id: mainContent;
        width: parent.width;
        height: parent.height;
        color: "#a7dce0";


        //左边的选择栏
        OptionsBar{
            id: optionsPage;
            width: parent.width /6;
            height: parent.height;
            anchors.left: parent.left;
        }

        /*****************************************************工作区界面********************************************************/
        Rectangle {
            id: show;
            width: parent.width *5/6;
            height: parent.height *5/6;
            radius: 25;
            Image {
                id: imageBackground;
                width: parent.width;
                height: parent.height;
                source: "qrc:images/background.png"
            }
            /*通过这个办法再经过处理可以使图片旋转 改变渐变方向 但是太烦了
              rotation: 90
              transformOrigin: "Center"
              下面的方法更加正常

             太难看已被废弃
            LinearGradient {
                anchors.fill: parent
                start: Qt.point(0, 0)
                end: Qt.point(this.width, 0)
                gradient: Gradient {
                    GradientStop { position: 0.0; color: "#00141e" }
                    GradientStop { position: 0.3; color: "#00314f" }
                    GradientStop { position: 0.6; color: "#1c7887" }
                    GradientStop { position: 1.0; color: "#26bcd5" }
                }
            }
           */
            anchors.right: parent.right;

            //右方信息栏
            StateWin{
                id: stateWin;
                width: parent.width /5;
                height: parent.height *5/6;
                border.width: 2;

                anchors.rightMargin: this.height /24;
                anchors.topMargin: this.height /18;
                anchors.right: parent.right;
                anchors.top: parent.top;
            }

            //收发窗口
            Transceiver{
                id: sendAndReceive;
                width: parent.width *2/3;
                height: parent.height *41/48;

                anchors.left: parent.left;
                anchors.top: parent.top;
                anchors.leftMargin: parent.width /15;
                anchors.topMargin: parent.height/18;
            }

            //提示文本
            Text{
                id: tip;
                text: "ctrl + A";
                font.bold: true;
                font.pixelSize : 19;
                color: "#fff";

                anchors.left: parent.left;
                anchors.top: sendAndReceive.bottom;
                anchors.leftMargin: parent.width /20;
                anchors.topMargin: parent.height/18;

            }

        }

/*************************项目栏****************************************************************************************************/
        WareHouse{
            id: warehouse;
            width: parent.width *5/6;    //经过精密的计算
            height: parent.height /7;    //经过精密的计算

            anchors.topMargin: this.height/6;  //经过精密的计算
            anchors.left: optionsPage.right;
            anchors.top: show.bottom;

            content: allConn;  //住 从js拿出来的文件相当于常量 不会绑定 不能直接 content: Data.connectStore
        }

    }


}

