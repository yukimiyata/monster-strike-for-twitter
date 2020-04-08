window.addEventListener('load', function() {
    let post_number = location.href.split("/")[location.href.split("/").length - 1];
    setInterval(() => {
        $.ajax({
            url: "/api/joins",
            type: "GET",
            data: { id: post_number },
            dataType: "json"
        }).done(function(joins){
            let joins_result = joins.joins_sum;
            for(let i = 0; i < joins_result.length; i++){
                let recruit_id = joins_result[i][0];
                let recruit_tag = "recruit-number-" + recruit_id;
                let result_tag = document.getElementById(recruit_tag);
                result_tag.textContent = joins_result[i][1];
                if (joins_result[i][2]) {
                    let start_tag = "start-game-" + recruit_id;
                    let start_button = document.getElementById(start_tag);
                    start_button.href = "/judges/" + joins.post_id;
                    start_button.textContent = "出撃する！";
                }
            }
        }).fail(function (joins) {
        });
    }, 2000);
});