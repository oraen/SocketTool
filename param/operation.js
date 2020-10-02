.pragma library
//获取字符长度 中文算2个单位
function length(text) {
    var len = 0;
      for (var i=0; i<text.length; i++) {
        if (text.charCodeAt(i)>127 || text.charCodeAt(i)==94) {
           len += 2;
         } else {
           len ++;
         }
       }
    return len;

}

//获取时间的字符串
function getTime(){
    function process(v){
        if(v <10){
            return "0" + v;
        }else{
            return v.toString()
        }
    }

    var t = new Date();
    var str =  process(t.getFullYear())+"-"+ process((t.getMonth()+1))+"-"+ process(t.getDate())+" "+ process(t.getHours())+":"+ process(t.getMinutes())+":"+ process(t.getSeconds())+" / ";
    return str;
}


function tidiness(t){
    var temp = "";
    for(var i =0 ;i<t.length; i++){
        if(t[i] != "\n"){
            temp += t[i]
        }else{
            temp += t[i] + "                          "                    //window回车是\r\n 每个都能单独起换行作用
        }
    }

    return temp;
}

function beSys(text){

    return '<font color="#458994">' + text +'</font>';
}





















