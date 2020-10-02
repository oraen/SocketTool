import QtQuick 2.0
import QtQuick.Controls 2.5


Rectangle {
    property var param: ({
        className: "StateWin",
        name: "新建连接",
        type: 1,
        host: "127.0.0.1",
        myPort: "- - - -",
        ip: "- - - -",
        port: "- - - -",
        stats: false

    })

    //对闯传入的连接块消息进行加工
    function process(param){
        var processedParam ={};
        processedParam = {
            className: "StateWin",
            name: "新建连接",
            type: 1,
            host: "127.0.0.1",
            myPort: "- - - -",
            ip: "- - - -",
            port: "- - - -",
            stats: false

        }
        if(param != undefined){
            processedParam.name = param.name;
            processedParam.type = param.type;
            if(param.type == 1 || param.type == 3){
                processedParam.myPort = param.port;
                processedParam.stats = param.stats;
            }else if(param.type == 2 || param.type == 4){
                processedParam.ip = param.ip;
                processedParam.port = param.port;
                processedParam.stats = param.stats;
            }
        }


        return processedParam;
    }

    function resolver(){
        switch(param.type){
            case 1:return "TCP服务器";
            case 2:return "TCP客户端";
            case 3:return "UDP服务器";
            case 4:return "UDP客户端";
            case 0:return "暂未选职责";
            default: {
                console.log("解析错误");
                Qt.quit();
            }
        }
    }

    onParamChanged: {
        if(param == undefined){
            param = {
                className: "StateWin",
                name: "新建连接",
                type: 1,
                host: "127.0.0.1",
                myPort: "- - - -",
                ip: "- - - -",
                port: "- - - -",
                stats: false
            }
        }

        if(param.className != "StateWin"){        //如果类型不对 做类型变换
            param =  process(param);
        }
    }

    Component.onCompleted: {
        valLJLX.text =  Qt.binding(resolver)
    }


    Label{
        id: keyLJBS;
        text: "标识:";

        anchors.top: parent.top;
        anchors.left: parent.left;
        anchors.topMargin: parent.height/18;
        anchors.leftMargin: parent.width/18;
    }

    Label{
        id: valLJBS;
        text: param.name;

        anchors.top: keyLJBS.top;
        anchors.left: keyLJBS.right;
        anchors.leftMargin: parent.width/36;

    }


    Label{
        id: keyLJLX
        text: "类型:"

        anchors.top: keyLJBS.bottom;
        anchors.left: keyLJBS.left;
        anchors.topMargin: parent.height/60;

    }
    Label{
        id: valLJLX

        anchors.top: keyLJLX.top;
        anchors.left: keyLJLX.right;
        anchors.leftMargin: parent.width/36;

    }


    Label{
        id: keyBJDZ
        text: "本机地址:"

        anchors.top: keyLJLX.bottom;
        anchors.left: keyLJLX.left;
        anchors.topMargin: parent.height/30;

    }
    Label{
        id: valBJDZ
        text: param.host

        anchors.top: keyBJDZ.top;
        anchors.left: keyBJDZ.right;
        anchors.leftMargin: parent.width/36;

    }


    Label{
        id: keyBJDK
        text: "本机端口:"

        anchors.top: keyBJDZ.bottom;
        anchors.left: keyBJDZ.left;
        anchors.topMargin: parent.height/60;

    }
    Label{
        id: valBJDK
        text: param.myPort;

        anchors.top: keyBJDK.top;
        anchors.left: keyBJDK.right;
        anchors.leftMargin: parent.width/36;

    }


    Label{
        id: keyMBDZ
        text: "目标地址:"

        anchors.top: keyBJDK.bottom;
        anchors.left: keyBJDZ.left;
        anchors.topMargin: parent.height/30;

    }
    Label{
        id: valMBDZ
        text: param.ip

        anchors.top: keyMBDZ.top;
        anchors.left: keyMBDZ.right;
        anchors.leftMargin: parent.width/36;

    }


    Label{
        id: keyMBDK
        text: "目标端口:"

        anchors.top: keyMBDZ.bottom;
        anchors.left: keyMBDZ.left;
        anchors.topMargin: parent.height/60;

    }
    Label{
        id: valMBDK
        text: param.port

        anchors.top: keyMBDK.top;
        anchors.left: keyMBDK.right;
        anchors.leftMargin: parent.width/36;

    }


    Label{
        id: keyZT
        text: "状态: "

        anchors.top: keyMBDK.bottom;
        anchors.left: keyMBDK.left;
        anchors.topMargin: parent.height/30;

    }
    Label{
        id: valZT
        text: param.stats?"已连接":"未连接";

        color: "#ff0000"


        anchors.top: keyZT.top;
        anchors.left: keyZT.right;
        anchors.leftMargin: parent.width/36;
    }


    Label{
        id: gyzz;
        text: "关于作者";

        anchors.bottom: parent.bottom;
        anchors.horizontalCenter: parent.horizontalCenter;
        anchors.bottomMargin: parent.height /30;
    }
}









