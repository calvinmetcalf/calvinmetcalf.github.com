/* Author:
Calvin Metcalf
*/
//var eURL = 'http://baystatebikeweek.org/events/rss/';
var eURL = 'calvinmetcalf.github.com/bf.xml';
var vEE;
 var yqlurl = 'http://query.yahooapis.com/v1/public/yql?format=json&q=select%20*%20from%20xml%20where%20url%3D';


$(function() {
$.get(yqlurl + "'" + encodeURIComponent(eURL) + "'",
        function(data){
           vEE = data.query.results.rss.channel.item;
           var z = 1;
             $.each(vEE,function(i,ev){
                 var today = new Date();
                 var sat = new Date(2012,4,20);
                 var pts = ev.description.split("<br/>");
                 var date = pts[0];
                 var time = date.split(' - ')[1];
                 var day = date.split(' - ')[0].split(' ');
                 var d  = new Date('2012 ' + day[1].replace('Aug', 'August').replace('Jun', 'June').replace('Apr', 'April') + ' ' + day[0] + ' ' + time);
                 if((d>=today)&&(d<sat))
                 {
                 var stuff = '<tr><td>' + z++ + '</td><td>' + ev.title + '</td><td>' + d.toDateString() + '</td><td>' + d.toLocaleTimeString() + '</td><td>' + pts[1] + '</td><td>' + pts[2] + '</td><td>' + pts[3] +'</td><td><a href="' + ev.link + '" target="_blank">more info</a></td></tr>';
                 
                 $('.events').append(stuff);
                 };
             }
            );
             $(".table").tablesorter({ 
            headers: { 
                2: { 
                    sorter:'date' 
                } 
            },
            sortList: [[2,0]]
        });
        },"jsonp");
      
});
$.tablesorter.addParser({
id: 'date',
is: function(s) { 
            // return false so this parser is not auto detected 
            return false; 
        }, 
        format: function(s) { 
            
            // format your data for normalization 
           return Date.parse(s);
        }, 
        // set type, either numeric or text 
        type: 'numeric' 
});
