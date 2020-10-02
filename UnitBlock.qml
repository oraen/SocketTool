import oraen.myTcpConnect 1.0
import QtQuick 2.12
import "param/operation.js" as Op

Rectangle{
    border.width: 1;
    property variant lj:tcpsocket;

    TcpSocket{
        id:tcpsocket;
    }

    //variant内部用qt的Qvariant  var用jascript的对象   传入对象时 不能直接用{}因为{}是一个方法  要用小括号括起来({})
    property var value:({  //未指定传入时的默认值
        className = "UnitBlock",
        name:" ",
        port: " ",
        ip:" ",
        type: 0,    //0表示未定义
        stats: false

    })

    property int index: 0;

    function start(){
        if(value != undefined && value.type !== 0){
            if(tcpsocket.connect(value.ip,value.port)){
                value.stats = true;
                value=value;  //触发绑定机制
                tip.text = "连接成功"
            }else{
                tip.text = "连接失败"
            }
        }
    }

    function stop(){
        if(value != undefined && value.type !== 0){
            tcpsocket.close();
            value.stats = false;
            value=value;  //触发绑定机制

        }

    }

    //设置为被选中状态
    function setSelceted(){
        if(index === 0){
            console.log("未知错误! 无效的索引 未配置的信息块");
            Qt.quit();
        }else if(value.type === 0){
            console.log("选中空白的信息块");
        }else{
            warehouse.selected = index;
        }
    }

    function showMessage(){
        sendAndReceive.autoAppend( Op.beSys(Op.getTime() + "SR: ") + Op.tidiness(tcpsocket.receiveMesage()));

    }


    Component.onCompleted: {
        //QObject::connect(tcpSocket,SIGNAL(readyRead()),this,SLOT(handleData()));
        tcpsocket.hasRead.connect(showMessage)
    }



    //每次值变的(包括初始化)时候做安全验证  Component.onCompleted方法只会在创建时调用 不能符合要求
    onValueChanged: {
        if(value == undefined){

            /* 不能这样 用等号赋值会直接解除绑定
            value = {
                name:" ",
                port: " ",
                ip:" ",
                type: 0,    //0表示未定义
                stats: false
            }
            */
            tip.text = "发生未知错误 连接中有无效值"
        }else{
            if(value.ip == undefined){
                value.ip = "- - - -"
            }
        }

        stateWin.param = value;
    }


//#f2f5d0    f9957f
    gradient: Gradient{//颜色渐变
        GradientStop { position: 0.0; color: value.stats?"#f2f5d0":"lightsteelblue" }
        GradientStop { position: 1.0; color: value.stats?"#f9957f":"#458994" }

    }



    Text {
        id: name
        text: value.name;
        color: "#fff";
        font.pixelSize: 22;
        font.bold: true;

        anchors.horizontalCenter: parent.horizontalCenter;
        anchors.top: parent.top;
        anchors.topMargin: parent.height /8
    }

    Text {
        id: port;
        text: value.port;
        color: "#fff";
        font.pixelSize: value.type == 1 || value.type == 3 ? 24 : 19;

        anchors.horizontalCenter: parent.horizontalCenter;
        anchors.top: name.bottom;
        anchors.topMargin: value.type == 1 || value.type == 3 ? parent.height /5:parent.height /20;
    }

    Text {
        id: ip;
        visible: value.type == 2 || value.type == 4;
        text: value.ip;
        color: "#fff";
        font.pixelSize: 19;

        anchors.horizontalCenter: parent.horizontalCenter;
        anchors.top: port.bottom;
        anchors.topMargin: parent.height /20;
    }



    MouseArea{
        hoverEnabled: true;   //不用点着鼠标 就能触发 移入移出鼠标区的事件
        anchors.fill: parent  //事件响应区充满整个矩形
        propagateComposedEvents:true;  //使鼠标事件可以继续传递到子组件 防止输入文本框失效
        acceptedButtons:  Qt.RightButton | Qt.LeftButton | Qt.MidButton   //接受左键中键右键

        onClicked: {
            win.messText[warehouse.getConn().index] = sendAndReceive.show.text;

            setSelceted();
            stateWin.param = value;
            if(mouse.button == Qt.RightButton && value.type !== 0){
                modification.visible = true;
            }

            sendAndReceive.show.text = win.messText[index];



        }


        onDoubleClicked: {
            if(value.type === 0){
                console.log("无法启动空代码块")
            }else{
                if(value.stats === true){
                    stop();
                }else{
                    start();
                }
            }
        }

        onExited: {
            name.font.pixelSize = 22;

        }

        onEntered: {
            tip.text = "ctrl + " + index;
            name.font.pixelSize = 25;
        }

    }

}
