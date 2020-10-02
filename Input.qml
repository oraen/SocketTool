import QtQuick 2.0
import QtQuick.Controls 2.5
import "param/operation.js" as Op

Item {
    id: input;
    property string name;
    property string text: value.text;   //需要双向绑定  当输入值时候这个text才会改
    property string type;   //可选 "ip"  "port"  "name"
    property var tip: current == 0 || current == 2?btn.tip : _btn.tip;
    property int jl;  //记录.的个数

    property var ipXZ:RegExpValidator{regExp:/((25[0-5]|2[0-4]\d|((1\d{2})|([1-9]?\d)))\.){3}(25[0-5]|2[0-4]\d|((1\d{2})|([1-9]?\d)))/}
    property var portXZ:RegExpValidator{regExp:/[0-9][0-9][0-9][0-9][0-9]/}

    Component.onCompleted: {
        if(type == "ip"){
            value.validator = ipXZ;
            value.placeholderText = "请输入目标的IP地址";
        }else if(type == "port"){
            value.validator = portXZ;
        }else if(type == "name"){
            if(tag.text == "连接名称:"){
                value.text = "新建客户端";
            }else if(tag.text == "服务名称:"){
                value.text = "新建服务器";
            }
         //   value.selectAll();


        }
    }

    Label{
        id: tag;
        text: input.name;
        font.pixelSize: 25;
    }

    TextField{  //如果没设定宽 字越多 组件越长
        id:value;
        text: input.text;//需要双向绑定  当通过程序设置text时 文本也会变
        width: 200;
        anchors.verticalCenter: tag.verticalCenter;
        anchors.left: tag.right;
        anchors.leftMargin: 5;
        property int jlPrelen;   //记录修改前的长度

        font.pixelSize:20;
        background: Rectangle{
            id: bg_value;
            border.width: 0;  //无边
        }

        Component.onCompleted: {
            input.jl = Qt.binding(getDot);
        }


        function getDot(){
            var i;
            var num=0;

            if(this.text != undefined){
                for(i = 0;i<this.text.length;i++){
                    if(this.text.charAt(i) == "."){
                        num ++;
                    }
                }
            }


            return num;
        }

        onTextEdited: {

            if(type == "name"){
                if(Op.length(this.text) > 12){
                    bg_value.border.width = 1;
                    bg_value.border.color = "#fe4365";
                    tip.color = "#ff0000";
                    tip.text = "名称过长";
                }else{
                    if(bg_value.border.color == "#fe4365"){
                        bg_value.border.width = 0;
                        tip.color = "#333";
                        tip.text = "";
                    }
                }
            }

            //端口号输入监视
            if(type == "port"){
                if((parseInt(this.text))>65535){
                    bg_value.border.width = 1;
                    bg_value.border.color = "#fe4365";
                    tip.color = "#ff0000";
                    tip.text = "端口值最多为65535";
                    console.log("警告");
                }else{
                    if(bg_value.border.width != 0){  //一个高级程序员应该为程序的性能想一想
                        bg_value.border.width = 0;
                        tip.color = "#333";
                        console.log("警告解除");
                    }

                }
            }


            //ip输入监视  独创独特智能加点引擎
            if(type == "ip"){

                var len = this.text.length;
                var ls = parseInt(value.getText(len-2,len))


                if(value.jlPrelen > len){                    //如果是删除操作   放行    使用 else防止条件传递
                    console.log("检测到删除");
                }

                else if(value.text.charAt(len-1) == "."){ //防止错误
                    console.log("检测到最后一个是.");;
                }

                else if(value.text.charAt(len-1) == "0" && value.text.charAt(len-2) == "."){
                    this.text += "."
                }

                else if(jl<3 && ls == ls){  //NaN 不等于自己
                    if(ls > 25){
                        this.text += "."
                    }

                    else if(value.text.charAt(len - 3) != "." && value.text.charAt(len - 3) != "" && value.text.charAt(len - 3) != undefined){
                        this.text += "."

                    }

                }


            }



            value.jlPrelen = value.text.length;  //记录长度

        }





    }

}
