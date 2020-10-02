import QtQuick 2.0
import QtQuick.Controls 1.4
import "param/operation.js" as Op

Rectangle {
    id: main;
    width: 350;
    height: 25;
    property string name;
    property string text;
    property string hint;
    property string type;         //目前支持选用 ip port name
    property int error:0;  //0表示没错误
    property bool isEnabled: true;

    property var ipXZ:RegExpValidator{regExp:/((25[0-5]|2[0-4]\d|((1\d{2})|([1-9]?\d)))\.){3}(25[0-5]|2[0-4]\d|((1\d{2})|([1-9]?\d)))/}
    property var portXZ:RegExpValidator{regExp:/[0-9][0-9][0-9][0-9][0-9]/}


    Component.onCompleted: {

        if(type == "ip"){
            value.validator = ipXZ;
        }else if(type == "port"){
            value.validator = portXZ;
        }

        value.onTextChanged.connect(value.enabledChanged)        //信号连接方法 value触发onTextChanged时也会调用enabledChanged() (信号也可连接方法)



    }

    onTextChanged: {
        value.text = main.text;



    }


    Text{
        id: name
        text: main.name;
        font.pixelSize: 22;
        width: 100;

    }

    TextField{
        id: value;
        text: main.text;

        anchors.left: name.right;
        anchors.verticalCenter: name.verticalCenter;
        anchors.leftMargin: 4;
        font.pixelSize: 21;
        enabled: main.isEnabled;

        //当true变true  false变false时该函数不会触发
        onEnabledChanged: {
            if(type == "ip"){
                var temp = this.text.split(".");
                if(enabled){
                    if(temp.length <4 || this.text[this.text.length-1] == "."){
                        hint.color = "#ff0000";
                        hint.text = "ip地址无效";
                        error = 1;

                    }else{
                        if(hint.text == "ip地址无效"){
                            hint.color = "#333";
                            hint.text = "";
                            error = 0;
                        }
                    }
                }else{
                    hint.color = "#333";
                    hint.text = "";
                    error = 0;
                }
            }

        }

        onTextChanged: {
            main.text = value.text;

            if(type == "name"){
                if(Op.length(this.text) > 12){
                    hint.color = "#ff0000";
                    hint.text = "名称过长";
                    error = 1
                }else{
                    if(hint.color == "#ff0000"){
                        hint.color = "#333";
                        hint.text = "";
                        error = 0;
                    }
                }
            }

            //端口号输入监视
            if(type == "port"){
                if((parseInt(this.text))>65535 || this.text == ""){

                    hint.color = "#ff0000";
                    hint.text = "无效的端口号";
                    error = 1;
                }else{
                    if(hint.color == "#ff0000"){
                        hint.color = "#333";
                        hint.text = "";
                        error = 0;
                    }
                }
            }


            //ip输入监视
            if(type == "ip"){
                var temp = this.text.split(".");
                if(temp.length <4 || this.text[this.text.length-1] == "."){
                    hint.color = "#ff0000";
                    hint.text = "ip地址无效";
                    error = 1;
                }else{
                    if(hint.text == "ip地址无效"){
                        hint.color = "#333";
                        hint.text = "";
                        error = 0;
                    }
                }





            }



        }
    }

    Text{
        id:hint;
        text: main.hint;
        font.pixelSize: 16;

        anchors.left: value.right;
        anchors.verticalCenter: value.verticalCenter;
        anchors.leftMargin: 4;
    }

}
