import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import "param/operation.js" as Op


Rectangle{
    //opacity: 0;  //大窗口完全透明  子组件也会全部透明 所以需要用到下面的办法让大背景透明化
    color: "#00ff0000";
    property var show: mess;  //双向绑定接收窗口的值

    function autoAppend(text){
        var texts = text.split("\n")

        for(var t in texts){
            mess.append(texts[t]);
        }
    }

    //接收窗口
    TextArea{
        id: mess;
        width: parent.width;
        height: parent.height *32/41;
        readOnly:true;
        font.pixelSize : 18;
        textFormat:Text.AutoText;



        style: TextAreaStyle{
            textColor: "#111";
            backgroundColor: "#eeeeee";


        }

/*
        style: TextAreaStyle{
            textColor: "#333";
            selectionColor: "#E3A05D";
            selectedTextColor: "#fff";
            backgroundColor: "#eee";

        }
*/
        anchors.left: parent.left;
        anchors.top: parent.top;


    }


    //发送窗口
    TextArea{
        id: send
        width: parent.width *7/8;
        height: parent.height *8/41;


        style: TextAreaStyle{
            textColor: "#333";
            selectionColor: "#17273c";
            selectedTextColor: "#fff";
            backgroundColor: "#f3f4f6";
        }

        anchors.left: parent.left;
        anchors.top: mess.bottom;
        anchors.topMargin: parent.height/41;

        onFocusChanged: {
            if(send.activeFocus){
                tip.text = "ctrl+enter 发送 / ctrl+d 清空"
            }
        }



    }

    //发送按钮组
    Rectangle{
        id: sendTo
        width: parent.width *1/8;
        height: parent.height *8/41;

        anchors.left: send.right;
        anchors.top: send.top;

        Button{
            id: sendBut
            text: "发送"
            width: parent.width;
            height: parent.height /2;

            anchors.top: parent.top;
            anchors.left: parent.left;
            enabled: warehouse.getConn().value.stats;

            onClicked: {
                if(warehouse.getConn().lj.sendMessage(send.text)){
                    tip.text = "发送成功";
                   // mess.append(Op.beSys( Op.getTime() + "ME: ") + Op.tidiness(send.text) )
                    autoAppend(Op.beSys( Op.getTime() + "ME: ") + Op.tidiness(send.text))
                }else{
                    tip.text = "发送失败";
                }

            }




        }


        /***************************高级功能按钮*****************************************/

        Rectangle{
            id: cycleSetting;
            width: parent.width;
            height: parent.height /2;

            anchors.top: sendBut.bottom;
            anchors.left: parent.left;

            Text {
                id: gj;
                text: "高级";
                font.pixelSize: 19;
                color: "#333";
                anchors.verticalCenter: parent.verticalCenter;
                anchors.horizontalCenter: parent.horizontalCenter;
            }



            MouseArea{
                anchors.fill: parent  //事件响应区充满整个矩形
                propagateComposedEvents:true;  //使鼠标事件可以继续传递到子组件 防止输入文本框失效
                hoverEnabled: true;


                onClicked: {


                }

                onEntered: {
                    gj.color = "#fff";
                    cycleSetting.color = "#14446a";
                }

                onExited: {
                    gj.color = "#333";
                    cycleSetting.color = "#fff";
                }



            }

        }


    }




}
