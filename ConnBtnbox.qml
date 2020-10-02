import QtQuick 2.0
import QtQuick.Controls 2.5
import "param/operation.js" as Op

Item {  
    id: content;
    property string type: "server";  //可选 server client
    property var tip: _tip;

    Timer{
            id:recover;
            interval: 500;
            repeat: false;
            triggeredOnStart: false;

            onTriggered: {
                textQD.color = "white";
                textQX.color = "white";

                qd.color = "#e58308";
                qx.color = "#407434";
            }

    }

    /************************************************确定按钮*************************************************************/

    Rectangle{
        id: qd;
        color: "#e58308";
        width: 170;
        height: 50;

        Label{
            id: textQD;
            color: "white"
            font.bold: true;
            text: "确定"
            font.pixelSize: 30;

            anchors.verticalCenter: parent.verticalCenter;    //垂直中心线 是一条水平线s
            anchors.horizontalCenter: parent.horizontalCenter;  //水平中心线是中间的竖直线
            anchors.leftMargin: 30;
        }

        MouseArea{
            anchors.fill: parent  //事件响应区充满整个矩形
            hoverEnabled: true;   //不用点着鼠标 就能触发 移入移出鼠标区的事件
            propagateComposedEvents:true;

            onClicked: {
                qd.color="#dc5711";
                recover.start();

                if(current == 0 || current == 2){
                    if(Op.length(fwmc.text) > 12){
                        tip.color = "#ff0000";
                        tip.text = "名称长度不超过12 中文算两个字符";

                    }else if((parseInt(dkdz.text)) > 65535 || dkdz.text == ""){
                        tip.color = "#ff0000";
                        tip.text = "端口值无效";

                    }else{
                        var newServer = {
                            name:fwmc.text,
                            port: dkdz.text,
                            type: 1,    //1为服务器
                            stats:false
                        }

                        allConn.push(newServer);  //push操作 是对象内部的变化 不属于值变更 不会直接触发修改绑定机制 所以需要下面的步骤
                        allConn = allConn;


                        tip.color = "#333";
                        tip.text = "";
                        newConn.visible = false;

                    }

                }else if(current == 1 || current == 3){ /*************************************客户端***********************************/
                    if(Op.length(_LJMC.text) > 12){
                        tip.color = "#ff0000";
                        tip.text = "名称长度不超过12 中文算两个字符";

                    }else if((parseInt(_DKDZ.text)) > 65535 || _DKDZ.text == ""){
                        tip.color = "#ff0000";
                        tip.text = "端口值无效";

                    }else if(_MBDZ.jl !=3 || _MBDZ.text.charAt(_MBDZ.text.length-1) == "."){
                        tip.color = "#ff0000";
                        tip.text = "ip地址无效";
                    }else{
                        var newServer = {
                            name:_LJMC.text,
                            port: _DKDZ.text,
                            ip: _MBDZ.text,
                            type: 2,    //1为服务器
                            stats:false
                        }

                        allConn.push(newServer);  //push操作 是对象内部的变化 不属于值变更 不会直接触发修改绑定机制 所以需要下面的步骤
                        allConn = allConn;


                        tip.color = "#333";
                        tip.text = "";
                        newConn.visible = false;

                    }
                }

            }

            onExited: {
                qd.width = 170;
                qd.height = 50;
            }

            onEntered: {
                qd.width = 172;
                qd.height = 52;
                textQD.color = "#e3e6c3";
                recover.start();
            }

        }

    }


/**********************************************************取消按钮*********************************************/


    Rectangle{
        id: qx
        color: "#407434"
        width: 170;
        height: 50;
        anchors.left: qd.right;
        anchors.verticalCenter: qd.verticalCenter;

        Label{
            id: textQX;
            color: "white"
            font.bold: true;
            text: "取消"
            font.pixelSize: 30;

            anchors.verticalCenter: parent.verticalCenter;    //垂直中心线 是一条水平线s
            anchors.horizontalCenter: parent.horizontalCenter;  //水平中心线是中间的竖直线
        }

        MouseArea{
            anchors.fill: parent  //事件响应区充满整个矩形
            hoverEnabled: true;   //不用点着鼠标 就能触发 移入移出鼠标区的事件
            propagateComposedEvents:true;

            onClicked: {
                //Qt.quit(); 关闭整个程序
                newConn.visible = false;

            }

            onExited: {
                qx.width = 170;
                qx.height = 50;

            }

            onEntered: {
                qx.width = 172;
                qx.height = 52;
                textQX.color = "#e3e6c3";
                recover.start();

            }

        }
    }

    /*********************************提示框************************************************************/
    Label{
        id: _tip;
        text: "端口值最多为65535";
        font.pixelSize: 17;
        color: "#333"

        anchors.left: qd.left;
        anchors.top: qd.bottom;
        anchors.topMargin: 10;
    }
}



