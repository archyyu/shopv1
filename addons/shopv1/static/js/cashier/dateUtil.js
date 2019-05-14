
var DateUtil = {
    parseTime(time, dataformat) {
        if(time){
            return moment(time * 1000).format(dataformat);
        }
        return '';
    },
    
    parseTimeInYmdHms(time) {
        if(time == undefined){
            return "";
        }
        if(time == 0){
            return "";
        }
        return moment(time * 1000).format("YYYY-MM-DD HH:mm:ss");
    },
    
    timeSpanFrom(time) {
        
        if(time==undefined){
            return "";
        }
        
        if(time == 0){
            return "";
        }

        let span = parseInt(moment.now() / 1000 - time);

        let des = "";

        if (parseInt(span / (24 * 60 * 60)) > 0) {
            des += parseInt(span / (24 * 60 * 60)) + "天";
        }

        if (parseInt(span / (60 * 60)) > 0) {
            des += parseInt(span / (60 * 60)) + "小时";
        }

        if (parseInt((span / 60) % 60) > 0) {
            des += parseInt((span / 60) % 60) + "分";
        }

        if (parseInt(span % 60) > 0) {
            des += parseInt(span % 60) + "秒";
        }

        return des;
    },
    
    rangeTime(time) {
        if(time){
            let rangeTime = moment.duration(moment().diff(moment(time * 1000)));
            console.log(rangeTime.asDays())
            let asDays = parseInt(rangeTime.asDays());
            let days = asDays > 0 ? asDays + '天' : '';
            let hours = rangeTime.hours().toString().padStart(2, '0');
            let minutes = rangeTime.minutes().toString().padStart(2, '0');
            let seconds = rangeTime.seconds().toString().padStart(2, '0');
            return `${days}${hours}时${minutes}分${seconds}秒`;
        }
        return '';
    }
};
