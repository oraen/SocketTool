import QtQuick 2.0

Rectangle{
    id: warehouse;
    anchors.topMargin: this.height /6;  //经过精密的计算
    anchors.left: optionsPage.right;
    anchors.top: show.bottom;


    //property int currentPage: 0;  本来想做多页 先搁置计划先
    property int selected: 0;    //记录选择的值 默认第一个
    property variant content: [];

    //由于绑定需要 需要闭包处理
    function map(index){
        function inmap(){
            if(content[content.length - 1 -index] != undefined){
                return content[content.length - 1 -index];   //为了程序性能 选择倒插
            }else{
                return {
                    name:" ",
                    port: " ",
                    ip:" ",
                    type: 0,    //0表示未定义
                    stats: false
                }
            }
        }

        return inmap;
    }

    //通过当前的selected获取映射
    function getConn(){
        switch(selected){
            case 1:return conn0;
            case 2:return conn1;
            case 3:return conn2;
            case 4:return conn3;
            case 5:return conn4;
            case 0:return "null";
            default: {
                console.log("选择了奇怪的信息块"+ selected);
                return "error";
            }
        }
    }

    //清空所有信息块的选择标识
    function clear(){
        conn0.border.width = 1;
        conn0.border.color = "#000";
        conn1.border.width = 1;
        conn1.border.color = "#000";
        conn2.border.width = 1;
        conn2.border.color = "#000";
        conn3.border.width = 1;
        conn3.border.color = "#000";
        conn4.border.width = 1;
        conn4.border.color = "#000";
    }


    //亮化选中信息块的
    function showSlected(){
        clear();
        var selectedConnect = getConn();
        if(selectedConnect == "null"){
            console.log("没有选择消息块");
        }else if(selectedConnect == "error"){
            console.log("发生未知错误 信息块选择异常");
            Qt.quit();
        }else if(selectedConnect == undefined){
            console.log("发生未知错误 信息块空指错误");
            Qt.quit();
        }else{
            selectedConnect.border.width = 3;
            selectedConnect.border.color = "#fff";
        }

    }

    //qml可以根据自定义属性动态生成信号
    onSelectedChanged: {
        showSlected();
        modification.object = getConn().value;
    }

    onContentChanged: {
        selected = 1;
        stateWin.param = conn0.value
        showSlected()
        modification.object = getConn().value;
    }



    /*
      直接方法返回的是运行时所确定的定值 使用:的话不会起到绑定的效果
    function maps(index){
        return content[content.length - 1 -index];   //为了程序性能 选择倒插
    }
    */

    Component.onCompleted: {
        conn0.value = Qt.binding(map(0));  //注意 逻辑上这个0是这个容器给连接显示单元的标号  而index 是连接显示单元对自己的位置信息的标识  概念上不一样
        conn1.value = Qt.binding(map(1));
        conn2.value = Qt.binding(map(2));
        conn3.value = Qt.binding(map(3));
        conn4.value = Qt.binding(map(4));

        selected = 1;
        stateWin.param = conn0.value
        showSlected()

        modification.object = getConn().value;

    }

    UnitBlock{
        id: conn0;
        height: parent.height;
        width: parent.width/6;
        index: 1;

        anchors.left: parent.left;

    }

    UnitBlock{
        id: conn1;
        height: parent.height;
        width: parent.width/6;
        index: 2;

        anchors.left: conn0.right;

    }

    UnitBlock{
        id: conn2;
        height: parent.height;
        width: parent.width/6;
        index: 3;

        anchors.left: conn1.right;

    }

    UnitBlock{
        id: conn3;
        height: parent.height;
        width: parent.width/6;
        index: 4;

        anchors.left: conn2.right;

    }

    UnitBlock{
        id: conn4;
        height: parent.height;
        width: parent.width/6;
        index: 5;

        anchors.left: conn3.right;

    }



/***********************************************左边按钮组*********************************************************/
    Rectangle{
        id: pageManager;
        height: parent.height;
        width: parent.width/24;
        border.width: 1;
        anchors.left: conn4.right;

/***********************************************启动 关闭按钮*********************************************************/
        Image {
            id: imageChange;
            width: parent.width;
            height: parent.height /2;
            source: stateWin.param.stats?"qrc:images/stop.png":"qrc:images/start.png";

            MouseArea{
                hoverEnabled: true;   //不用点着鼠标 就能触发 移入移出鼠标区的事件
                anchors.fill: parent  //事件响应区充满整个矩形
                propagateComposedEvents:true;  //使鼠标事件可以继续传递到子组件 防止输入文本框失效

                onClicked: {
                    if( getConn().value != undefined){
                        if(getConn().value.stats === true){
                            getConn().stop();
                        }else{
                            getConn().start();
                        }

                    }

                }

                onExited: {
                    imageChange.width = Qt.binding(function(){return imageChange.parent.width});
                    imageChange.height = Qt.binding(function(){return imageChange.parent.height /2});
                }

                onEntered: {
                    imageChange.width +=5
                    imageChange.height +=5;
                }

            }


        }

/***********************************************属性修改按钮*********************************************************/
        Image {
            id: imageSet;
            width: parent.width;
            height: parent.height /2;
            anchors.top: imageChange.bottom;
            source: "qrc:images/change.png"

            MouseArea{
                hoverEnabled: true;   //不用点着鼠标 就能触发 移入移出鼠标区的事件
                anchors.fill: parent  //事件响应区充满整个矩形
                propagateComposedEvents:true;  //使鼠标事件可以继续传递到子组件 防止输入文本框失效

                onClicked: {
                    modification.object = {};
                    modification.object = getConn().value;
                    modification.visible = true;

                }

                onExited: {
                    imageSet.width = Qt.binding(function(){return imageSet.parent.width});
                    imageSet.height = Qt.binding(function(){return imageSet.parent.height /2});
                }

                onEntered: {
                    imageSet.width +=5
                    imageSet.height +=5;
                }

            }
        }

    }


    /***********************************************新建连接按钮*********************************************************/
    Rectangle{
        id: newPro;
        height: parent.height;
        width: parent.width*3/24;
        border.width: 1;
        color: "#1c7887"

        anchors.left: pageManager.right;

        Text {
            id: newConn
            text: "新建连接"
            font.pixelSize: 23
            color: "#eee"
            font.bold: true;

            anchors.verticalCenter: parent.verticalCenter;
            anchors.horizontalCenter: parent.horizontalCenter;
        }

        MouseArea{
            hoverEnabled: true;   //不用点着鼠标 就能触发 移入移出鼠标区的事件
            anchors.fill: parent  //事件响应区充满整个矩形
            propagateComposedEvents:true;  //使鼠标事件可以继续传递到子组件 防止输入文本框失效

            onClicked: {
                newConnDia.visible = true;
            }

            onExited: {
                //鼠标移出
                newConn.font.pixelSize = 23;
                newConn.color = "#eee";

            }

            onEntered: {
                //鼠标移入
                newConn.font.pixelSize = 26;
                newConn.color = "#fff";
                tip.text = "ctrl + N "
            }

        }

    }

}
